import 'package:engineeronline/models/pdf_model.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class Pdf extends StatefulWidget {
  final PdfModel pdfModel;
  Pdf({Key key, this.pdfModel}) : super(key: key);
  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  PdfModel model;

  @override
  void initState() {
    super.initState();
    model = widget.pdfModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          model.name == null ? "Open Pdf" : model.name,
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
          : PDF.network(model.url,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width),
    );
  }
}
