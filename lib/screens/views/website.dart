import 'package:engineeronline/models/website_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Website extends StatefulWidget {
  final WebsiteModel websiteModel;
  Website({Key key, this.websiteModel}) : super(key: key);
  @override
  _WebsiteState createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
  WebsiteModel model;

  @override
  void initState() {
    super.initState();
    model = widget.websiteModel;
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
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy
                  .require_user_action_for_all_media_types,
            ),
    );
  }
}
