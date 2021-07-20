import 'package:flutter/material.dart';

class TechniqueTopics extends StatefulWidget {
  @override
  _TechniqueTopicsState createState() => _TechniqueTopicsState();
}

class _TechniqueTopicsState extends State<TechniqueTopics> {
  Container buildGridview(String str) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        child: ListTile(
          onTap: () {
            if (str == "งานเสาเข็ม") {
              Navigator.pushNamed(context, '/piling_work');
            } else if (str == "งานกำแพงกันดินระบบป้องกันดินพัง") {
              Navigator.pushNamed(context, '/retaining_wall');
            } else if (str == "งานดินและฐานราก") {
              Navigator.pushNamed(context, '/soil_work');
            } else if (str == "งานฐานราก") {
              Navigator.pushNamed(context, '/shallow_foundation');
            } else if (str == "งานคอนกรีต") {
              Navigator.pushNamed(context, '/concrete_work');
            } else if (str == "งานเหล็กเสริมคอนกรีต") {
              Navigator.pushNamed(context, '/reinforcing_steel');
            } else if (str == "งานโครงสร้างเหล็ก/งานเหล็กรูปพรรณ") {
              Navigator.pushNamed(context, '/steel_construction');
            } else if (str == "งานพื้น") {
              Navigator.pushNamed(context, '/floor_work');
            } else if (str == "งานPrecast") {
              Navigator.pushNamed(context, '/precast_work');
            } else if (str == "งานเสา(Column)") {
              Navigator.pushNamed(context, '/column_work');
            }
          },
          title: Center(
            child: Text(
              str,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.5,
              ),
            ),
          ),
        ),
        color: Colors.amber.shade100,
      ),
      margin: EdgeInsets.all(4.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "ความรู้วิศวกรรมในงานก่อสร้าง",
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
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: [
                    buildGridview("งานเสาเข็ม"),
                    buildGridview("งานกำแพงกันดินระบบป้องกันดินพัง"),
                    buildGridview("งานดินและฐานราก"),
                    buildGridview("งานฐานราก"),
                    buildGridview("งานคอนกรีต"),
                    buildGridview("งานเหล็กเสริมคอนกรีต"),
                    buildGridview("งานโครงสร้างเหล็ก/งานเหล็กรูปพรรณ"),
                    buildGridview("งานพื้น"),
                    buildGridview("งานPrecast"),
                    buildGridview("งานเสา(Column)"),
                    buildGridview("งานนั่งร้าน"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
