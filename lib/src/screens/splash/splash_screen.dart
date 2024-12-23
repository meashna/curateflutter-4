import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


//////////////////////////////////////////////////////////////////////////
  /*final _preferences = GetIt.I<PreferencesManager>();
  final _userRepository = GetIt.I<UserRepository>();
  bool animate = false;
  bool isToken = false;
  bool isScore = false;
  bool isProfile = false;
  bool isCrital = false;
  bool isSoft = false;
  String? packageName;

  @override
  void initState() {
    getPrefData();
    *//* Future.delayed(Duration(milliseconds: 1000),(){ });*//*
    super.initState();
  }

  Future<String?> _getFcmToken() async {
    return FirebaseMessaging.instance.getToken();
  }


  bool checkAppVersion(String firstVersion, String secondVersion){
    final List<String> first = firstVersion.split('.');
    final List<String> second = secondVersion.split('.');
    bool isHigher = false;

    // Here im equaliting the length of the versions
    if (first.length > second.length) {
      final size = first.length - second.length;
      for (var i = 0; i < size; i++) {
        second.add('0');
      }
    } else {
      final size = second.length - first.length;
      for (var i = 0; i < size; i++) {
        first.add('0');
      }
    }



    // Here im comparing the versions
    for (var i = 0; i < (first.length); i++) {
      isHigher =
          int.parse(first[i]) > int.parse(second[i]);
      if (int.parse(first[i]) != int.parse(second[i])){
        break;
      }
    }



    print("Versions:");
    print('a = $firstVersion \nb = $secondVersion');
    print('\nIs a higher than b?');
    print(isHigher);
    return isHigher;
  }

  getPrefData() async {
    try {
      var response = await _userRepository.getAppVersion();
      if (response.status == Status.COMPLETED) {
        AppVersionResponse? appVersion = response.data;
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String soft,critical;
        if(Platform.isAndroid){
          soft = appVersion!.androidSoft ?? "";
          critical = appVersion.androidCritical ?? "";
        }else{
          soft = appVersion!.iosSoft ?? "";
          critical = appVersion.iosCritical ?? "";
        }
        String version = packageInfo.version;

        //String appName = packageInfo.appName;
        packageName = packageInfo.packageName;

        if(checkAppVersion(critical, version)){
          isCrital = true;
          if(mounted){
            setState(() {});
          }
          return;
        }
        if(checkAppVersion(soft, version)){
          isSoft = true;
          if(mounted){
            setState(() {});
          }
          return;
        }


      }
      else {

      }
    } catch (e) {
      print("app version error");
      print(e);
    }
    String? tokenData = await _preferences.getUserToken();
    String? scoreData = await _preferences.getWellBeingScore();
    PersonalInfo? profileData = await _preferences.getUserProfile();
    isToken = (tokenData ?? "").isNotEmpty;
    isScore = ((scoreData ?? "").isNotEmpty) && ((scoreData ?? "0") != "0");
    isProfile = profileData != null;
    print("token ygih");
    print("Is Tokeeeeeennnnnnnnnnnnnnnn");
    print(isToken);
    String token = await _getFcmToken() ?? "";
    print(token);
    if(isToken){
      try {
        var response = await _userRepository.consultantProductStatus();

        if (response.status == Status.COMPLETED) {
          ConsultantPaymentStatusResponse? consultantPaymentStatusResponse = response.data;
          if(consultantPaymentStatusResponse != null){
            num? currPlanStatus = consultantPaymentStatusResponse.talkToExpertStatus?.currPlanStatus;
            if(currPlanStatus!= null){
              if(currPlanStatus == 3){
                RouteNavigator.popIfCanPop(context);
                RouteNavigator.pushReplacement(context, AppScreens.mainScreen);
                return;
              }else if(currPlanStatus == 2){

                Map<String,dynamic> argument={
                  "data":consultantPaymentStatusResponse.product?.metaData?.first,
                  "price":consultantPaymentStatusResponse.product?.price,
                };

                RouteNavigator.popIfCanPop(context);
                RouteNavigator.pushNamed(context,AppScreens.expertPayment,arguments: argument);
                return;
              }
            }
          }
        } else {

        }
      } catch (e) {
        print("ConsultantPaymentStatusResponse error");
        print(e);
      }
    }
    if (!isToken && !isScore && !isProfile) {
      startAnimation();
    } else if (isToken && !isProfile && !isScore) {
      //RouteNavigator.popIfCanPop(context);
      RouteNavigator.pushReplacement(context, AppScreens.personalDetails);
      RouteNavigator.popIfCanPop(context);
    } else if (isToken && isProfile && !isScore) {
      RouteNavigator.popIfCanPop(context);
      Map<String, dynamic> data = {
        "name": profileData?.name??"",
      };
      RouteNavigator.pushReplacement(context, AppScreens.wellBeingIntroScreen,arguments: data);
    } else if (isToken && isProfile && isScore) {
      RouteNavigator.popIfCanPop(context);
      RouteNavigator.pushReplacement(context, AppScreens.mainScreen);
      // RouteNavigator.pushReplacement(context,AppScreens.choosePlan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        color: AppColors.screenBackground,
        child: (isCrital || isSoft) ? appUpdateView() :Stack(
          children: [
            const Positioned(
                top: 0,
                left: 0,
                child: Image(
                    image: AssetImage(ImageAssetPath.icSplashBackground))),
            Positioned(
                bottom: 300,
                left: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(ImageAssetPath.icSpash),
                      width: 300,
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Curate",
                      textAlign: TextAlign.center,
                      style:
                          $styles.text.h5.copyWith(color: AppColors.blackColor),
                    ),
                  ],
                )),
            AnimatedPositioned(
              bottom: animate ? 8 : -70,
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                child: AppButton(
                  background: AppColors.primary,
                  text: "Get Started",
                  onClicked: () {
                    RouteNavigator.pushReplacement(
                        context, AppScreens.onBoarding);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appUpdateView() {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
              top: 0,
              left: 0,
              child: Image(
                  image: AssetImage(ImageAssetPath.icSplashBackground))),
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(child: Image.asset(ImageAssetPath.icOnboarding2)),
                    SizedBox(height: 50.sps),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25.sps),
                        child: Text(
                          "App Update Required!",
                          textAlign: TextAlign.center,
                          style:
                              $styles.text.h6.copyWith(color: AppColors.blackColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.sps),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25.sps),
                        child: Text(
                          "We have add new features and fix some bugs to make your experience seamless",
                          textAlign: TextAlign.center,
                          style: $styles.text.body2
                              .copyWith(color: AppColors.darkGreyColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 60.sps)
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 16.sps,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sps),
                    child: AppButton(
                      background: AppColors.primary,
                      text: "Update App",
                      onClicked: () async {
                        final appId = packageName ?? "";
                        final url = Uri.parse(
                          Platform.isAndroid
                              ? "market://details?id=$appId"
                              : "https://apps.apple.com/app/id$appId",
                        );
                        if (!await launchUrl(url)) {
                        AppUtils.showToast(
                        'Could not launch $url');
                        throw Exception(
                        'Could not launch $url');
                        }
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8.sps,
                  ),
                  isCrital
                      ? Container()
                      : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sps),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "May be later",
                          style:
                          $styles.text.h9.copyWith(color: AppColors.blackColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.sps)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() => animate = true);
    await Future.delayed(Duration(milliseconds: 5000));
  }*/

