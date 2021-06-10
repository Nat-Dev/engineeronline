import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Architecture extends StatefulWidget {
  Architecture({Key key, this.keys}) : super(key: key);
  final String keys;
  @override
  _ArchitectureState createState() => _ArchitectureState();
}

class _ArchitectureState extends State<Architecture> {
  final scrollDirection = Axis.vertical;

  AutoScrollController controller;
  Future _scrollToOne() async {
    await controller.scrollToIndex(12,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToTwo() async {
    await controller.scrollToIndex(45,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToThree() async {
    await controller.scrollToIndex(72,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToFour() async {
    await controller.scrollToIndex(86,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToFive() async {
    await controller.scrollToIndex(98,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToSix() async {
    await controller.scrollToIndex(103,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToSeven() async {
    await controller.scrollToIndex(116,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToEight() async {
    await controller.scrollToIndex(124,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToNine() async {
    await controller.scrollToIndex(125,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToTen() async {
    await controller.scrollToIndex(129,
        preferPosition: AutoScrollPosition.begin);
  }

  Future _scrollToEleven() async {
    await controller.scrollToIndex(130,
        preferPosition: AutoScrollPosition.begin);
  }

  Align buildChapter(String text) {
    return Align(
      alignment: Alignment(0, 0),
      child: TextButton(
        onPressed: null,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.green.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Align buildChapterButton(String text) {
    return Align(
      alignment: Alignment(-1, 0),
      child: TextButton(
        onPressed: () {
          if (text == "งานพื้น") {
            _scrollToOne();
          } else if (text == "งานผนัง") {
            _scrollToTwo();
          } else if (text == "งานฝ้าเพดาน") {
            _scrollToThree();
          } else if (text == "งานหลังคา") {
            _scrollToFour();
          } else if (text == "งานบันได") {
            _scrollToFive();
          } else if (text == "งานประตู หน้าต่าง วงกบ และกรอบบาน") {
            _scrollToSix();
          } else if (text == "กระจก") {
            _scrollToSeven();
          } else if (text == "งานสุขภัณฑ์") {
            _scrollToEight();
          } else if (text == "งานทาสีและพ่นสี") {
            _scrollToNine();
          } else if (text == "งานป้องกันปลวก") {
            _scrollToTen();
          } else if (text == "งานเบ็ดเตล็ด") {
            _scrollToEleven();
          } else {
            print("text error");
          }
        },
        child: Text(
          text,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
            color: Colors.green.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Align buildSubChapter(String text) {
    return Align(
      alignment: Alignment(-1, 0),
      child: TextButton(
        onPressed: null,
        child: Text(
          text,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Align buildDetail(String text) {
    return Align(
      alignment: Alignment(-1, 0),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blue.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox(double h) {
    return SizedBox(
      height: h,
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  @override
  Widget build(BuildContext context) {
    List contents = [
      Align(
        alignment: Alignment(0, 0),
        child: TextButton(
          onPressed: null,
          child: Text(
            "ไปที่บท",
            style: TextStyle(
              fontSize: 18,
              color: Colors.purple.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      buildChapterButton("งานพื้น"),
      buildChapterButton("งานผนัง"),
      buildChapterButton("งานฝ้าเพดาน"),
      buildChapterButton("งานหลังคา"),
      buildChapterButton("งานบันได"),
      buildChapterButton("งานประตู หน้าต่าง วงกบ และกรอบบาน"),
      buildChapterButton("กระจก"),
      buildChapterButton("งานสุขภัณฑ์"),
      buildChapterButton("งานทาสีและพ่นสี"),
      buildChapterButton("งานป้องกันปลวก"),
      buildChapterButton("งานเบ็ดเตล็ด"),
      Divider(
        height: 20,
        thickness: 1.5,
        color: Colors.black,
        indent: 20,
        endIndent: 20,
      ),
      buildChapter("งานพื้น"),
      buildSubChapter("วัสดุผิวพื้น"),
      buildDetail("1.พื้นปูกระเบื้อง HOMOGENEOUS TILE (แกรนิตโต้)"),
      buildDetail("2.พื้นปูกระเบื้องเซรามิค"),
      buildDetail("3.พื้นปูกระเบื้องยางชนิดม้วน"),
      buildDetail("4.พื้นปูกระเบื้องยางชนิดแผ่นขนาด 0.50 x 0.50 ม."),
      buildDetail("5.พื้นปูกระเบื้องยางชนิดแผ่นลายไม้"),
      buildDetail("6.พื้นกระเบื้องยาง (NON ASBESTOS TILE)ขนาด 12” x 12”"),
      buildDetail("7พื้นปูแผ่นหินเกล็ดขัดมันสำเร็จรูป"),
      buildDetail("8.พื้นผิวหินเกล็ดขัดกับที่"),
      buildDetail("9.พื้นทรายล้าง/กรวดล้าง"),
      buildDetail("10.พื้นปูหินแกรนิต/หินอ่อน"),
      buildDetail("11.พื้น ค.ส.ล. ผิวขัดมัน"),
      buildDetail("12.พื้น ค.ส.ล. ผิวเรียบ"),
      buildDetail("13.พื้นปูบล็อกทางเท้า"),
      buildDetail("13.พื้นปูแผ่นทางเท้าสำเร็จรูป"),
      buildDetail("13.พื้น ค.ส.ล. ผิว คอนกรีตพิมพ์ลาย"),
      buildDetail("13.พื้นปูบล็อกสนามหญ้า"),
      buildDetail("13.พื้นปูพรม wall to wall"),
      buildDetail("13.พื้นปูพรมแผ่นสำเร็จรูป"),
      buildDetail("13.พื้นไม้สำเร็จรูป"),
      buildDetail("13.พื้น ค.ส.ล. ขัดมันเรียบเคลือบ EPOXY"),
      buildDetail("13.พื้นยกสำเร็จรูป (ACCESS FLOORING)"),
      buildSubChapter("บัวเชิงพนัง"),
      buildDetail("1.บัวเชิงพนัง PVC สำเร็จรูป"),
      buildDetail("2.บัวเชิงผนังอลูมิเนียม"),
      buildDetail("3.บัวเชิง(บัวยาง) PVC สำเร็จรูป"),
      buildDetail("4.บัวเชิงผนังสำเร็จรูป (MDF)"),
      buildDetail("5.บัวเชิงผนังไม้เทียม"),
      buildDetail("6.บัวเชิงผนัง GRC สำเร็จรูป"),
      buildDetail("7.บัวเชิงผนังหินขัดสำเร็จรูป"),
      buildDetail("8.บัวเชิงผนัง ผิวกรวดล้าง"),
      buildChapter("งานผนัง"),
      buildSubChapter("วัสดุผนังหลัก"),
      buildDetail("1.ผนังก่ออิฐมอญ"),
      buildDetail("2.ผนังก่ออิฐมวลเบา"),
      buildDetail("3.ผนังก่ออิฐทนไฟ"),
      buildDetail("4.ผนังโครงคร่าวเหล็กชุบสังกะสี"),
      buildDetail("5.ผนังโครงสร้างคอนกรีตเสริมเหล็ก"),
      buildDetail("6.ผนังห้องน้ำสำเร็จรูป"),
      buildDetail("7.ผนังก่อคอนกรีตบล็อค"),
      buildDetail("8.ผนังโครงคร่าวไม้"),
      buildDetail("9.ผนังเลื่อนกันเสียงสำเร็จรูป (MOVEABLE  PARTITION)"),
      buildSubChapter("วัสดุปิดผิว"),
      buildDetail("1.ฉาบปูนเรียบทาสี/พ่นสี"),
      buildDetail("2.กระเบื้องเซรามิค"),
      buildDetail("3.กระเบื้องHOMOGENEOUS TILE (แกรนิตโต้)"),
      buildDetail("4.กระเบื้องดินเผา"),
      buildDetail("5.หินแกรนิต"),
      buildDetail("6.ทรายล้าง หินล้าง"),
      buildDetail("7.ทำผิว TEXTURE ทาสี"),
      buildDetail("8.แผ่นยิปซั่มบอร์ด ฉาบเรียบทาสี"),
      buildDetail("9.แผ่นไฟเบอร์ซีเมนต์ ฉาบเรียบทาสี"),
      buildDetail("10.แผ่นยิบซั่มบอร์ดชนิดกันเสียงสะท้อน"),
      buildDetail("11.แผ่นอะคูสติคบอร์ด"),
      buildDetail("12.อลูมิเนียมคอมโพสิต"),
      buildDetail("13.แผ่นลามิเนต"),
      buildDetail("14.วอล์เปเปอร์"),
      buildDetail("15.ไม้ฝาสำเร็จรูป"),
      buildChapter("งานฝ้าเพดาน"),
      buildDetail("1.ฝ้ายิปซั่มบอร์ดชนิดฉาบรอยต่อเรียบ"),
      buildDetail("2.ฝ้ายิปซั่มบอร์ดชนิดกันชื้นฉาบเรียบ"),
      buildDetail("3.ฝ้ายิบซั่มบอร์ดชนิดขอบบังไบ โครงเคร่าวอลูมิเนียม T–BAR"),
      buildDetail("4.ฝ้าเพดานอะคูสติค โครงเคร่าวอลูมิเนียม T–BAR"),
      buildDetail("5.ฝ้าเพดานยิบซั่มชนิดลดเสียงสะท้อน"),
      buildDetail("6.ฝ้าเพดานแผ่นอะคูสติคปิดทับฝ้ายิปซั่มบอร์ด"),
      buildDetail("7.ฝ้าเพดานอลูมิเนียมอบสีตัว C"),
      buildDetail("8.ฝ้าเพดานตะแกรงอลูมิเนียม"),
      buildDetail("9.ฝ้าเพดานแผ่นอลูมิเนียมแบบมีรูพรุน"),
      buildDetail("10.ฝ้าเพดานยิบซั่มชนิดลดเสียงสะท้อน"),
      buildDetail("11.ฝ้าเพดานฉาบปูนเรียบทาสีใต้ท้องพื้น"),
      buildDetail("12.ฝ้าอลูมิเนียมคอมโพสิต"),
      buildDetail("13.ฝ้าไม้สำเร็จรูป"),
      buildChapter("งานหลังคา"),
      buildSubChapter("งานหลังคา"),
      buildDetail("1.หลังคากระเบื้องคอนกรีต"),
      buildDetail("2.หลังคากระเบื้องไฟเบอร์ซีเมนต์แผ่นเรียบ"),
      buildDetail("3.หลังคาเหล็กชุบสังกะสี (Metal Sheet)"),
      buildDetail("4.หลังคาโครงสร้างคอนกรีตเสริมเหล็ก"),
      buildDetail("5.หลังคาเหล็กปั๊มขั้นลอนเคลือบสีพิเศษ"),
      buildDetail("6.หลังคาไฟเบอร์กลาส"),
      buildSubChapter("ฉนวนกันความร้อน"),
      buildDetail("1.ฉนวนกันความร้อนชนิด ALUMINIUM FOIL"),
      buildDetail("2.ฉนวนกันความร้อนชนิดฉนวนใย"),
      buildDetail("3.ฉนวนกันความร้อนชนิดพ่น"),
      buildChapter("งานบันได"),
      buildDetail("1.วัสดุทำพื้นผิวบันได"),
      buildDetail("2.วัสดุทำจมูกบันได"),
      buildDetail("3.วัสดุทำราวบันได"),
      buildDetail("4.วัสดุทำพื้นผิวทางลาด"),
      buildChapter("งานประตู หน้าต่าง วงกบ และกรอบบาน"),
      buildSubChapter("อลูมิเนียม"),
      buildDetail("1.ประตูอลูมิเนียม"),
      buildDetail("2.หน้าต่างอลูมิเนียม"),
      buildSubChapter("ไม้"),
      buildDetail("1.ประตูไม้"),
      buildSubChapter("เหล็ก"),
      buildDetail("1.ประตูเหล็ก"),
      buildDetail("2.หน้าต่างเหล็ก"),
      buildDetail("ไฟเบอร์กลาส (โพลีเอสเตอร์เสริมใยแก้ว)"),
      buildDetail("PVC"),
      buildDetail("ประตูเหล็กกันไฟ"),
      buildDetail("ประตูเหล็กม้วน"),
      buildChapter("กระจก"),
      buildDetail("1.กระจกใส"),
      buildDetail("2.กระจกฝ้า"),
      buildDetail("3.กระจกเงา"),
      buildDetail("4.กระจกเสริมเหล็ก(WIRE GLASS)"),
      buildDetail("5.กระจกตัดแสง"),
      buildDetail("6.กระจกทนแรงอ้ด(TEMPERED)"),
      buildDetail("7.กระจกอัดแผ่นฟิล์ม(LAMINATED)"),
      buildChapter("งานสุขภัณฑ์"),
      buildChapter("งานทาสีและพ่นสี"),
      buildDetail("1.การทาสีโลหะ"),
      buildDetail("2.การทาสีงานปูน"),
      buildDetail("3.การทาสีงานไม้"),
      buildChapter("งานป้องกันปลวก"),
      buildChapter("งานเบ็ดเตล็ด"),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "งานสถาปัตยกรรม",
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
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: ListView(
            scrollDirection: scrollDirection,
            controller: controller,
            children: <Widget>[
              ...List.generate(contents.length, (index) {
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: controller,
                  index: index,
                  child: contents[index],
                  highlightColor: Colors.black.withOpacity(0.1),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
