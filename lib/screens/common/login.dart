import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobwale/provider/userProv.dart';
import 'package:jobwale/screens/common/representYou.dart';
import 'package:jobwale/screens/common/signup.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/fadeAnimation.dart';
import 'package:jobwale/utils/theme.dart';
import 'package:jobwale/utils/validator.dart';
import 'package:provider/provider.dart';
import 'forgotPassword.dart';

class LoginScreen extends StatefulWidget {
  final String? userType;

  LoginScreen({this.userType});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailTextCtrl = TextEditingController();
  var passwordTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
              elevation: 0.0,
              backgroundColor: AppColors.white,
              leading: Platform.isIOS
                  ? IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RepresentYou()));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primaryColor,
                      ))
                  : SizedBox()),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Common.displayHeight(context) * 0.02),
                buildFadeAnimation(context),
                SizedBox(height: Common.displayHeight(context) * 0.04),
                buildContainer(),
                SizedBox(height: Common.displayHeight(context) * 0.04),
                buildRow(context),
                SizedBox(height: Common.displayHeight(context) * 0.02),
              ],
            ),
          )),
    );
  }

  Row buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'New to Jobwale?',
        ),
        SizedBox(width: 5.0),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignupScreen(
                          userType: widget.userType,
                        )));
          },
          child: Text(
            Constants.signupText,
            style: TextStyle(
              color: AppColors.darkBlueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Container buildContainer() {
    return Container(
        padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailTextCtrl,
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor))),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordTextCtrl,
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor))),
              obscureText: true,
            ),
            SizedBox(height: 5.0),
            Container(
              alignment: Alignment(1.0, 0.0),
              padding: EdgeInsets.only(top: 15.0, left: 20.0),
              child: InkWell(
                onTap: () {
                  Common.removeFocus(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserForgotPassword(
                                userType: widget.userType,
                              )));
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AppColors.darkBlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: Common.displayHeight(context) * 0.07),
            Container(
                alignment: Alignment.center,
                height: Common.displayHeight(context) * 0.07,
                width: Common.displayWidth(context),
                child: Common().buildMaterialButton(Common.displaySize(context),
                    () {
                  Common.removeFocus(context);
                  checkLoginData();
                }, Constants.loginText)),
            SizedBox(height: Common.displayHeight(context) * 0.07),
          ],
        ));
  }

  FadeAnimation buildFadeAnimation(BuildContext context) {
    return FadeAnimation(
        1,
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('JobWale',
                  style: TextStyle(
                      fontSize: Common.displayWidth(context) * 0.12,
                      fontWeight: FontWeight.bold)),
              Text('.com',
                  style: TextStyle(
                      fontSize: Common.displayWidth(context) * 0.12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor))
            ],
          ),
        ));
  }

  /// Check Login Data
  checkLoginData() {
    if (emailTextCtrl.text.isEmpty) {
      Common.showSnackBar(
          Constants.emptyEmailTxt, context, AppColors.snackBarBackErrorColor);
    } else if (!Validator.isValidEmail(emailTextCtrl.text.trim())) {
      Common.showSnackBar(
          Constants.validEmailTxt, context, AppColors.snackBarBackErrorColor);
    } else if (passwordTextCtrl.text.isEmpty) {
      Common.showSnackBar(
          Constants.passBlank, context, AppColors.snackBarBackErrorColor);
    } else {
      Provider.of<UserProv>(context, listen: false)
          .userLogin(emailTextCtrl.text, passwordTextCtrl.text, context);
    }
  }
}
