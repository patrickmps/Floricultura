import 'package:shelf/shelf.dart';
import 'package:web_api/env/env.dart';

// import '../../utils/custom_env.dart';
import 'security_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      'iat': DateTime.now().microsecondsSinceEpoch,
      'userID': userID,
      'roles': ['admin', 'user'],
    });

    String key = Env.jwtKey;
    String token = jwt.sign(SecretKey(key));

    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = Env.jwtKey;
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        String? authorizationHeader = req.headers['Authorization'];

        JWT? jwt;

        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith('Bearer ')) {
            String token = authorizationHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }

        var request = req.change(context: {'jwt': jwt});

        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJwt => createMiddleware(requestHandler: (Request req) {
        if (req.context['jwt'] == null) {
          return Response.unauthorized('Not Authorized');
        }
        return null;
      });
}
