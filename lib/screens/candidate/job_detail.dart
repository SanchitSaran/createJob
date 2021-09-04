import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jobwale/modal/can/jobsPOJO.dart';
import 'package:jobwale/provider/jobsProv.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:provider/provider.dart';

class JobDetail extends StatefulWidget {
  final Datum? company;

  JobDetail({this.company});

  @override
  _JobDetailState createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  @override
  void initState() {
    Provider.of<JobsProv>(context, listen: false).isapply = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSilver,
        appBar: AppBar(
          backgroundColor: kSilver,
          elevation: 0,
          leading: IconButton(
            icon: Platform.isIOS
                ? Icon(
                    Icons.arrow_back_ios,
                    color: kBlack,
                  )
                : Icon(
                    Icons.arrow_back,
                    color: kBlack,
                  ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.company!.title.toString(),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          // margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 250.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Text(
                      widget.company!.title.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 25.0),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Description(widget.company),
              )
            ],
          ),
        ),
        bottomNavigationBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Container(
            padding: EdgeInsets.only(left: 18.0, bottom: 25.0, right: 18.0),
            // margin: EdgeInsets.only(bottom: 25.0),
            color: Colors.white,
            child: Consumer<JobsProv>(
              builder: (context, data, child) {
                return !data.isapply
                    ? Container(
                        alignment: Alignment.center,
                        height: Common.displayHeight(context) * 0.07,
                        width: Common.displayWidth(context),
                        child: Common().buildMaterialButton(
                            Common.displaySize(context), () {
                          Provider.of<JobsProv>(context, listen: false)
                              .applyJob(widget.company!.id.toString(), context);
                        }, Constants.applyJob))
                    : Container(
                        alignment: Alignment.center,
                        height: Common.displayHeight(context) * 0.07,
                        width: Common.displayWidth(context),
                        child: Common().buildMaterialButton(
                            Common.displaySize(context), () {}, 'Applied'));
              },
            ),
          ),
        ),
      ),
    );
  }

  Description(Datum? company) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Text(
            "About the Opportunity",
          ),
          SizedBox(height: 15.0),
          Text(
            company!.description.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w300,
              height: 1.5,
              color: Color(0xFF5B5B5B),
            ),
          ),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
