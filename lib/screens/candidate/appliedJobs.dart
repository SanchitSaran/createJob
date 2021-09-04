import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jobwale/modal/can/appliedJobPOJO.dart';
import 'package:jobwale/provider/jobsProv.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/noDataFound.dart';
import 'package:jobwale/utils/shimmerClass.dart';
import 'package:jobwale/utils/theme.dart';
import 'package:provider/provider.dart';

class AppliedJobsScreen extends StatefulWidget {
  @override
  _AppliedJobsScreenState createState() => _AppliedJobsScreenState();
}

class _AppliedJobsScreenState extends State<AppliedJobsScreen> {
  @override
  void initState() {
    Provider.of<JobsProv>(context, listen: false).isAppliedLoading = false;
    Provider.of<JobsProv>(context, listen: false).getAppliedJobs(context);
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
            'Applied Jobs',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Consumer<JobsProv>(
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

  recentJobs(JobsProv data) {
    if (data.isAppliedLoading == false) {
      return ShimmerListWithImg(
        height: MediaQuery.of(context).size.height * 0.10,
      );
    } else {
      return data.appliedJobsList.length == 0
          ? NoDataFound(
              size: MediaQuery.of(context).size.height * 0.40,
            )
          : ListView.builder(
              itemCount: data.appliedJobsList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                var recent = data.appliedJobsList[index];
                return InkWell(
                  onTap: () {},
                  child: AppliedJobCard(data.appliedJobsList[index]),
                );
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
          child: Icon(Icons.computer),
        ),
        title: Text(
          company.title.toString(),
        ),
        subtitle: Text(
          " ${company.location}",
        ),
      ),
    );
  }
}
