// liv/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'SERVER_ADDRESS', obfuscate: true)
    static final serverAddress = _Env.serverAddress;
    @EnviedField(varName: 'PORT', obfuscate: true)
    static final port = _Env.port;
    @EnviedField(varName: 'DB_HOST', obfuscate: true)
    static final dbHost = _Env.dbHost;
    @EnviedField(varName: 'DB_PORT', obfuscate: true)
    static final dbPort = _Env.dbPort;
    @EnviedField(varName: 'DB_USER', obfuscate: true)
    static final dbUser = _Env.dbUser;
    @EnviedField(varName: 'DB_PASSWORD', obfuscate: true)
    static final dbPassword = _Env.dbPassword;
    @EnviedField(varName: 'DB_SCHEMA', obfuscate: true)
    static final dbSchema = _Env.dbSchema;
    @EnviedField(varName: 'JWT_KEY', obfuscate: true)
    static final jwtKey = _Env.jwtKey;
}