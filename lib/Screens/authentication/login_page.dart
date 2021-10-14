import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/Screens/authentication/sign_up.dart';
import 'package:myapp/services/authentication/authentication.dart';
import 'package:myapp/widgets/custom_animated_alertdialog.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_password_field.dart';
import 'package:myapp/widgets/our_sizebox.dart';
import 'package:myapp/widgets/our_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool see = true;
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
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
                  height: MediaQuery.of(context).size.height * 0.58,
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(30),
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                            Text(
                              "Please sign in to continue",
                              style: TextStyle(
                                letterSpacing: -1,
                                fontSize: ScreenUtil().setSp(20),
                                color: Colors.indigo[500],
                              ),
                            ),
                            OurSizedHeight(),
                            CustomTextField(
                              start: emailNode,
                              end: passwordNode,
                              controller: _email_controller,
                              icon: Icons.email,
                              validator: (value) {
                                if (value.isNotEmpty &&
                                    value.contains("@gmail.com")) {
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
                              number: 1,
                              start: passwordNode,
                              validator: (value) {
                                if (value.trim().length >= 7) {
                                  return null;
                                } else {
                                  return "Password must have atleast 7 character";
                                }
                              },
                              title: "Password",
                              controller: _password_controller,
                              see: see,
                              changesee: () {
                                setState(() {
                                  see = !see;
                                });
                              },
                            ),
                            OurSizedHeight(),
                            Row(
                              children: [
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    print("Forgot password");
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.indigo[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            OurSizedHeight(),
                            OurElevatedButton(
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  AlertWidget().showLoading(context);
                                  await Auth().loginAccount(
                                      _email_controller.value.text,
                                      _password_controller.value.text,
                                      context);
                                }
                              },
                              title: "Sign In",
                            ),
                            OurSizedHeight(),
                            OurSizedHeight(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignUpPage();
                                    }));
                                  },
                                  child: Text(
                                    "Sign up",
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
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
