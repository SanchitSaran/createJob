import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jobwale/provider/recruMyJobProv.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/theme.dart';
import 'package:provider/provider.dart';

class AddNewCouponScreen extends StatefulWidget {
  @override
  _AddNewCouponScreenState createState() => _AddNewCouponScreenState();
}

class _AddNewCouponScreenState extends State<AddNewCouponScreen> {
  var titleTextCtrl = TextEditingController();
  var descTextCtrl = TextEditingController();
  var locTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var appbar = AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Platform.isIOS
            ? Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )
            : Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Add New Job',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
    return SafeArea(
      child: Scaffold(
        appBar: appbar,
        body: Container(
          height: size.height * 1,
          width: size.width * 1,
          padding: EdgeInsets.all(10),
          color: AppColors.white,
          child: Column(
            children: [
              titleFormField(),
              Common.sizeBoxHeight(20),
              descTextFormField(size),
              Common.sizeBoxHeight(20),
              locTextFormField(size),
            ],
          ),
        ),
        bottomSheet: _addJob(size),
      ),
    );
  }

  // Coupon Title
  titleFormField() {
    return TextField(
      controller: titleTextCtrl,
      decoration: InputDecoration(
          labelText: 'Title',
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor))),
    );
  }

  // Discount
  descTextFormField(Size size) {
    return TextField(
      controller: descTextCtrl,
      decoration: InputDecoration(
          labelText: 'Description',
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor))),
    );
  }

  // Add Coupon
  _addJob(Size size) {
    return Container(
      height: size.height * 0.09,
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      child: Common().buildMaterialButton(MediaQuery.of(context).size, () {
        __buildCheck();
      }, Constants.add),
    );
  }

  __buildCheck() {
    if (titleTextCtrl.text.isEmpty) {
      Common.showSnackBar(
          'Please enter title', context, AppColors.snackBarBackErrorColor);
    } else if (descTextCtrl.text.length < 3) {
      Common.showSnackBar('Length should me more than 3', context,
          AppColors.snackBarBackErrorColor);
    } else if (descTextCtrl.text.isEmpty) {
      Common.showSnackBar('Please enter description', context,
          AppColors.snackBarBackErrorColor);
    } else if (locTextCtrl.text.isEmpty) {
      Common.showSnackBar(
          'Please enter location', context, AppColors.snackBarBackErrorColor);
    } else {
      Common.removeFocus(context);
      Provider.of<RecrProv>(context, listen: false).addNewJob(
          titleTextCtrl.text, descTextCtrl.text, locTextCtrl.text, context);
    }
  }

  // Input Border Outline
  var _underlineBorder =
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.boxGreyColor));

  locTextFormField(Size size) {
    return TextField(
      controller: locTextCtrl,
      decoration: InputDecoration(
          labelText: 'Location',
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor))),
    );
  }
}
