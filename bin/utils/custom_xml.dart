import 'package:xml/xml.dart';

class CustomXml {

  static String toResponseXml(List<XmlDocument> documents, String title) {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element(title, nest: () {
      for (var doc in documents) {
        builder.xml(doc.toXmlString());
      }
    });
    final document = builder.buildDocument();
    return document.toXmlString();
  }
}
