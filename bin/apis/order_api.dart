import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';
import '../models/order.dart';
import '../services/order_service.dart';
import '../utils/custom_xml.dart';
import 'api.dart';

class OrderApi extends Api {
  final OrderService _orderService;
  OrderApi(this._orderService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get('/order', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      String? format = req.url.queryParameters['format'];
      Order? order = await _orderService.findOne(int.parse(id));
      if (order == null) return Response(400);

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> ordersXml = [order.toXml()];
        return Response(200,
            body: CustomXml.toResponseXml(ordersXml, 'Orderss'));
      }

      return Response(200, body: order.toJson());
    });

    router.get('/orders', (Request req) async {
      String? format = req.url.queryParameters['format'];
      List<Order> orders = await _orderService.findAll();

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> ordersXml = orders.map((e) => e.toXml()).toList();
        return Response(200,
            body: CustomXml.toResponseXml(ordersXml, 'orders'));
      }

      List<Map<String, dynamic>> ordersJson =
          orders.map((e) => e.toMap()).toList();
      return Response(200, body: jsonEncode(ordersJson));
    });

    router.post('/order', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('order').map((node) => node
            .descendantElements
            .map((e) => {e.name.toString(): e.value?.trim()})
            .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var order = Order.fromRequest(map);
        var result = await _orderService.save(order);
        return Response(result['statusCode'],
            body: jsonEncode({'id': result['id']}));
      }

      var order = Order.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _orderService.save(order);

      return Response(result['statusCode'],
          body: jsonEncode({'id': result['id']}));
    });

    router.put('/order', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('order').map((node) => node
            .descendantElements
            .map((e) => {e.name.toString(): e.value?.trim()})
            .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var order = Order.fromRequest(map);
        var result = await _orderService.save(order);
        return Response(result);
      }

      var order = Order.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _orderService.save(order);

      return Response(result);
    });

    router.delete('/order', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _orderService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
