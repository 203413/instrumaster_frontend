import "package:flutter/material.dart";
import "package:instrumaster_v1/features/users/Presentation/pages/login.dart";

class Passthrough extends StatelessWidget {
  const Passthrough({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: const Text("LoginButton"),
        ),
      ),
    );
  }
}
