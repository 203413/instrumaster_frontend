import 'package:flutter/material.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/icon.dart';

import '../../Domain/entities/profile.dart';
import '../../Domain/entities/user.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required int id,
    required User id_user,
    required IconProfile icon,
  }) : super(
          id: id,
          id_user: id_user,
          icon: icon,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      id_user: json['id_user'],
      icon: json['icon'],
    );
  }

  factory ProfileModel.fromEntity(Profile user) {
    return ProfileModel(
      id: user.id,
      id_user: user.id_user,
      icon: user.icon,
    );
  }
}
