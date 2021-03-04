import 'package:flutter/material.dart';
import 'package:engineeronline/screens/home.dart';

class Contract extends StatefulWidget {
  @override
  _ContractState createState() => _ContractState();
}

class _ContractState extends State<Contract> {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          leading: backButton(),
          title: Text(
            "วิศวกร EIT Online",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
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
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue.shade900,
            title: Text(
              "สัญญาการก่อสร้าง",
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
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
