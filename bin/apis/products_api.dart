// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';
import '../utils/custom_xml.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import 'api.dart';

class ProductApi extends Api {
  final ProductService _productService;
  ProductApi(this._productService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.get('/product', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      String? format = req.url.queryParameters['format'];
      Product? product = await _productService.findOne(int.parse(id));
      if (product == null) return Response(400);

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> productsXml = [product.toXml()];
        return Response(200,
            body: CustomXml.toResponseXml(productsXml, 'Products'));
      }

      return Response(200, body: product.toJson());
    });

    router.get('/products', (Request req) async {
      String? format = req.url.queryParameters['format'];
      List<Product> products = await _productService.findAll();

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> productsXml = products.map((e) => e.toXml()).toList();
        return Response(200,
            body: CustomXml.toResponseXml(productsXml, 'Products'));
      }

      List<Map<String, dynamic>> productsJson =
          products.map((e) => e.toMap()).toList();
      return Response(200, body: jsonEncode(productsJson));
    });

    router.post('/product', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('product').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.value?.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var product = Product.fromRequest(map);
        var result = await _productService.save(product);
        return Response(result['statusCode'],
            body: jsonEncode({'id': result['id']}));
      }

      var product =
          Product.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _productService.save(product);

      return Response(result['statusCode'],
          body: jsonEncode({'id': result['id']}));
    });

    router.put('/product', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();
      
      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('product').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.value?.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var product = Product.fromRequest(map);
        var result = await _productService.save(product);
        return Response(result);
      }

      var product =
          Product.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _productService.save(product);
      print(product);
      return Response(result);
    });

    router.delete('/product', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _productService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
