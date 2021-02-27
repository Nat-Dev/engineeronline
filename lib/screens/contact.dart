import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "วิศวกร Online",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.yellowAccent,
                shadows: [
                  Shadow(
                    offset: Offset(1.75, 1.75),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  )
                ]),
          ),
          backgroundColor: Colors.red.shade800,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          )),
        ),
      ),
      body: Text("THIS IS CONTACT"),
    );
  }
}
