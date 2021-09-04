import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jobwale/modal/rec/myjobApplied.dart';
import 'package:jobwale/provider/recruMyJobProv.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/noDataFound.dart';
import 'package:jobwale/utils/shimmerClass.dart';
import 'package:jobwale/utils/theme.dart';
import 'package:provider/provider.dart';

class AppliedMyJobsScreen extends StatefulWidget {
  final String? id;

  AppliedMyJobsScreen({this.id});

  @override
  _AppliedMyJobsScreenState createState() => _AppliedMyJobsScreenState();
}

class _AppliedMyJobsScreenState extends State<AppliedMyJobsScreen> {
  @override
  void initState() {
    Provider.of<RecrProv>(context, listen: false).isAppliedLoading = false;
    Provider.of<RecrProv>(context, listen: false)
        .getMyJobApplied(widget.id.toString(), context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSilver,
        appBar: AppBar(
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
            'Applied Candidates',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Consumer<RecrProv>(
          builder: (context, data, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: Common.displayHeight(context),
                width: Common.displayWidth(context),
                child: recentJobs(data),
              ),
            );
          },
        ),
      ),
    );
  }

  recentJobs(RecrProv data) {
    if (data.isAppliedLoading == false) {
      return ShimmerListWithImg(
        height: MediaQuery.of(context).size.height * 0.10,
      );
    } else {
      return data.appliedList.length == 0
          ? NoDataFound(
              size: MediaQuery.of(context).size.height * 0.40,
            )
          : ListView.builder(
              itemCount: data.appliedList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                var recent = data.appliedList[index];
                return AppliedJobCard(data.appliedList[index]);
              },
            );
    }
  }

  AppliedJobCard(Datum company) {
    return Card(
      elevation: 0.0,
      shadowColor: Color(0xFF656565).withOpacity(0.15),
      margin: EdgeInsets.only(right: 15.0, top: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          child: Icon(Icons.people),
        ),
        title: Text(
          company.name.toString(),
        ),
        subtitle: Text(
          "${company.email}  ${company.skills}",
        ),
      ),
    );
  }
}
