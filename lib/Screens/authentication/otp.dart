import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/Screens/pages/wrapper.dart';
import 'package:myapp/services/authentication/authentication.dart';
import 'package:myapp/widgets/custom_animated_alertdialog.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sizebox.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerification extends StatefulWidget {
  final String email;
  final String name;
  final String password;
  const OtpVerification({
    Key? key,
    required this.email,
    required this.name,
    required this.password,
  }) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  void resendOTP(BuildContext context) async {
    EmailAuth emailAuth = new EmailAuth(sessionName: "Test session");
    bool result = await emailAuth.sendOtp(
      recipientMail: widget.email,
      otpLength: 5,
    );
    print(result);
  }

  verifyOTP() async {
    EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");

    var res = emailAuth.validateOtp(
      recipientMail: widget.email,
      userOtp: textEditingController.value.text,
    );
    if (res) {
      Navigator.pop(context);
      await Auth()
          .createAccount(widget.email, widget.password, widget.name, context);
      Navigator.pop(context);
      Navigator.pop(context);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return HomePage();
      // }));
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please enter valid OTP.",
            style: TextStyle(fontSize: ScreenUtil().setSp(15)),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(20),
            vertical: ScreenUtil().setSp(20),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              Text(
                'Email Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.indigo,
                ),
                textAlign: TextAlign.center,
              ),
              OurSizedHeight(),
              Container(
                height: ScreenUtil().setSp(250),
                child: Lottie.asset(
                  "assets/animation/otp.json",
                  fit: BoxFit.contain,
                ),
              ),
              OurSizedHeight(),
              Text(
                "Enter the code sent to ${widget.email}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(15),
                  color: Colors.indigo[300],
                ),
              ),
              OurSizedHeight(),
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                pastedTextStyle: TextStyle(
                  color: Colors.indigo[800],
                  fontWeight: FontWeight.bold,
                ),
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    activeColor: Colors.indigo[500],
                    inactiveColor: Colors.indigo[500],
                    inactiveFillColor: Colors.indigo[100],
                    selectedFillColor: Colors.indigo[100],
                    selectedColor: Colors.indigo[500],
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    activeFillColor: Colors.indigo[200]),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");

                  return true;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              OurSizedHeight(),
              OurElevatedButton(
                function: () async {
                  AlertWidget().showLoading(context);

                  await verifyOTP();
                },
                title: "Verify",
              ),
              OurSizedHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      resendOTP(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            "OTP resent",
                            style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
