import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';
import '../models/supplier.dart';
import '../services/supplier_service.dart';
import '../utils/custom_xml.dart';
import 'api.dart';

class SupplierApi extends Api {
  final SupplierService _supplierService;
  SupplierApi(this._supplierService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/supplier', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      String? format = req.url.queryParameters['format'];
      Supplier? supplier = await _supplierService.findOne(int.parse(id));
      if (supplier == null) return Response(400);

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> suppliersXml = [supplier.toXml()];
        return Response(200,
            body: CustomXml.toResponseXml(suppliersXml, 'Supplier'));
      }

      return Response(200, body: supplier.toJson());
    });

    router.get('/suppliers', (Request req) async {
      String? format = req.url.queryParameters['format'];
      List<Supplier> suppliers = await _supplierService.findAll();

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> suppliersXml =
            suppliers.map((e) => e.toXml()).toList();
        return Response(200,
            body: CustomXml.toResponseXml(suppliersXml, 'Suppliers'));
      }

      List<Map<String, dynamic>> suppliersJson =
          suppliers.map((e) => e.toMap()).toList();
      return Response(200, body: jsonEncode(suppliersJson));
    });

    router.post('/supplier', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('supplier').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.value?.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var supplier = Supplier.fromRequest(map);
        var result = await _supplierService.save(supplier);
        return Response(result['statusCode'],
            body: jsonEncode({'id': result['id']}));
      }

      var supplier =
          Supplier.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _supplierService.save(supplier);

      return Response(result['statusCode'],
          body: jsonEncode({'id': result['id']}));
    });

    router.put('/supplier', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('supplier').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.value?.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var supplier = Supplier.fromRequest(map);
        var result = await _supplierService.save(supplier);
        return Response(result);
      }

      var supplier =
          Supplier.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _supplierService.save(supplier);

      return Response(result);
    });

    router.delete('/supplier', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _supplierService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
