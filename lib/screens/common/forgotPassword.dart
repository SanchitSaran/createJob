import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobwale/provider/userProv.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/theme.dart';
import 'package:jobwale/utils/validator.dart';
import 'package:provider/provider.dart';

class UserForgotPassword extends StatefulWidget {
  final String? userType;

  UserForgotPassword({this.userType});

  @override
  _UserForgotPasswordState createState() => _UserForgotPasswordState();
}

class _UserForgotPasswordState extends State<UserForgotPassword> {
  var emailTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.white,
          leading: Platform.isIOS
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                  ))
              : SizedBox()),
      body: Container(
        padding: EdgeInsets.all(15),
        color: AppColors.white,
        height: size.height * 1,
        width: size.width * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Common.sizeBoxHeight(size.height * 0.18),
              forgotPassText(context),
              Common.sizeBoxHeight(size.height * 0.02),
              getHelp(context),
              Common.sizeBoxHeight(size.height * 0.05),
              emailTextField(),
              Common.sizeBoxHeight(size.height * 0.05),
              Common().buildMaterialButton(size, () {
                _buildForgotPass();
              }, 'Submit'),
              Common.sizeBoxHeight(size.height * 0.3),
            ],
          ),
        ),
      ),
      bottomSheet: alreadyHaveText(size),
    ));
  }

  Text cenaText(BuildContext context) {
    return Text(
      Constants.jobwale,
      style: TextStyle(
          fontSize: Common.displayWidth(context) * 0.1,
          fontWeight: FontWeight.w500,
          color: AppColors.toolBarTitleColor),
    );
  }

  Text getHelp(BuildContext context) {
    return Text(
      Constants.getHelpText,
      style: TextStyle(
          fontSize: Common.displayWidth(context) * 0.03,
          fontWeight: FontWeight.w400,
          color: AppColors.textGreyColor),
    );
  }

  Text forgotPassText(BuildContext context) {
    return Text(
      Constants.forgotPass,
      style: TextStyle(
          fontSize: Common.displayWidth(context) * 0.076,
          color: AppColors.black,
          fontWeight: FontWeight.w700),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      controller: emailTextCtrl,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppColors.black,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      maxLength: 30,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10),
        counterText: '',
        disabledBorder: _underlineBorder,
        enabledBorder: _underlineBorder,
        errorBorder: _underlineBorder,
        focusedBorder: _underlineBorder,
        focusedErrorBorder: _underlineBorder,
        border: _underlineBorder,
        hintText: Constants.emailAddText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.textGreyColor,
        ),
      ),
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

  _buildForgotPass() {
    if (emailTextCtrl.text.isEmpty) {
      Common.showSnackBar(
          Constants.emptyEmailTxt, context, AppColors.snackBarBackErrorColor);
    } else if (!Validator.isValidEmail(emailTextCtrl.text.trim())) {
      Common.showSnackBar(
          Constants.validEmailTxt, context, AppColors.snackBarBackErrorColor);
    } else {
      Common.removeFocus(context);

      Provider.of<UserProv>(context, listen: false).forgotPassword(
          emailTextCtrl.text, context, widget.userType.toString());
    }
  }

  var _underlineBorder =
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.boxGreyColor));
}
