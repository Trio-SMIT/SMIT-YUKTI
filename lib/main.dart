import 'package:flutter/material.dart';
import 'screens/reg_otp.dart';
import 'screens/pass_acc.dart';
import 'Navigation.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'nav',
    // initialRoute: 'login_screen',
    // initialRoute: 'reg_screen',
    routes: {
      'reg_screen': (context) => Reg_OTP('Reg No./EMP ID', 'otp_screen',
          'i already have an account!', '', '', 'SIGNUP', 'login_screen'),
      'otp_screen': (context) => Reg_OTP('OTP', 'pass_screen', 'Resend OTP',
          'An OTP was sent to ', 'your email !', "VERIFY", ''),
      'pass_screen': (context) => Pass_Acc(
          'Create Password',
          'Confirm Password',
          'Next',
          'I already have an account',
          '',
          'Acc_screen',
          'login_screen',
          ''),
      'Acc_screen': (context) =>
          Pass_Acc('First Name', 'Last Name', 'Done', '', '', '', '', ''),
      'login_screen': (context) => Pass_Acc(
          'Email',
          'Password',
          'Login',
          'Forgot password!',
          "i don't have account",
          '',
          'reg_screen',
          'reg_screen'),
      'nav': (context) => Navigate(),
    },
  ));
}
