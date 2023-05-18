import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';
import '../models/address.dart';
import '../services/address_service.dart';
import '../utils/custom_xml.dart';
import 'api.dart';

class AddressApi extends Api {
  final AddressService _addressService;
  AddressApi(this._addressService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/address', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      String? format = req.url.queryParameters['format'];
      Address? address = await _addressService.findOne(int.parse(id));
      if (address == null) return Response(400);

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> addressesXml = [address.toXml()];
        return Response(200,
            body: CustomXml.toResponseXml(addressesXml, 'address'));
      }

      return Response(200, body: address.toJson());
    });

    router.get('/addresses', (Request req) async {
      String? format = req.url.queryParameters['format'];
      List<Address> addresses = await _addressService.findAll();

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> addressesXml =
            addresses.map((e) => e.toXml()).toList();
        return Response(200,
            body: CustomXml.toResponseXml(addressesXml, 'addresses'));
      }

      List<Map<String, dynamic>> addressesJson =
          addresses.map((e) => e.toMap()).toList();
      return Response(200, body: jsonEncode(addressesJson));
    });

    router.post('/address', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('address').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.value?.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var address = Address.fromRequest(map);
        var result = await _addressService.save(address);
        return Response(result['statusCode'],
            body: jsonEncode({'id': result['id']}));
      }

      var address =
          Address.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _addressService.save(address);

      return Response(result['statusCode'],
          body: jsonEncode({'id': result['id']}));
    });

    router.put('/address', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('address').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.value?.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var address = Address.fromRequest(map);
        var result = await _addressService.save(address);
        return Response(result);
      }

      var address =
          Address.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _addressService.save(address);

      return Response(result);
    });

    router.delete('/address', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _addressService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
