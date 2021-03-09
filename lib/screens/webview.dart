import 'package:engineeronline/models/general_model.dart';
import 'package:flutter/material.dart';

class Webview extends StatefulWidget {
  final GeneralModel generalModel;
  Webview({Key key, this.generalModel}) : super(key: key);
  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  GeneralModel model;

  @override
  void initState() {
    super.initState();
    model = widget.generalModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name == null ? "Open Website" : model.name),
      ),
    );
  }
}
