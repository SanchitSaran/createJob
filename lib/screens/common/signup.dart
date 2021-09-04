import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobwale/provider/userProv.dart';
import 'package:jobwale/screens/common/login.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/fadeAnimation.dart';
import 'package:jobwale/utils/theme.dart';
import 'package:jobwale/utils/validator.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  final String? userType;

  SignupScreen({this.userType});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameTextCtrl = TextEditingController();
  var skillsTextCtrl = TextEditingController();
  var emailTextCtrl = TextEditingController();
  var passwordTextCtrl = TextEditingController();
  var confPasswordTextCtrl = TextEditingController();

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
                                builder: (context) => LoginScreen(
                                      userType: widget.userType,
                                    )));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primaryColor,
                      ))
                  : SizedBox()),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              buildFadeAnimation(context),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      buildNameField(),
                      SizedBox(height: Common.displayHeight(context) * 0.015),
                      buildEmailField(),
                      SizedBox(height: Common.displayHeight(context) * 0.015),
                      buildPassField(),
                      SizedBox(height: Common.displayHeight(context) * 0.015),
                      buildConPasField(),
                      SizedBox(height: Common.displayHeight(context) * 0.015),
                      buildSkillsField(),
                      SizedBox(height: Common.displayHeight(context) * 0.04),
                      Container(
                          alignment: Alignment.center,
                          height: Common.displayHeight(context) * 0.07,
                          width: Common.displayWidth(context),
                          child: Common().buildMaterialButton(
                              Common.displaySize(context), () {
                            Common.removeFocus(context);
                            _buildCheckSignup();
                          }, Constants.signupText)),
                      SizedBox(height: Common.displayHeight(context) * 0.02),
                      alreadyHaveText(Common.displaySize(context)),
                      SizedBox(height: Common.displayHeight(context) * 0.02),
                    ],
                  )),
            ]),
          )),
    );
  }

  alreadyHaveText(Size size) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.white,
      height: size.height * 0.08,
      child: RichText(
          text: TextSpan(
              style: TextStyle(
                  fontSize: size.width * 0.04, color: AppColors.black),
              children: <TextSpan>[
            TextSpan(
              text: Constants.alreadyHaveTxt,
            ),
            TextSpan(text: '\t\t'),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pop(context);
                },
              style: TextStyle(color: AppColors.darkBlueColor),
              text: Constants.loginText,
            ),
          ])),
    );
  }

  TextField buildSkillsField() {
    return TextField(
      controller: skillsTextCtrl,
      decoration: InputDecoration(
          labelText: 'SKILLS',
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor))),
    );
  }

  TextField buildConPasField() {
    return TextField(
      controller: confPasswordTextCtrl,
      decoration: InputDecoration(
          labelText: 'CONFIRM PASSWORD',
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor))),
      obscureText: true,
    );
  }

  TextField buildPassField() {
    return TextField(
      controller: passwordTextCtrl,
      decoration: InputDecoration(
          labelText: 'PASSWORD ',
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor))),
      obscureText: true,
    );
  }

  TextField buildEmailField() {
    return TextField(
      controller: emailTextCtrl,
      decoration: InputDecoration(
          labelText: 'EMAIL',
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor))),
    );
  }

  TextField buildNameField() {
    return TextField(
      controller: nameTextCtrl,
      decoration: InputDecoration(
          labelText: 'NAME',
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor))),
    );
  }

  FadeAnimation buildFadeAnimation(BuildContext context) {
    return FadeAnimation(
        1,
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Signup',
                    style: TextStyle(
                        fontSize: Common.displayWidth(context) * 0.12,
                        fontWeight: FontWeight.bold)),
                Text('.',
                    style: TextStyle(
                        fontSize: Common.displayWidth(context) * 0.12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor))
              ],
            ),
          ),
        ));
  }

  _buildCheckSignup() {
    if (nameTextCtrl.text.isEmpty) {
      Common.showSnackBar(
          Constants.nameReq, context, AppColors.snackBarBackErrorColor);
    } else if (nameTextCtrl.text.length < 3) {
      Common.showSnackBar(
          Constants.nameLength, context, AppColors.snackBarBackErrorColor);
    } else if (emailTextCtrl.text.isEmpty) {
      Common.showSnackBar(
          Constants.emptyEmailTxt, context, AppColors.snackBarBackErrorColor);
    } else if (!Validator.isValidEmail(emailTextCtrl.text.trim())) {
      Common.showSnackBar(
          Constants.validEmailTxt, context, AppColors.snackBarBackErrorColor);
    } else if (passwordTextCtrl.text.isEmpty) {
      Common.showSnackBar(
          Constants.passBlank, context, AppColors.snackBarBackErrorColor);
    } else if (!Validator.isValidPassword(passwordTextCtrl.text.trim())) {
      Common.showSnackBar(
          Constants.passwordLength, context, AppColors.snackBarBackErrorColor);
    } else if (passwordTextCtrl.text != confPasswordTextCtrl.text) {
      Common.showSnackBar(
          Constants.passMatch, context, AppColors.snackBarBackErrorColor);
    } else if (skillsTextCtrl.text.isEmpty) {
      Common.showSnackBar(
          Constants.skillReq, context, AppColors.snackBarBackErrorColor);
    } else {
      Common.removeFocus(context);
      Provider.of<UserProv>(context, listen: false).userRegister(
        nameTextCtrl.text,
        emailTextCtrl.text,
        passwordTextCtrl.text,
        confPasswordTextCtrl.text,
        skillsTextCtrl.text,
        int.parse(widget.userType.toString()),
        context,
      );
    }
  }
}
