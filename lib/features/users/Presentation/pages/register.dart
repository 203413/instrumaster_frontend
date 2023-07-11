import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/login.dart';
import 'package:line_icons/line_icons.dart';
import '../widgets/userWidgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc.dart';
import 'package:instrumaster_v1/features/users/domain/entities/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordAgain = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChecked = false;
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
                    child: SvgPicture.asset(
                        'assets/images/instrumaster_logo_b&w.svg'),
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
                                'Register',
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
                            height: 15,
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
                            height: 15,
                          ),
                          const Text(
                            'Email',
                            style: TextStyle(fontSize: 24),
                          ),
                          TextField(
                            controller: _mail,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(
                                  0x40FDBE00,
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(fontSize: 24),
                          ),
                          TextField(
                            controller: _password,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(LineIcons.eye),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(
                                  0x40FDBE00,
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Confirm password',
                            style: TextStyle(fontSize: 24),
                          ),
                          TextField(
                            controller: _passwordAgain,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(LineIcons.eye),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(
                                  0x40FDBE00,
                                )),
                          ),
                          CheckboxListTile(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: RichText(
                                text: const TextSpan(
                                    text: 'Términos y condiciones',
                                    style: TextStyle(color: Colors.black))),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    register(_mail.text, _username.text,
                                        _password.text, _passwordAgain.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFDBE00),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                    text: 'You have an account?',
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: ' Sing-in',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage()));
                                            },
                                          style: const TextStyle(
                                              color: Color(0xFFFDBE00)))
                                    ]),
                              ),
                            ),
                          ),
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

  void register(
      String mail, String username, String password, String password2) {
    if (mail == '' && username == '' && password == '' && password2 == '') {
      showAlertDialog("registro fallido", "Completa todos los campos", context);
    } else {
      var user = User(
        id_user: 0,
        username: username,
        email: mail,
        password: password,
      );
      BlocProvider.of<UserAuthentication>(context).add(Register(user: user));
      showAlertDialog(
          "Registrado con exito", "Por favor, inicia sesion ahora", context);
    }
  }
}
