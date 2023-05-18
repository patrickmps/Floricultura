import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:xml/xml.dart';
import '../models/category.dart';
import '../services/category_service.dart';
import '../utils/custom_xml.dart';
import 'api.dart';

class CategoryApi extends Api {
  final CategoryService _categoryService;
  CategoryApi(this._categoryService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/category', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      String? format = req.url.queryParameters['format'];
      Category? category = await _categoryService.findOne(int.parse(id));
      if (category == null) return Response(400);

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> categoriesXml = [category.toXml()];
        return Response(200,
            body: CustomXml.toResponseXml(categoriesXml, 'category'));
      }

      return Response(200, body: category.toJson());
    });

    router.get('/categories', (Request req) async {
      String? format = req.url.queryParameters['format'];
      List<Category> categories = await _categoryService.findAll();

      if (format?.toLowerCase() == 'xml') {
        List<XmlDocument> categoriesXml =
            categories.map((e) => e.toXml()).toList();
        return Response(200,
            body: CustomXml.toResponseXml(categoriesXml, 'categories'));
      }

      List<Map<String, dynamic>> categoriesJson =
          categories.map((e) => e.toMap()).toList();
      return Response(200, body: jsonEncode(categoriesJson));
    });

    router.post('/category', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('category').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.value?.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var category = Category.fromRequest(map);
        var result = await _categoryService.save(category);
        return Response(result['statusCode'],
            body: jsonEncode({'id': result['id']}));
      }

      var category =
          Category.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _categoryService.save(category);

      return Response(result['statusCode'],
          body: jsonEncode({'id': result['id']}));
    });

    router.put('/category', (Request req) async {
      String? format = req.url.queryParameters['format'];
      var body = await req.readAsString();

      if (format?.toLowerCase() == 'xml') {
        final document = XmlDocument.parse(body);
        final elementList = document.findAllElements('category').map((node) =>
            node.descendantElements
                .map((e) => {e.name.toString(): e.value?.trim()})
                .where((element) => element.isNotEmpty));
        var map =
            elementList.first.reduce((elements, e) => elements..addAll(e));

        var category = Category.fromRequest(map);
        var result = await _categoryService.save(category);
        return Response(result);
      }

      var category =
          Category.fromRequest(jsonDecode(body) as Map<String, dynamic>);
      var result = await _categoryService.save(category);

      return Response(result);
    });

    router.delete('/category', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _categoryService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
