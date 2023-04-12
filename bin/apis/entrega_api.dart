import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';
import '../models/entrega.dart';
import '../services/entrega_service.dart';
import '../utils/custom_xml.dart';
import 'api.dart';

class EntregaApi extends Api {
  final EntregaService _entregaService;
  EntregaApi(this._entregaService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();
    router.get('/loja/entrega', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      String? format = req.url.queryParameters['format'];
      Entrega? entrega = await _entregaService.findOne(int.parse(id));
      if (entrega == null) return Response(400);

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> entregasXml = [entrega.toXml()];
        return Response(200,
            body: CustomXml.toResponseXml(entregasXml, 'Entregas'));
      }

      return Response(200, body: entrega.toJson());
    });

    router.get('/loja/entregas', (Request req) async {
      String? format = req.url.queryParameters['format'];
      List<Entrega> entregas = await _entregaService.findAll();

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> entregasXml = entregas.map((e) => e.toXml()).toList();
        return Response(200,
            body: CustomXml.toResponseXml(entregasXml, 'Entregas'));
      }

      List<Map<String, dynamic>> entregasJson =
          entregas.map((e) => e.toMap()).toList();
      return Response(200, body: jsonEncode(entregasJson));
    });

    router.post('/loja/entregas', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('entrega').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.text.trim()})
                .where((element) => element.isNotEmpty));
        var map = elementList.first.reduce((elements, e) => elements..addAll(e));

        var entrega = Entrega.fromRequest(map);
        var result = await _entregaService.save(entrega);
        
        return result == 400 ?  Response(result, body: jsonEncode('Venda não encontrada.')) : Response(result);
      }

      var entrega = Entrega.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _entregaService.save(entrega);

      return result == 400 ?  Response(result, body: jsonEncode('Venda não encontrada.')) : Response(result);
    });

    router.put('/loja/entregas', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('entrega').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.text.trim()})
                .where((element) => element.isNotEmpty));
        var map = elementList.first.reduce((elements, e) => elements..addAll(e));

        var entrega = Entrega.fromRequest(map);
        var result = await _entregaService.save(entrega );

        return Response(result);
      }

      var entrega = Entrega.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _entregaService.save(entrega);

      return Response(result);
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
