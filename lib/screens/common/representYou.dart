import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobwale/screens/common/login.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/theme.dart';

class RepresentYou extends StatefulWidget {
  @override
  _RepresentYouState createState() => _RepresentYouState();
}

class _RepresentYouState extends State<RepresentYou> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoText(context),
                Common.sizeBoxHeight(size.height * 0.05),
                represtText(context),
                Common.sizeBoxHeight(size.height * 0.04),
                Common().buildMaterialButton(size, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(
                                userType: "0",
                              )));
                }, Constants.recruiter),
                Common.sizeBoxHeight(size.height * 0.04),
                Common().buildMaterialButton(size, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(
                                userType: "1",
                              )));
                }, Constants.candidate),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Text logoText(BuildContext context) {
    return Text(
      Constants.jobwale,
      style: TextStyle(
          fontSize: Common.displayWidth(context) * 0.1,
          fontWeight: FontWeight.w500,
          color: AppColors.toolBarTitleColor),
    );
  }

  Text represtText(BuildContext context) {
    return Text(
      Constants.represent,
      style: TextStyle(
          fontSize: Common.displayWidth(context) * 0.047,
          fontWeight: FontWeight.w700,
          color: AppColors.black),
    );
  }
}
