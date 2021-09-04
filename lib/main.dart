import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobwale/provider/jobsProv.dart';
import 'package:jobwale/provider/recruMyJobProv.dart';
import 'package:jobwale/provider/userProv.dart';
import 'package:jobwale/screens/candidate/home.dart';
import 'package:jobwale/screens/common/representYou.dart';
import 'package:jobwale/screens/recruiter/myJobsScreen.dart';
import 'package:jobwale/utils/constants.dart';
import 'package:jobwale/utils/custompreferences.dart';
import 'package:jobwale/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// Check User Login Status
  var checkLoginStatus =
      await CustomPreferences.getPreferences(Constants.isLoggedIn);

  /// Check User Type Status
  var userType = await CustomPreferences.getPreferences(Constants.userType);
  runApp(MyApp(
    isLoginStatus: checkLoginStatus == 'Yes'
        ? userType == 'Candidate'
            ? Home()
            : RecruiterHome()
        : RepresentYou(),
  ));
}

class MyApp extends StatefulWidget {
  var isLoginStatus;

  MyApp({this.isLoginStatus});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProv()),
        ChangeNotifierProvider.value(value: JobsProv()),
        ChangeNotifierProvider.value(value: RecrProv()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          //currentFocus node check primary focus if doest not then call un focus
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Job Wale',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: FontFamily.SFPro,
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              }),
              primaryColorLight: AppColors.lightGrey,
              accentColor: AppColors.greyAccent,
              bottomAppBarColor: AppColors.lightGrey,
              backgroundColor: AppColors.white,
              dialogBackgroundColor: AppColors.white,
              errorColor: AppColors.greyAccent,
              dividerColor: Colors.transparent,
              primaryColor: AppColors.primaryColor,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: widget.isLoginStatus,
        ),
      ),
    );
  }
}
