// ignore_for_file: camel_case_types, file_names

import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class renderingPage extends StatefulWidget {
  final String jsonString;
  const renderingPage({super.key, required this.jsonString, required String jsonUrl});
  @override
  State<renderingPage> createState() => _renderingPageState();
}

class _renderingPageState extends State<renderingPage> {
  Map<dynamic, dynamic> mapData = {};
  var registry = JsonWidgetRegistry.instance;

  Future<void> _readJson() async {
    final String response = widget.jsonString;
    final data = json.decode(response);
    setState(() {
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
      return const CircularProgressIndicator();
    } else {
      var widgetData = JsonWidgetData.fromDynamic(mapData, registry: registry);
      return widgetData.build(context: context);
    }
  }
}