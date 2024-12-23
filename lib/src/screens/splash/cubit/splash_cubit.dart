import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/data/models/AppVersionResponse.dart';
import 'package:curate/src/data/models/ConsultantPaymentStatusResponse.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../constants/network_check.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {

  final _userRepository = GetIt.I<UserRepository>();
  ConsultantPaymentStatusResponse? consultantPaymentStatusResponse;
  final _preferences = GetIt.I<PreferencesManager>();
  AppVersionResponse? appVersion;
  num? currPlanStatus;
  bool criticalUpdate=false;
  bool softUpdate=false;
  String? packageName;
  String? tokenData;
  String? scoreData;

  bool isToken = false;
  bool isScore = false;
  bool isProfile = false;
  PersonalInfo? profileData;
  RemoteMessage? message;

  SplashCubit(this.message) : super(SplashInitial())  {
    getAllApiData();
  }

  Future<String?> _getFcmToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  Future<void> getAllApiData() async {
    try{
    /*  String token = await _getFcmToken() ?? "";
      print("token");
      print(token);*/
      tokenData = await _preferences.getUserToken();
      scoreData = await _preferences.getWellBeingScore();
      profileData = await _preferences.getUserProfile();


      isToken = (tokenData ?? "").isNotEmpty;
      isScore = ((scoreData ?? "").isNotEmpty) && ((scoreData ?? "0") != "0");
      isProfile = profileData != null;
    }catch(e){
      AppUtils.showToast("1 - $e");
    }

    String? soft,critical,version;


    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {

        var response = await Future.wait([_userRepository.getAppVersion(),_userRepository.consultantProductStatus()]);

        if (response[0].status == Status.COMPLETED) {
          AppVersionResponse? appVersion = response[0].data as AppVersionResponse;
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          packageName = packageInfo.packageName;

          if(Platform.isAndroid){
            soft = appVersion.androidSoft ?? "";
            critical = appVersion.androidCritical ?? "";
          }else{
            soft = appVersion.iosSoft ?? "";
            critical = appVersion.iosCritical ?? "";
          }
          version = packageInfo.version;
        }else {
          //emit(SplashError(response[1].message));
        }

        if((tokenData ?? "").isNotEmpty) {
          if (response[1].status == Status.COMPLETED) {
            consultantPaymentStatusResponse =
            response[1].data as ConsultantPaymentStatusResponse;
            if (consultantPaymentStatusResponse != null) {

              if(consultantPaymentStatusResponse?.talkToExpertStatus!=null) {
                currPlanStatus =
                    consultantPaymentStatusResponse?.talkToExpertStatus
                        ?.currPlanStatus;
              }

            }
            //emit(SplashSuccess());
          } else {
            //emit(SplashError(response[0].message));
          }
        }

        emit(SplashSuccess());
        if(checkAppVersion(critical??"0", version??"0")){
          print("hugyfc");
          criticalUpdate = true;
          emit(SplashAppUpdateStatus());
          return;
        }
        if(checkAppVersion(soft??"0", version??"0")){
          print("jiouhygvh");
          softUpdate = true;
          emit(SplashAppUpdateStatus());
          return;
        }
        else{
          emit(SplashSuccess());
        }

      } catch (e) {
         emit(SplashError(e.toString()
        ));
      }
    } else {
      emit(SplashNoInternet());
    }

  }

  updatdState(){
    emit(SplashInitial());
  }

  bool checkAppVersion(String onServerVersion, String deviceVersions){
    final List<String> serverVersion = onServerVersion.split('.');
    final List<String> deviceVersion = deviceVersions.split('.');
    bool isHigher = false;

    // Here im equaliting the length of the versions
    if (serverVersion.length > deviceVersion.length) {
      final size = serverVersion.length - deviceVersion.length;
      for (var i = 0; i < size; i++) {
        deviceVersion.add('0');
      }
    } else {
      final size = deviceVersion.length - serverVersion.length;
      for (var i = 0; i < size; i++) {
        serverVersion.add('0');
      }
    }

    // Here im comparing the versions
    for (var i = 0; i < (serverVersion.length); i++) {
      isHigher =
          int.parse(serverVersion[i]) > int.parse(deviceVersion[i]);
      if (int.parse(serverVersion[i]) != int.parse(deviceVersion[i])){
        break;
      }
    }
    return isHigher;
  }
}
