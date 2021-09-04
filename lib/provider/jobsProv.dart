import 'package:flutter/cupertino.dart';
import 'package:jobwale/modal/can/appliedJobPOJO.dart' as Applied;
import 'package:jobwale/modal/can/applyJobPOJO.dart';
import 'package:jobwale/modal/can/jobsPOJO.dart';
import 'package:jobwale/network/serviceAPI.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/theme.dart';

class JobsProv extends ChangeNotifier {
  bool isLoading = false;
  bool isAppliedLoading = false;
  bool isapply = false;
  var jobData = JobsPojo();
  var applyjob = ApplyJobPojo();
  var appliedjob = Applied.AppliedJobPojo();
  List<Datum> jobsList = [];
  List<Applied.Datum> appliedJobsList = [];

  void getAllJobs(BuildContext context) async {
    jobsList = [];
    var userData = await RemoteServices.jobsData(context);
    if (userData != null) {
      if (userData.success == Constants.statusTrue) {
        jobData = userData;
        if (jobData.data != null) {
          jobsList.addAll(jobData.data!);
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

  void applyJob(String jobID, BuildContext context) async {
    Common.showLoading(context);
    var userData = await RemoteServices.applyJob(jobID, context);
    if (userData != null) {
      Common.hideLoading(context);
      if (userData.success == Constants.statusTrue) {
        applyjob = userData;
        if (applyjob.data != null) {
          isapply = true;
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

  void getAppliedJobs(BuildContext context) async {
    appliedJobsList = [];
    var userData = await RemoteServices.appliedJobsData(context);
    if (userData != null) {
      if (userData.success == Constants.statusTrue) {
        appliedjob = userData;
        if (appliedjob.data != null) {
          appliedJobsList.addAll(appliedjob.data!);
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
