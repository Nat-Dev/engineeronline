import 'package:flutter/material.dart';
import 'package:engineeronline/screens/home.dart';

class Ethics extends StatefulWidget {
  @override
  _EthicsState createState() => _EthicsState();
}

class _EthicsState extends State<Ethics> {
  Widget backButton() {
    return IconButton(
      icon: Icon(
        Icons.navigate_before,
        size: 36.0,
        color: Colors.white,
      ),
      onPressed: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Home());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: backButton(),
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "จรรยาบรรณ",
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
    );
  }
}
