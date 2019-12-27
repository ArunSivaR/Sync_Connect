import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:hackathon_sync_connect/customer/customer_home_page.dart';
import 'package:hackathon_sync_connect/employee/employee_home_page.dart';
import 'constants.dart';
import 'custom_route.dart';
import './main.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/auth';
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  String _email, _password, _confirmPassword;
  Home_Page_State home_page_state;

  Future<String> _signupUser(SignupData signupData) {
    _email = signupData.name;
    _password = signupData.password;
    _confirmPassword = signupData.confirmPassword;
    return Future.delayed(loginTime).then((_) async {
      try {
        AuthResult result = await auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        FirebaseUser user = result.user;
        await user.sendEmailVerification();
          Navigator.of(context).pushReplacement(FadePageRoute(
            builder: (context) => LoginScreen(),
          ));
      } catch (e) {
        print(e);
      }
    });
  }

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      try {
        AuthResult authResult = await auth.signInWithEmailAndPassword(
            email: data.email, password: data.password);
        FirebaseUser user = authResult.user;
        if (user != null && user.isEmailVerified) {
          if (home_page_state.currenUserData.index == 0) {
            Navigator.of(context).pushReplacement(FadePageRoute(
              builder: (context) => EmployeeHomePage(),
            ));
          } else {
            Navigator.of(context).pushReplacement(
                FadePageRoute(builder: (context) => CustomerHomePage()));
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text('Your email id is not verified with this app'));
            },
          );
          Navigator.of(context).pushReplacement(FadePageRoute(
            builder: (context) => LoginScreen(),
          ));
        }
      } catch (e) {
        print(e.code);
        switch (e.code) {
          case 'ERROR_INVALID_EMAIL':
            print('Invalid Email');
            break;
          case 'ERROR_USER_NOT_FOUND':
            print('User Not Found');
            break;
          case 'ERROR_WRONG_PASSWORD':
            print('Wrong Password');
            break;
          default:
            print('Error');
            break;
        }
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String email) {
    return Future.delayed(loginTime).then((_) {
      auth.sendPasswordResetEmail(email: email);

      return null;
    });
  }

  @override
  void initState() {
    home_page_state = current_User_login.currentState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Constants.appName,
      logo: 'assets/images/sync.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      emailValidator: (value) {
        if (value.isEmpty) {
          return "Email is empty";
        }
        if (!value.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        _loginUser(loginData);
      },
      onSignup: (signupData) {
        _signupUser(signupData);
      },
      onRecoverPassword: (_email) {
        _recoverPassword(_email);
      },
    );
  }
}
