// ignore_for_file: camel_case_types, library_private_types_in_public_api, prefer_const_constructors

import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';


class renderingPage extends StatefulWidget {
  final String jsonString;
  const renderingPage({Key? key,required this.jsonString, required String jsonUrl}) : super(key: key);
  @override
  _renderingPageState createState() => _renderingPageState();
}

class _renderingPageState extends State<renderingPage> {
  Map<dynamic, dynamic> mapData = {};
  var registry = JsonWidgetRegistry.instance;

  Future<void> _readJson() async {
    final String response = widget.jsonString;
    final data = json.decode(response);
    setState(() {
      print("renderingPage");

      mapData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _readJson();
  }
  @override
  Widget build(BuildContext context) {

    if (mapData.isEmpty) {
      return CircularProgressIndicator();
    } else {
      var widget = JsonWidgetData.fromDynamic(mapData, registry: registry);
      return widget.build   (context: context);
    }
  }
}