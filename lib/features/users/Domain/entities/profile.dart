import 'package:flutter/material.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/icon.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/user.dart';

class Profile {
  int id;
  User id_user;
  IconProfile icon;

  Profile({
    required this.id,
    required this.id_user,
    required this.icon,
  });
}
