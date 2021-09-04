import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobwale/modal/registerPOJO.dart';
import 'package:jobwale/network/serviceAPI.dart';
import 'package:jobwale/screens/candidate/home.dart';
import 'package:jobwale/screens/common/ResetPassword.dart';
import 'package:jobwale/screens/common/login.dart';
import 'package:jobwale/screens/recruiter/myJobsScreen.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/custompreferences.dart';
import 'package:jobwale/utils/theme.dart';

class UserProv extends ChangeNotifier {
  var loginData = RegisterPojo();
  var registerData = RegisterPojo();
  var forgetData = RegisterPojo();
  var resetData = RegisterPojo();

  void userLogin(String emailID, String password, BuildContext context) async {
    Common.showLoading(context);
    var userData =
        await RemoteServices.userLoginData(emailID, password, context);
    if (userData != null) {
      Common.hideLoading(context);
      if (userData.success == Constants.statusTrue) {
        loginData = userData;
        if (loginData.data != null) {
          await CustomPreferences.setPreferences(
              Constants.loginToken, loginData.data!.token!.toString());
          await CustomPreferences.setPreferences(Constants.isLoggedIn, "Yes");
          //1 - Candi 0 - Recr
          if (loginData.data!.userRole == 1) {
            await CustomPreferences.setPreferences(
                Constants.userType, "Candidate");
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
          } else {
            await CustomPreferences.setPreferences(
                Constants.userType, "Recruiter");
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => RecruiterHome()),
                (Route<dynamic> route) => false);
          }
        } else {
          Common.showSnackBar(
              Constants.serverError, context, AppColors.snackBarBackErrorColor);
        }
      } else if (userData.success == Constants.statusFalse) {
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      } else {
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      }
    }
  }

  void userRegister(
      String name,
      String emailID,
      String password,
      String cpassword,
      String skills,
      int userType,
      BuildContext context) async {
    Common.showLoading(context);
    var userData = await RemoteServices.userRegisterData(
        name, emailID, password, cpassword, skills, userType, context);
    if (userData != null) {
      Common.hideLoading(context);
      if (userData.success == Constants.statusTrue) {
        registerData = userData;
        if (registerData.data != null) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    content: Text(
                      'Successfully Registered.',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen(
                                        userType: userType.toString(),
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'OK',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ),
                      )
                    ],
                  ));
        } else {
          Common.showSnackBar(
              Constants.serverError, context, AppColors.snackBarBackErrorColor);
        }
      } else if (userData.success == Constants.statusFalse) {
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      } else {
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      }
    }
  }

  void forgotPassword(
      String email, BuildContext context, String userType) async {
    Common.showLoading(context);
    var userData = await RemoteServices.forgetPassword(email, context);
    if (userData != null) {
      Common.hideLoading(context);
      if (userData.success == Constants.statusTrue) {
        forgetData = userData;
        if (forgetData.data != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserResetPassWord(
                        token: forgetData.data!.token,
                        userType: userType,
                      )));
        } else {}
      } else if (userData.success == Constants.statusFalse) {
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      } else {
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      }
    }
  }

  void changePassword(String pass, String cpass, String token,
      BuildContext context, String userType) async {
    Common.showLoading(context);
    var userData = await RemoteServices.changepass(pass, cpass, token, context);
    if (userData != null) {
      Common.hideLoading(context);
      if (userData.success == Constants.statusTrue) {
        forgetData = userData;
        if (forgetData.data != null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => LoginScreen(
                        userType: userType,
                      )),
              (Route<dynamic> route) => false);
        } else {}
      } else if (userData.success == Constants.statusFalse) {
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      } else {
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      }
    }
  }
}
