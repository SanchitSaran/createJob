import 'package:flutter/material.dart';
import 'package:jobwale/modal/can/jobsPOJO.dart';
import 'package:jobwale/provider/jobsProv.dart';
import 'package:jobwale/screens/candidate/appliedJobs.dart';
import 'package:jobwale/screens/common/representYou.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/custompreferences.dart';
import 'package:jobwale/utils/noDataFound.dart';
import 'package:jobwale/utils/shimmerClass.dart';
import 'package:jobwale/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'job_detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<JobsProv>(context, listen: false).getAllJobs(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSilver,
        appBar: AppBar(
          leading: null,
          title: Text(
            'My Jobs',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                _logoutPopupDialog(context, Common.displaySize(context));
              },
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(left: 18.0),
          child: SingleChildScrollView(
            child: Consumer<JobsProv>(
              builder: (context, data, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: Common.displayHeight(context) * 0.02),
                    Text(
                      'Find your Dream Job',
                    ),
                    SizedBox(height: Common.displayHeight(context) * 0.02),
                    buildContainer(),
                    SizedBox(height: 35.0),
                    Text(
                      "Popular Company",
                    ),
                    SizedBox(height: 15.0),
                    popularJobs(data),
                    SizedBox(height: 35.0),
                    Text(
                      "Recent Jobs",
                    ),
                    recentJobs(data),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  recentJobs(JobsProv data) {
    if (data.isLoading == false) {
      return ShimmerListWithImg(
        height: MediaQuery.of(context).size.height * 0.10,
      );
    } else {
      return data.jobsList.length == 0
          ? NoDataFound(
              size: MediaQuery.of(context).size.height * 0.40,
            )
          : ListView.builder(
              itemCount: data.jobsList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                var recent = data.jobsList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetail(
                          company: data.jobsList[index],
                        ),
                      ),
                    );
                  },
                  child: RecentJobCards(recent),
                );
              },
            );
    }
  }

  popularJobs(JobsProv data) {
    if (data.isLoading == false) {
      return Container(
        width: double.infinity,
        height: 190.0,
        child: Shimmer.fromColors(
            direction: ShimmerDirection.ttb,
            baseColor: AppColors.lightGreyColor,
            highlightColor: Colors.white,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: 280.0,
                    margin: EdgeInsets.only(right: 15.0),
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: kBlack,
                    ),
                    child: SizedBox(),
                  ),
                );
              },
            )),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 190.0,
        child: data.jobsList.length == 0
            ? NoDataFound(
                size: MediaQuery.of(context).size.height * 0.40,
              )
            : ListView.builder(
                itemCount: data.jobsList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var company = data.jobsList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetail(
                            company: data.jobsList[index],
                          ),
                        ),
                      );
                    },
                    child: index % 2 == 0
                        ? CompanyCard1(company)
                        : CompanyCard2(company),
                  );
                },
              ),
      );
    }
  }

  Container buildContainer() {
    return Container(
      width: double.infinity,
      height: 50.0,
      margin: EdgeInsets.only(right: 18.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                enabled: false,
                cursorColor: kBlack,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    size: 25.0,
                    color: kBlack,
                  ),
                  border: InputBorder.none,
                  hintText: "Search for job title",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AppliedJobsScreen()));
            },
            child: Container(
              width: 50.0,
              height: 50.0,
              margin: EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  _logoutPopupDialog(BuildContext context, Size size) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              width: size.width * 0.7,
              height: size.height * 0.22,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      Constants.logOut,
                      style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Common.sizeBoxHeight(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: AppColors.white,
                        height: size.height * 0.06,
                        minWidth: size.width * 0.3,
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'NO',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      MaterialButton(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: AppColors.primaryColor,
                        height: size.height * 0.06,
                        minWidth: size.width * 0.3,
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          CustomPreferences.clearAll().then((_) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RepresentYou()),
                                (route) => false);
                          });
                        },
                        child: const Text(
                          'YES',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  RecentJobCards(Datum company) {
    return Card(
      elevation: 0.0,
      shadowColor: Color(0xFF656565).withOpacity(0.15),
      margin: EdgeInsets.only(right: 18.0, top: 15.0),
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
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: kBlack,
        ),
      ),
    );
  }

  CompanyCard1(Datum company) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.only(right: 15.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: kBlack,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 15.0),
            Text(
              company.title.toString(),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: company.description,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "  •  ",
                  ),
                  TextSpan(
                    text: company.location,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  CompanyCard2(Datum company) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.only(right: 15.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(height: 15.0),
          Text(
            company.title.toString(),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 15.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: company.description,
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "  •  ",
                ),
                TextSpan(
                  text: company.location,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
