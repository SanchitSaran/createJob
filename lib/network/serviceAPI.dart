import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jobwale/modal/can/appliedJobPOJO.dart';
import 'package:jobwale/modal/can/applyJobPOJO.dart';
import 'package:jobwale/modal/can/jobsPOJO.dart';
import 'package:jobwale/modal/rec/addNewJobPOJO.dart';
import 'package:jobwale/modal/rec/myJobsPOJO.dart';
import 'package:jobwale/modal/rec/myjobApplied.dart';
import 'package:jobwale/modal/registerPOJO.dart';
import 'package:jobwale/utils/common.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/custompreferences.dart';
import 'package:jobwale/utils/theme.dart';
import 'dart:convert';
import 'Urls.dart';
import '../network/execptions.dart';

class RemoteServices {
  ///******************User Login******************///
  static Future<RegisterPojo?> userLoginData(
      String emailID, String password, BuildContext context) async {
    String url = Urls.baseUrl + Urls.userLogin;
    try {
      Dio dio = Dio();
      final response = await dio.post(
        url,
        data: {
          "email": emailID,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return registerPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return registerPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();
        Common.hideLoading(context);
        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }

    return null;
  }

  ///******************User Register******************///
  static Future<RegisterPojo?> userRegisterData(
      String name,
      String emailID,
      String password,
      String cpassword,
      String skills,
      int userType,
      BuildContext context) async {
    String url = Urls.baseUrl + Urls.userRegister;
    try {
      Dio dio = Dio();
      final response = await dio.post(
        url,
        data: {
          "email": emailID,
          "userRole": userType,
          "password": password,
          "confirmPassword": cpassword,
          "name": name,
          "skills": skills
        },
      );
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return registerPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return registerPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();
        Common.hideLoading(context);
        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }

    return null;
  }

  ///******************Forgot Password****************************///
  static Future<RegisterPojo?> forgetPassword(
      String emailID, BuildContext context) async {
    String url = Urls.baseUrl + Urls.resetPassword + '$emailID';
    try {
      Dio dio = Dio();
      final response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return registerPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return registerPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();
        Common.hideLoading(context);
        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }
  }

  ///******************Change Password******************///
  static Future<RegisterPojo?> changepass(String password, String cpassword,
      String token, BuildContext context) async {
    String url = Urls.baseUrl + Urls.changePassword;
    try {
      Dio dio = Dio();
      final response = await dio.post(url, data: {
        "password": password,
        "confirmPassword": cpassword,
        "token": token
      });
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return registerPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return registerPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();
        Common.hideLoading(context);
        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }

    return null;
  }

  ///******************Get Jobs ******************///
  static Future<JobsPojo?> jobsData(BuildContext context) async {
    String url = Urls.baseUrl + Urls.getJobs;
    try {
      String token =
          await CustomPreferences.getPreferences(Constants.loginToken);
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      final response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return jobsPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return jobsPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();

        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }

    return null;
  }

  ///******************apply job******************///
  static Future<ApplyJobPojo?> applyJob(
      String jobId, BuildContext context) async {
    String url = Urls.baseUrl + Urls.applyJobs;
    try {
      String token =
          await CustomPreferences.getPreferences(Constants.loginToken);
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      final response = await dio.post(
        url,
        data: {'jobId': jobId},
      );
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return applyJobPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return applyJobPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();
        Common.hideLoading(context);
        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }

    return null;
  }

  ///******************Get Applied Jobs ******************///
  static Future<AppliedJobPojo?> appliedJobsData(BuildContext context) async {
    String url = Urls.baseUrl + Urls.appliedJobs;
    try {
      String token =
          await CustomPreferences.getPreferences(Constants.loginToken);
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      final response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return appliedJobPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return appliedJobPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();

        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }

    return null;
  }

  ///******************Get Recru MyJobs ******************///
  static Future<MyJobsPojo?> recMyJob(BuildContext context) async {
    String url = Urls.baseUrl + Urls.myJob;
    try {
      String token =
          await CustomPreferences.getPreferences(Constants.loginToken);
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      final response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return myJobsPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return myJobsPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();

        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }

    return null;
  }

  ///******************add new job******************///
  static Future<AddJobsPojo?> addNewJob(String title, String description,
      String location, BuildContext context) async {
    String url = Urls.baseUrl + Urls.createJob;
    try {
      String token =
          await CustomPreferences.getPreferences(Constants.loginToken);
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      final response = await dio.post(url, data: {
        "title": title,
        "description": description,
        "location": location
      });
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return addJobsPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return addJobsPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();
        Common.hideLoading(context);
        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }

    return null;
  }

  ///******************Get MyJobs Applied ******************///
  static Future<MyJobAppliedPojo?> recMyAppliedJob(
      String id, BuildContext context) async {
    String url = Urls.baseUrl + Urls.myJob + id + '/candidates';
    try {
      String token =
          await CustomPreferences.getPreferences(Constants.loginToken);
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      final response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        var jsonString = json.encode(response.data);
        return myJobAppliedPojoFromJson(jsonString);
      } else if (response.statusCode == 201) {
        var jsonString = json.encode(response.data);
        return myJobAppliedPojoFromJson(jsonString);
      }
    } catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code
        final errorMessage = DioExceptions.fromDioError(e).toString();

        Common.showSnackBar(
            errorMessage, context, AppColors.snackBarBackErrorColor);
      }
    }

    return null;
  }
}
