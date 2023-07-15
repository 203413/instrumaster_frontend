import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/register.dart';
import 'package:line_icons/line_icons.dart';

import '../../../course/Presentation/pages/courses_page.dart';
import '../../../course/Presentation/pages/courses_page_test.dart';
import '../../../course/Presentation/pages/test.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final String value = 'instrumaster_logo_b&w.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFDBE00),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_image1.png'),
                repeat: ImageRepeat.repeat)),
        child: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 28,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset('assets/images/' + value),
                  ),
                ),
              ),
              Expanded(
                flex: 72,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                  ),
                  // single scroll
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 45, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                'assets/images/guitar.svg',
                                width: 45,
                                height: 45,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Username',
                            style: TextStyle(fontSize: 24),
                          ),
                          const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(
                                  0x40FDBE00,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(fontSize: 24),
                          ),
                          const TextField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(LineIcons.eye),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(
                                  0x40FDBE00,
                                )),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CoursesPagePage()));
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFDBE00),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Dont have and account?',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: ' Sing-up',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterPage()));
                                          },
                                        style: const TextStyle(
                                            color: Color(0xFFFDBE00)))
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  color: Colors.black,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 1,
                                  ),
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 3,
                                    right: 3,
                                  ),
                                  child: Text('Or login with'),
                                ),
                                Expanded(
                                    child: Container(
                                  color: Colors.black,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 1,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/google_icon.svg'),
                                SvgPicture.asset(
                                    'assets/images/facebook_logo.svg'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
