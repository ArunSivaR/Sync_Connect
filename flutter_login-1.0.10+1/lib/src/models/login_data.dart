import 'package:flutter/foundation.dart';

class LoginData {
  final String email;
  final String password;

  LoginData({
    @required this.email,
    @required this.password,
  });

  @override
  String toString() {
    return '$runtimeType($email, $password)';
  }
}

class SignupData{
  final String name;
  final String password;
  final String confirmPassword;

   SignupData({
    @required this.name,
    @required this.password,
    @required this.confirmPassword,
  });

   @override
  String toString() {
    return '$runtimeType($name, $password, $confirmPassword)';
  }
}
