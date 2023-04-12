import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';
import '../models/venda.dart';
import '../services/venda_service.dart';
import '../utils/custom_xml.dart';
import 'api.dart';

class VendaApi extends Api {
  final VendaService _vendaService;
  VendaApi(this._vendaService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get('/loja/venda', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      String? format = req.url.queryParameters['format'];
      Venda? venda = await _vendaService.findOne(int.parse(id));
      if (venda == null) return Response(400);

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> vendasXml = [venda.toXml()];
        return Response(200,
            body: CustomXml.toResponseXml(vendasXml, 'Vendas'));
      }

      return Response(200, body: venda.toJson());
    });

    router.get('/loja/vendas', (Request req) async {
      String? format = req.url.queryParameters['format'];
      List<Venda> vendas = await _vendaService.findAll();

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> vendasXml = vendas.map((e) => e.toXml()).toList();
        return Response(200,
            body: CustomXml.toResponseXml(vendasXml, 'Vendas'));
      }

      List<Map<String, dynamic>> vendasJson =
          vendas.map((e) => e.toMap()).toList();
      return Response(200, body: jsonEncode(vendasJson));
    });

    router.post('/loja/vendas', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('planta').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.text.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var venda = Venda.fromRequest(map);
        var result = await _vendaService.save(venda);
        return result == 400
            ? Response(result, body: 'Estoque insuficiente.')
            : Response(result);
      }

      var venda = Venda.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _vendaService.save(venda);

      return result == 400
          ? Response(result, body: jsonEncode('Estoque insuficiente.'))
          : Response(result);
    });

    // router.put('/loja/vendas', (Request req) async {
    //   String? format = req.url.queryParameters['format'];
    //   var body = await req.readAsString();

    //   if (format?.toLowerCase() == 'xml') {
    //     final document = XmlDocument.parse(body);
    //     final elementList = document.findAllElements('venda').map((node) => node
    //         .children
    //         .map((e) => e.text.trim())
    //         .where((element) => element.isNotEmpty)
    //         .toList());

    //     var map = elementList.map((e) => <String, dynamic>{
    //           'id': int.parse(e[0]),
    //           'date': e[1],
    //           'idPlanta': int.parse(e[2]),
    //           'amount': int.parse(e[3]),
    //           'value': double.parse(e[4])
    //         });

    //     var venda = Venda.fromRequest(map.first);
    //     var result = await _vendaService.save(venda);
    //     return result ? Response(200) : Response(500);
    //   }

    //   var venda = Venda.fromRequest(jsonDecode(body) as Map<String, dynamic>);
    //   var result = await _vendaService.save(venda);

    //   return result ? Response(200) : Response(500);
    // });

    router.delete('/loja/vendas', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _vendaService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
