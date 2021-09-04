import 'package:flutter/cupertino.dart';
import 'package:jobwale/modal/rec/addNewJobPOJO.dart';
import 'package:jobwale/modal/rec/myJobsPOJO.dart';
import 'package:jobwale/modal/rec/myjobApplied.dart' as Applied;
import 'package:jobwale/network/serviceAPI.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/theme.dart';

class RecrProv extends ChangeNotifier {
  bool isLoading = false;
  bool isAppliedLoading = false;
  bool isapply = false;
  var jobData = MyJobsPojo();
  var addJobData = AddJobsPojo();
  var appliedjob = Applied.MyJobAppliedPojo();
  List<Datum> jobsList = [];
  List<Applied.Datum> appliedList = [];

  void getAllJobs(BuildContext context) async {
    jobsList = [];
    var userData = await RemoteServices.recMyJob(context);
    if (userData != null) {
      if (userData.success == Constants.statusTrue) {
        jobData = userData;
        if (jobData.data != null) {
          jobsList.addAll(jobData.data!.data!);
          isLoading = true;
          notifyListeners();
        } else {
          isLoading = true;
          notifyListeners();
        }
      } else if (userData.success == Constants.statusFalse) {
        isLoading = true;
        notifyListeners();
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      } else {
        isLoading = true;
        notifyListeners();
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      }
    }
  }

  void addNewJob(
      String title, String dec, String loc, BuildContext context) async {
    Common.showLoading(context);
    var userData = await RemoteServices.addNewJob(title, dec, loc, context);
    if (userData != null) {
      Common.hideLoading(context);
      if (userData.success == Constants.statusTrue) {
        addJobData = userData;
        if (addJobData.data != null) {
          Navigator.pop(context);
          getAllJobs(context);

          // jobsList.add(addJobData.data);

          notifyListeners();
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

  void getMyJobApplied(String id, BuildContext context) async {
    appliedList = [];
    var userData = await RemoteServices.recMyAppliedJob(id, context);
    if (userData != null) {
      if (userData.success == Constants.statusTrue) {
        appliedjob = userData;
        appliedjob = userData;
        if (appliedjob.data != null) {
          appliedList.addAll(appliedjob.data!);
          isAppliedLoading = true;
          notifyListeners();
        } else {
          isAppliedLoading = true;
          notifyListeners();
        }
      } else if (userData.success == Constants.statusFalse) {
        isAppliedLoading = true;
        notifyListeners();
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      } else {
        isAppliedLoading = true;
        notifyListeners();
        Common.showSnackBar(
            Constants.serverError, context, AppColors.snackBarBackErrorColor);
      }
    }
  }
}
