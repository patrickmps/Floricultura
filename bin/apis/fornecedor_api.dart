// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';
import '../utils/custom_xml.dart';
import '../models/fornecedor.dart';
import '../services/fornecedor_service.dart';
import 'api.dart';

class FornecedorApi extends Api {
  final FornecedorService _fornecedorService;
  FornecedorApi(this._fornecedorService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get('/loja/fornecedor', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      String? format = req.url.queryParameters['format'];
      Fornecedor? fornecedor = await _fornecedorService.findOne(int.parse(id));
      if (fornecedor == null) return Response(400);

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> fornecedoresXml = [fornecedor.toXml()];
        return Response(200,
            body: CustomXml.toResponseXml(fornecedoresXml, 'Fornecedores'));
      }

      return Response(200, body: fornecedor.toJson());
    });

    router.get('/loja/fornecedores', (Request req) async {
      String? format = req.url.queryParameters['format'];
      List<Fornecedor> fornecedores = await _fornecedorService.findAll();

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> fornecedoresXml =
            fornecedores.map((e) => e.toXml()).toList();
        return Response(200,
            body: CustomXml.toResponseXml(fornecedoresXml, 'Fornecedores'));
      }

      List<Map<String, dynamic>> fornecedoresJson =
          fornecedores.map((e) => e.toMap()).toList();
      return Response(200, body: jsonEncode(fornecedoresJson));
    });

    router.post('/loja/fornecedores', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('fornecedor').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.text.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var fornecedor = Fornecedor.fromRequest(map);

        var result = await _fornecedorService.save(fornecedor);
        return Response(result);
      }

      var fornecedor =
          Fornecedor.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _fornecedorService.save(fornecedor);

      return Response(result);
    });

    router.put('/loja/fornecedores', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('fornecedor').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.text.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var fornecedor = Fornecedor.fromRequest(map);
        var result = await _fornecedorService.save(fornecedor);

        return Response(result);
      }

      var fornecedor =
          Fornecedor.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _fornecedorService.save(fornecedor);

      return Response(result);
    });

    router.delete('/loja/fornecedores', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _fornecedorService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
