import 'package:flutter/material.dart';

class Contract extends StatefulWidget {
  @override
  _ContractState createState() => _ContractState();
}

class _ContractState extends State<Contract> {
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
      body: Text("THIS IS CONTRACT"),
    );
  }
}
