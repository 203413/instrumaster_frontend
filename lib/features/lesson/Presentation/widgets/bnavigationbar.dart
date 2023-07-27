import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../users/Presentation/pages/profile.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  Future<void> _logOut(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false, // Ocultar las etiquetas seleccionadas
          showUnselectedLabels: false, // Ocul
          backgroundColor: Color(0xFFFDBE00),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/courses-svgrepo-com 2.svg'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  _logOut(context);
                },
                child: SvgPicture.asset(
                  'assets/images/logout.svg',
                  width: 60,
                ),
              ),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}
