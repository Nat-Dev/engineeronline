import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  double screenWidth;
  double screenHeight;
  String username, email, password, otp;
  bool redEyeStatus = true;

  void sendOTP() async {
    EmailAuth.sessionName = "วิศวกร EIT ONLINE";
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print("OTP sent");
    } else {
      print("can not sent the OTP");
    }
  }

  bool verifyOTP() {
    bool res = EmailAuth.validate(
        receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      print("OTP verified");
    } else {
      print("invalid OTP");
    }
    return res;
  }

  Widget header() {
    return Align(
      alignment: Alignment(0, 0),
      child: Text(
        "CREATE ACCOUNT",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Container buildUsername() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Username:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
          helperText: "Type your Username",
          helperStyle: TextStyle(
            color: Colors.blue.shade900,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.perm_identity),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Please type your Username in the field";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          username = value.trim();
        },
      ),
    );
  }

  Container buildEmail() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
          helperText: "Type your Email Address",
          helperStyle: TextStyle(
            color: Colors.blue.shade900,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.email_outlined),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          suffixIcon: TextButton(
            child: Text("Send OTP"),
            onPressed: () {
              sendOTP();
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
        ),
        validator: (String value) {
          if (!(value.contains('@') && value.contains('.'))) {
            return "Please type your Email Address in the field";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          email = value.trim();
        },
      ),
    );
  }

  Container buildOTP() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        controller: _otpController,
        obscureText: redEyeStatus,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "OTP:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
          helperText: "Type your OTP from the Email",
          helperStyle: TextStyle(
            color: Colors.blue.shade900,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.confirmation_number_outlined),
          suffixIcon: IconButton(
              icon: redEyeStatus
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                setState(() {
                  redEyeStatus = !redEyeStatus;
                });
              }),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Please type your OTP";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          otp = value.trim();
        },
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: TextFormField(
        obscureText: redEyeStatus,
        decoration: InputDecoration(
          hintText: "Password:",
          hintStyle: TextStyle(color: Colors.blue.shade900),
          helperText: "Your password must be at least 6 characters",
          helperStyle: TextStyle(
            color: Colors.blue.shade900,
            fontStyle: FontStyle.italic,
            fontSize: 13.5,
          ),
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
              icon: redEyeStatus
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                setState(() {
                  redEyeStatus = !redEyeStatus;
                });
              }),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue.shade900),
          ),
        ),
        validator: (String value) {
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          password = value.trim();
        },
      ),
    );
  }

  // Container buildConfirmPassword() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 16),
  //     width: screenWidth * 0.8,
  //     child: TextFormField(
  //       obscureText: redEyeStatus,
  //       decoration: InputDecoration(
  //         hintText: "Confirm your password:",
  //         hintStyle: TextStyle(color: Colors.blue.shade900),
  //         helperText: "Type your password again",
  //         helperStyle: TextStyle(
  //           color: Colors.blue.shade900,
  //           fontStyle: FontStyle.italic,
  //           fontSize: 13.5,
  //         ),
  //         prefixIcon: Icon(Icons.lock_outline),
  //         suffixIcon: IconButton(
  //             icon: redEyeStatus
  //                 ? Icon(Icons.remove_red_eye)
  //                 : Icon(Icons.remove_red_eye_outlined),
  //             onPressed: () {
  //               setState(() {
  //                 redEyeStatus = !redEyeStatus;
  //               });
  //             }),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(25),
  //           borderSide: BorderSide(color: Colors.blue.shade900),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(25),
  //           borderSide: BorderSide(color: Colors.blue.shade900),
  //         ),
  //       ),
  //       validator: (String value) {
  //         if (value.length < 6) {
  //           return "Password must be at least 6 characters";
  //         } else {
  //           return null;
  //         }
  //       },
  //     ),
  //   );
  // }

  Container buildSignUp() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            if (verifyOTP()) {
              formKey.currentState.save();
              print(
                  "username = $username, password = $password, email = $email, otp = $otp");
            } else {
              print("OTP is not verified");
            }
          }
        },
        child: Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Register"),
      ),
      body: CustomPaint(
        painter: GreenPainter(),
        child: Center(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                header(),
                SizedBox(
                  height: 20,
                ),
                buildUsername(),
                SizedBox(
                  height: 20,
                ),
                buildPassword(),
                SizedBox(
                  height: 20,
                ),
                buildEmail(),
                SizedBox(
                  height: 20,
                ),
                buildOTP(),
                SizedBox(
                  height: 20,
                ),
                // buildConfirmPassword(),
                SizedBox(
                  height: 20,
                ),
                buildSignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.grey.shade200;
    canvas.drawPath(mainBackground, paint);
    Path ovalPath = Path();
    ovalPath.moveTo(0, height * 0.2);
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width * 0.51, height * 0.5);
    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);
    ovalPath.lineTo(0, height);
    ovalPath.close();
    paint.color = Colors.green.shade200;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
