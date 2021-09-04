import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'theme.dart';

class Common {
  final addressCtrl = TextEditingController();
  double? lat, long;
  String? getAddress;

  //Size box for width
  static Widget sizeBoxWidth(double width) {
    return SizedBox(
      width: width,
    );
  }

  static Widget sizeBoxHeight(double height) {
    return SizedBox(
      height: height,
    );
  }

  static Size displaySize(BuildContext context) {
    //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    // debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  static double displayWidth(BuildContext context) {
    //debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }

  static Widget divider(Color color, double size) {
    return Divider(
//      height:size,
      thickness: size,
      color: color,
    );
  }

  static focusRemove(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    //hasPrimaryFocus is necessary to prevent Flutter from
    // throwing an exception when trying to un focus the node at the top of the tree
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  //hide keyboard
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  //show no record error
  static Widget noRecordFoundError() {
    return Center(
      child: new Text(
        'No Record Found',
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  // No Record Found
  static Widget noRecordFound(BuildContext context, String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  static fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static removeFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    //hasPrimaryFocus is necessary to prevent Flutter from
    // throwing an exception when trying to un focus the node at the top of the tree
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static showSnackBar(
      String message, BuildContext context, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  //Loading indicator
  static Widget loadingIndicator(Color color) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Container(
            height: 30.0,
            width: 30.0,
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      color,
                    ),
                  ),
          )),
        ]);
  }

  //Show Dialog Popup
  static Future<void> viewDialog(BuildContext context, String message) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Platform.isIOS
              ? CupertinoAlertDialog(
                  title: Text('Alert',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold)),
                  content: Text(message),
                  actions: <Widget>[
                    Center(
                      child: TextButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                )
              : AlertDialog(
                  title: Text('Alert',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold)),
                  content: Text(message),
                  actions: <Widget>[
                    Center(
                      child: TextButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                );
        });
  }

  //Show loading dialog
  static showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
              child: Container(
            width: MediaQuery.of(context).size.width * 0.70,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Platform.isIOS
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                AppColors.primaryColor),
                            strokeWidth: 2.0,
                          ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(
                        'Please Wait...',
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    )
//                      : SizedBox(),
                  ]),
            ),
          )),
        );
      },
    );
  }

  //Hide loading dialog
  static hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  MaterialButton buildMaterialButton(
      Size size, VoidCallback function, String message) {
    return MaterialButton(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.primaryColor)),
      height: size.height * 0.07,
      color: AppColors.primaryColor,
      onPressed: function,
      minWidth: size.width * 0.8,
      child: Center(
        child: Text(
          message,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.043,
              fontFamily: FontFamily.Roboto),
        ),
      ),
    );
  }
}
