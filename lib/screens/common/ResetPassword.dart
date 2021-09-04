import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobwale/provider/userProv.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/theme.dart';
import 'package:jobwale/utils/validator.dart';
import 'package:provider/provider.dart';

class UserResetPassWord extends StatefulWidget {
  UserResetPassWord({this.token, this.userType});

  final String? token, userType;

  @override
  _UserResetPassWordState createState() => _UserResetPassWordState();
}

class _UserResetPassWordState extends State<UserResetPassWord> {
  var newPassCtrl = TextEditingController();
  var confirmNewCtrl = TextEditingController();

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
                    Common.sizeBoxHeight(size.height * 0.1),
                    resetText(context),
                    Common.sizeBoxHeight(size.height * 0.018),
                    getHelp(context),
                    Common.sizeBoxHeight(size.height * 0.08),
                    newPassTextField(),
                    Common.sizeBoxHeight(size.height * 0.030),
                    confirmPassTextField(),
                    Common.sizeBoxHeight(size.height * 0.10),
                    Common().buildMaterialButton(size, () {
                      _buildResetPass();
                    }, 'Submit'),
                    Common.sizeBoxHeight(size.height * 0.025),
                  ],
                ),
              ),
            )));
  }

  Text resetText(BuildContext context) {
    return Text(
      Constants.resetPass,
      style: TextStyle(
          fontSize: Common.displayWidth(context) * 0.076,
          color: AppColors.black,
          fontWeight: FontWeight.w700),
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

  TextFormField confirmPassTextField() {
    return TextFormField(
      controller: confirmNewCtrl,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppColors.black,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      maxLength: 30,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10),
        counterText: '',
        disabledBorder: _underlineBorder,
        enabledBorder: _underlineBorder,
        errorBorder: _underlineBorder,
        focusedBorder: _underlineBorder,
        focusedErrorBorder: _underlineBorder,
        border: _underlineBorder,
        hintText: Constants.confirmPassText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.textGreyColor,
        ),
      ),
    );
  }

  TextFormField newPassTextField() {
    return TextFormField(
      controller: newPassCtrl,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppColors.black,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      maxLength: 30,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10),
        counterText: '',
        disabledBorder: _underlineBorder,
        enabledBorder: _underlineBorder,
        errorBorder: _underlineBorder,
        focusedBorder: _underlineBorder,
        focusedErrorBorder: _underlineBorder,
        border: _underlineBorder,
        hintText: Constants.newPassText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.textGreyColor,
        ),
      ),
    );
  }

  _buildResetPass() {
    if (newPassCtrl.text.isEmpty) {
      Common.showSnackBar(
          Constants.newPassEmpty, context, AppColors.snackBarBackErrorColor);
    } else if (confirmNewCtrl.text.isEmpty) {
      Common.showSnackBar(Constants.confirmPassEmpty, context,
          AppColors.snackBarBackErrorColor);
    } else if (newPassCtrl.text != confirmNewCtrl.text) {
      Common.showSnackBar(
          Constants.passMatch, context, AppColors.snackBarBackErrorColor);
    } else if (!Validator.isValidPassword(newPassCtrl.text.trim())) {
      Common.showSnackBar(
          Constants.passwordLength, context, AppColors.snackBarBackErrorColor);
    } else {
      Common.removeFocus(context);
      Provider.of<UserProv>(context, listen: false).changePassword(
          newPassCtrl.text,
          confirmNewCtrl.text,
          widget.token.toString(),
          context,
          widget.userType.toString());
    }
  }

  var _underlineBorder =
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.boxGreyColor));
}
