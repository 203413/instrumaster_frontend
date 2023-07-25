// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/profile.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/register.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/userWidgets.dart';
import 'package:instrumaster_v1/features/users/presentation/blocs/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import '../../../course/Presentation/pages/courses_page.dart';
// import '../../../course/Presentation/pages/courses_page_test.dart';
// import '../../../course/Presentation/pages/test.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final String value = 'instrumaster_logo_b&w';

  Future<void> testLogin(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(username);
    final api = "https://instrumaster.iothings.com.mx/api/v1/login/";
    final data = {
      "username": username,
      "password": password,
    };
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      print("yeaaaaaah");
      int id = responseData['id'];
      String token = responseData['token'];
      await prefs.setString("Token", token);
      await prefs.setInt("user_id", id);
      print('PREFERENCIAS COMPARTIDAS PRUEBA' +
          prefs.getInt('user_id').toString());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        ),
      );
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFFDBE00),
      body: Container(
        decoration: const BoxDecoration(
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
                    child: SvgPicture.asset('assets/images/' + value + ".svg"),
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 45, 20, 0),
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
                              const SizedBox(
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
                          TextField(
                            controller: _username,
                            decoration: const InputDecoration(
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
                          TextField(
                            controller: _password,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
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
                                  onPressed: () async {
                                    print("Hello");
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    testLogin(_username.text, _password.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFDBE00),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Dont have and account?',
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: ' Sing-up',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RegisterPage()));
                                          },
                                        style: const TextStyle(
                                            color: Color(0xFFFDBE00)))
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  color: Colors.black,
                                  child: const SizedBox(
                                    width: double.infinity,
                                    height: 1,
                                  ),
                                )),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 3,
                                    right: 3,
                                  ),
                                  child: Text('Or login with'),
                                ),
                                Expanded(
                                    child: Container(
                                  color: Colors.black,
                                  child: const SizedBox(
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

  void loginMethod(String username, String password) async {
    if (username == '' && password == '') {
      showAlertDialog("Acceso denegado", "Completa ambos campos", context);
    } else {
      BlocProvider.of<UserAuthentication>(context)
          .add(Login(username: username, password: password));
    }
  }
}
