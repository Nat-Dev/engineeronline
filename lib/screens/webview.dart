import 'package:engineeronline/models/general_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        backgroundColor: Colors.blue.shade900,
        title: Text(
          model.name == null ? "Open Website" : model.name,
          style: TextStyle(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            shadows: [
              Shadow(
                offset: Offset(1.75, 1.75),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              )
            ],
          ),
        ),
      ),
      body: model.url == null
          ? Center(child: CircularProgressIndicator())
          : WebView(
              initialUrl: model.url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
    );
  }
}
