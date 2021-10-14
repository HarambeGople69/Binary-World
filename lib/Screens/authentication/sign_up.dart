import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/Screens/authentication/otp.dart';
import 'package:myapp/widgets/custom_animated_alertdialog.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_password_field.dart';
import 'package:myapp/widgets/our_sizebox.dart';
import 'package:myapp/widgets/our_text_field.dart';
import 'package:email_auth/email_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  TextEditingController _conform_password_controller = TextEditingController();
  final FocusNode emailNode = FocusNode();
  final FocusNode nameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmNode = FocusNode();
  bool see = true;
  bool csee = true;

  void sendOTP(BuildContext context) async {
    EmailAuth emailAuth = new EmailAuth(sessionName: "Test session");
    bool result = await emailAuth.sendOtp(
      recipientMail: _email_controller.value.text,
      otpLength: 5,
    );
    print(result);
    if (result) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OtpVerification(
          email: _email_controller.value.text,
          password: _password_controller.value.text,
          name: _name_controller.value.text,
        );
      }));
    } else {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Oops! error occured",
            style: TextStyle(fontSize: ScreenUtil().setSp(15)),
          ),
        ),
      );
    }
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .25,
            child: Lottie.asset(
              "assets/animation/login.json",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.indigo[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    ScreenUtil().setSp(46),
                  ),
                  topRight: Radius.circular(
                    ScreenUtil().setSp(46),
                  ),
                )),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(20),
              vertical: ScreenUtil().setSp(20),
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(30),
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      OurSizedHeight(),
                      CustomTextField(
                        start: nameNode,
                        end: emailNode,
                        controller: _name_controller,
                        icon: Icons.person,
                        validator: (value) {
                          if (value.isNotEmpty) {
                            return null;
                          } else {
                            return "Invalid email";
                          }
                        },
                        title: "Enter username",
                        type: TextInputType.name,
                        number: 0,
                      ),
                      OurSizedHeight(),
                      CustomTextField(
                        start: emailNode,
                        end: passwordNode,
                        controller: _email_controller,
                        icon: Icons.email,
                        validator: (value) {
                          if (value.isNotEmpty && value.contains("@gmail")) {
                            return null;
                          } else {
                            return "Must contain @gmail.com";
                          }
                        },
                        title: "Enter email",
                        type: TextInputType.emailAddress,
                        number: 0,
                      ),
                      OurSizedHeight(),
                      PasswordForm(
                        number: 0,
                        start: passwordNode,
                        end: confirmNode,
                        validator: (value) {
                          if (value.isNotEmpty && value.length >= 7) {
                            return null;
                          } else {
                            return "Password must have atleast 7 character";
                          }
                        },
                        title: "Enter password",
                        controller: _password_controller,
                        see: see,
                        changesee: () {
                          setState(() {
                            see = !see;
                          });
                        },
                      ),
                      OurSizedHeight(),
                      PasswordForm(
                        number: 1,
                        start: confirmNode,
                        validator: (value) {
                          if (_password_controller.text ==
                              _conform_password_controller.text) {
                            return null;
                          } else {
                            return "Password didn't match";
                          }
                        },
                        title: "Re-enter password",
                        controller: _conform_password_controller,
                        see: csee,
                        changesee: () {
                          setState(() {
                            csee = !csee;
                          });
                        },
                      ),
                      OurSizedHeight(),
                      OurElevatedButton(
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            AlertWidget().showLoading(context);
                            sendOTP(context);
                          }
                        },
                        title: "Sign Up",
                      ),
                      OurSizedHeight(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(20),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    ));
  }
}
