import 'package:flutter/material.dart';
import 'constants.dart';

class NoDataFound extends StatelessWidget {
  final double? size;
  final String? msg;
  final String? img;

  const NoDataFound({this.size, this.msg, this.img});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            img ?? Constants.noDataImg,
            height: size ?? height * 0.5,
          ),
          Text(
            msg ?? 'No Record Found',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
