// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';
import '../utils/custom_xml.dart';
import '../models/planta.dart';
import '../services/planta_service.dart';
import 'api.dart';

class PlantaApi extends Api {
  final PlantaService _plantaService;
  PlantaApi(this._plantaService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get('/loja/planta', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      String? format = req.url.queryParameters['format'];
      Planta? planta = await _plantaService.findOne(int.parse(id));
      if (planta == null) return Response(400);

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> plantasXml = [planta.toXml()];
        return Response(200,
            body: CustomXml.toResponseXml(plantasXml, 'Plantas'));
      }

      return Response(200, body: planta.toJson());
    });

    router.get('/loja/plantas', (Request req) async {
      String? format = req.url.queryParameters['format'];
      List<Planta> plantas = await _plantaService.findAll();

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> plantasXml = plantas.map((e) => e.toXml()).toList();
        return Response(200,
            body: CustomXml.toResponseXml(plantasXml, 'Plantas'));
      }

      List<Map<String, dynamic>> plantasJson =
          plantas.map((e) => e.toMap()).toList();
      return Response(200, body: jsonEncode(plantasJson));
    });

    router.post('/loja/plantas', (Request req) async {
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

        var planta = Planta.fromRequest(map);
        var result = await _plantaService.save(planta);
        return Response(result);
      }

      var planta = Planta.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _plantaService.save(planta);

      return Response(result);
    });

    router.put('/loja/plantas', (Request req) async {
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

        var planta = Planta.fromRequest(map);
        var result = await _plantaService.save(planta);
        return Response(result);
      }

      var planta = Planta.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _plantaService.save(planta);

      return Response(result);
    });

    router.delete('/loja/plantas', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _plantaService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
