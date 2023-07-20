import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../users/Presentation/pages/profile.dart';

class CustomBottomNavigationBar extends StatelessWidget {
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
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    print('hola');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProfilePage(),
                      ),
                    );
                  },
                  child: Icon(Icons.person)),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
