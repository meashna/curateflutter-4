import 'dart:convert';

import 'dart:io';

import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/AssessmentStatusDto.dart';
import 'package:curate/src/data/models/response/authenticate/ProfileDto.dart';
import 'package:curate/src/data/models/response/authenticate/SignUpResponse.dart';
import 'package:curate/src/data/models/response/authenticate/VerifyOtpResponse.dart';
import 'package:curate/src/data/models/response/chat/HealthCoachResponse.dart';
import 'package:curate/src/data/models/response/dayPlan/DayPlanDto.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogResponse.dart';
import 'package:curate/src/data/models/response/healthLog/PeriodFlowResponse.dart';
import 'package:curate/src/data/models/response/home2/Data.dart';
import 'package:curate/src/data/models/response/home2/HomeApiResponse.dart';
import 'package:curate/src/data/models/response/home2/TodoListResponses.dart';
import 'package:curate/src/data/models/response/mood/MoodDetailResponse.dart';
import 'package:curate/src/data/models/response/myplan/PlanResponse.dart';
import 'package:curate/src/data/models/response/profile/MyProfileDto.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:curate/src/data/models/response/profile/UpdateMobileResponse.dart';
import 'package:curate/src/data/models/response/questions/WellbeingQuestionDto.dart';
import 'package:curate/src/data/network/ApiEndPoints.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:device_imei/device_imei.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import 'package:mime/mime.dart';

import '../../../constants/app_constants.dart';
import '../../models/AppVersionResponse.dart';
import '../../models/ApplePayTransactionObject.dart' as applePay;
import '../../models/ChoosePackageResponse.dart' as choosePackage;
import '../../models/ConsultantPaymentStatusResponse.dart';
import '../../models/ConsultantsProductResponse.dart';
import '../../models/NotificationListModel.dart' as notificationList;
import '../../models/response/questions/WellbeingScoreDto.dart';

class UserRepositoryImpl implements UserRepository {
  final _dio = GetIt.I<Dio>();
  final _preferences = GetIt.I<PreferencesManager>();

  Future<String?> _getFcmToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  @override
  Future<UIResponse<SignUpResponse>> signUp(String countryCode,
      String countryName, String code, String mobileNo) async {
    final deviceImeiPlugin = DeviceImei();
    String? token = await _getFcmToken();
    String? imei = "";
    DeviceInfo? dInfo;

    try {
      imei = await deviceImeiPlugin.getDeviceImei();
      dInfo = await deviceImeiPlugin.getDeviceInfo();
    } catch (e) {
      imei = "";
    }

    Map<String, dynamic> map = {
      'countryCode': countryCode,
      'countryName': countryName,
      'code': code,
      'mobile': mobileNo,
    };
    if (token != null) {
      map.addAll({"registrationToken": token});
    }
    if (imei != null && imei.isNotEmpty) {
      map.addAll({"imei": imei});
    }

    if (Platform.isAndroid) {
      map.addAll({"osType": "Android"});
    } else if (Platform.isIOS) {
      map.addAll({"osType": "iOS"});
    }
    if (dInfo != null) {
      try {
        map.addAll({"deviceId": dInfo.deviceId ?? ""});
        map.addAll({"version": dInfo.sdkInt ?? ""});
        // ignore: empty_catches
      } catch (e) {}
    }
    final requestData = jsonEncode(map);

    try {
      final response =
          await _dio.post(ApiEndPoints().loginApi, data: requestData);
      if (response.statusCode == 200) {
        final signUpResponse =
            SignUpResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(signUpResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<SignUpResponse>> updateMobile(String countryCode,
      String countryName, String code, String mobileNo) async {
    final requestData = jsonEncode({
      'countryCode': countryCode,
      /*   'countryName': countryName,
      'code': code,*/
      'mobile': mobileNo,
    });

    try {
      final response =
          await _dio.post(ApiEndPoints().updateMobile, data: requestData);
      if (response.statusCode == 200) {
        final signUpResponse =
            SignUpResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(signUpResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<VerifyOtpResponse>> verifyOTP(
      String otp, String token) async {
    final requestData = jsonEncode({
      'otp': otp,
      'token': token,
    });
    try {
      final response =
          await _dio.post(ApiEndPoints().verifyOTP, data: requestData);
      if (response.statusCode == 200) {
        final verifyOTPResponse =
            VerifyOtpResponse.fromJson(response.data["responseData"]);
        _saveUserDetails(verifyOTPResponse);

        return UIResponse.completed(verifyOTPResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<UpdateMobileResponse>> verifyUpdatePhone(
      String otp, String token) async {
    final requestData = jsonEncode({
      'otp': otp,
      'token': token,
    });
    try {
      final response =
          await _dio.post(ApiEndPoints().verifyUpdateMobile, data: requestData);
      if (response.statusCode == 200) {
        final verifyOTPResponse =
            UpdateMobileResponse.fromJson(response.data["responseData"]);

        var personalData = await _preferences.getUserProfile();
        personalData?.user = verifyOTPResponse.user;
        _preferences.setUserProfile(personalData);
        return UIResponse.completed(verifyOTPResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<dynamic>> resendOtp(String token) async {
    final requestData = jsonEncode({
      'token': token,
    });
    try {
      final response =
          await _dio.post(ApiEndPoints().resendOTP, data: requestData);
      if (response.statusCode == 200) {
        //final signUpResponse = VerifyOtpResponse.fromJson();
        return UIResponse.completed(response.data["message"]);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<PersonalInfo>> saveProfileData(
      String name, String dob, String height, String weight) async {
    final requestData = jsonEncode({
      'name': name,
      'dob': dob,
      'height': height,
      'weight': weight,
    });
    try {
      final response =
          await _dio.post(ApiEndPoints().profileApi, data: requestData);

      if (response.statusCode == 200) {
        final profileResponse =
            ProfileDto.fromJson(response.data["responseData"]);
        _preferences.setUserProfile(profileResponse.profile);
        _preferences.setUserToken(profileResponse.token);
        return UIResponse.completed(profileResponse.profile);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<WellbeingScoreDto>> submitQuestions(
      List<Map<String, dynamic>> answers, int questionType) async {
    final requestData = jsonEncode({
      "answers": answers,
      'questionType': questionType,
    });
    try {
      final response =
          await _dio.post(ApiEndPoints().optionsByUser, data: requestData);
      if (response.statusCode == 200) {
        final scoreData =
            WellbeingScoreDto.fromJson(response.data["responseData"]);
        if (questionType != AppConstants.moodQuestionType) {
          _preferences.setWellBeingScore((scoreData.score ?? 0).toString());
        }

        return UIResponse.completed(scoreData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<MoodDetailResponse>> getMoodDetails(int weekCount) async {
    try {
      final response =
          await _dio.get("${ApiEndPoints().moodDetails}/$weekCount");
      if (response.statusCode == 200) {
        final moodDetailsData =
            MoodDetailResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(moodDetailsData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<applePay.ApplePayTransactionObject>> getAppleTransaction(
      Map<String, dynamic> queryData) async {
    try {
      final response = await _dio.get(
          ApiEndPoints().generateAppleTransactionDetails,
          queryParameters: queryData);
      if (response.statusCode == 200) {
        final choosePackageResponse =
            applePay.ApplePayTransactionObject.fromJson(
                response.data["responseData"]);
        return UIResponse.completed(choosePackageResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<choosePackage.ChoosePackageResponse>> getProducts() async {
    try {
      final response = await _dio.get(ApiEndPoints().products);
      if (response.statusCode == 200) {
        final choosePackageResponse =
            choosePackage.ChoosePackageResponse.fromJson(
                response.data["responseData"]);
        return UIResponse.completed(choosePackageResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<notificationList.NotificationListModel>> getNotification(
      {Map<String, dynamic>? queryData}) async {
    try {
      final response = await _dio.get(ApiEndPoints().notifications,
          queryParameters: queryData);
      if (response.statusCode == 200) {
        final choosePackageResponse =
            notificationList.NotificationListModel.fromJson(
                response.data["responseData"]);
        return UIResponse.completed(choosePackageResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<dynamic>> getProductsOrderId(num id) async {
    try {
      final response = await _dio.post("${ApiEndPoints().products}/$id/order");
      if (response.statusCode == 200) {
        // final choosePackageResponse = choosePackage.ChoosePackageResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(response.data["responseData"]);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<dynamic>> createUpiPaymentRequest(
      num id, String upiId) async {
    var postData = jsonEncode({"upiId": upiId});

    try {
      final response = await _dio.post(
          "${ApiEndPoints().products}/$id/createUpiRequest",
          data: postData);
      if (response.statusCode == 200) {
        // final choosePackageResponse = choosePackage.ChoosePackageResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(response.data["responseData"]);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<AppVersionResponse>> getAppVersion() async {
    try {
      final response = await _dio.get(ApiEndPoints().app_version);
      if (response.statusCode == 200) {
        final choosePackageResponse =
            AppVersionResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(choosePackageResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<ConsultantPaymentStatusResponse>>
      consultantProductStatus() async {
    try {
      final response = await _dio.get(ApiEndPoints().consultantProductStatus);
      if (response.statusCode == 200) {
        final choosePackageResponse = ConsultantPaymentStatusResponse.fromJson(
            response.data["responseData"]);
        return UIResponse.completed(choosePackageResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<HomeApiResponse>> getHomeData() async {
    try {
      final response = await _dio.get(ApiEndPoints().homeScreenApi);
      if (response.statusCode == 200) {
        final homeData =
            HomeApiResponse.fromJson(response.data["responseData"]);
        _preferences.setUserProfile(homeData.personalInfo);
        return UIResponse.completed(homeData);
      } else {
        print(response.toString());
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      print("error.toString()");
      print(error.toString());
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<DayPlanDto>> getDayData(String orderId) async {
    try {
      Map<String, dynamic> requestData = {"todoOrderId": orderId};
      final response = await _dio.get(ApiEndPoints().getDayTasks,
          queryParameters: requestData);
      if (response.statusCode == 200) {
        final dayData = DayPlanDto.fromJson(response.data["responseData"]);
        return UIResponse.completed(dayData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<AssessmentStatusDto>> getAssessmentStatus() async {
    try {
      final response = await _dio.get(ApiEndPoints().getWeeklyAssessmentStatus);
      if (response.statusCode == 200) {
        final assessmentStatus =
            AssessmentStatusDto.fromJson(response.data["responseData"]);
        return UIResponse.completed(assessmentStatus);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<PlanResponse>> getPlanData(int? selectedWeek) async {
    try {
      late ResponseType responseType;
      late Response<dynamic> response;
      if (selectedWeek == null) {
        response = await _dio.get(ApiEndPoints().todoLists);
      } else {
        Map<String, dynamic> requestData = {"week": selectedWeek};
        response = await _dio.get(ApiEndPoints().todoLists,
            queryParameters: requestData);
      }

      if (response.statusCode == 200) {
        final planData = PlanResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(planData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<TodoListResponses>> saveActivityData(
      Map<String, dynamic>? map) async {
    try {
      final response =
          await _dio.post(ApiEndPoints().activityResponse, data: map);
      if (response.statusCode == 200) {
        final submitionData =
            TodoListResponses.fromJson(response.data["responseData"]);
        return UIResponse.completed(submitionData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<Data>> getGratitideData(Map<String, dynamic>? map) async {
    try {
      final response =
          await _dio.get(ApiEndPoints().activityResponse, queryParameters: map);
      if (response.statusCode == 200) {
        final gratitudeData = Data.fromJson(response.data["responseData"]);
        return UIResponse.completed(gratitudeData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  void _saveUserDetails(VerifyOtpResponse response) {
    print("TOKEN: ${response.token}");
    _preferences.setUserToken(response.token);
    _preferences.setUserProfile(response.profile);
    _preferences.setUUID(response.uuid);
    _preferences
        .setWellBeingScore((response.profile?.wellBeingScore ?? 0).toString());
  }

  String handleDioError(DioException error, {bool isLogin = false}) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connect timeout error";
        break;
      case DioExceptionType.sendTimeout:
        return "Send timeout error";
        break;
      case DioExceptionType.receiveTimeout:
        return "Receive timeout error";
        break;
      case DioExceptionType.badResponse:
        if (!isLogin) {
          if (error.response?.statusCode == 401) {
            sessionExpireRunCode(error.message ?? "");
          }
        }
        return (error.response?.data["message"]).toString();
        break;
      case DioExceptionType.cancel:
        return "Request Canceled error";
        break;
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          /*print("DioErrorType.SocketException");
          Future.delayed(Duration(seconds: 3), () {
            AppUtils.showToast("Please check your network");
          });*/
          // SocketException eee = error.error;
          return error.message ?? "";
        }
        return error.error.toString();
        break;

      default:
        return "";
    }
  }

  sessionExpireRunCode(String error) {
    /* Future.delayed(Duration(seconds: 2), () {
      logout();
      AppUtils.showToast(error);
      RouteNavigator.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          RouteGenerator.login, (Route<dynamic> route) => false);
    });*/
  }

  @override
  Future<UIResponse<WellbeingQuestionDto>> getWellbeingScore(
      int questionType) async {
    try {
      final response =
          await _dio.get("${ApiEndPoints().wellBeingQuestions}/$questionType");
      if (response.statusCode == 200) {
        final wellbeingResponse =
            WellbeingQuestionDto.fromJson(response.data["responseData"]);
        return UIResponse.completed(wellbeingResponse);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<HealthLogData>> addPatientLog(
      Map<String, dynamic> requestData) async {
    try {
      final response =
          await _dio.post(ApiEndPoints().addPatientLog, data: requestData);

      if (response.statusCode == 200) {
        final healthData =
            HealthLogData.fromJson(response.data["responseData"]);
        return UIResponse.completed(healthData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<HealthLogData>> updatePatientLog(
      Map<String, dynamic> requestData, num id) async {
    try {
      final response = await _dio.patch("${ApiEndPoints().addPatientLog}/$id",
          data: requestData);

      if (response.statusCode == 200) {
        final healthData =
            HealthLogData.fromJson(response.data["responseData"]);
        return UIResponse.completed(healthData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<HealthLogResponse>> getPatientLog(
      Map<String, dynamic>? map) async {
    try {
      final response =
          await _dio.get(ApiEndPoints().addPatientLog, queryParameters: map);

      if (response.statusCode == 200) {
        final healthData =
            HealthLogResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(healthData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<PeriodFlowResponse>> getPeriodFlows() async {
    try {
      final response = await _dio.get(ApiEndPoints().getPeriodFlowLog);
      if (response.statusCode == 200) {
        final periodFlowData =
            PeriodFlowResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(periodFlowData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<MyProfileDto>> getProfileData() async {
    try {
      final response = await _dio.get(ApiEndPoints().getProfile);
      if (response.statusCode == 200) {
        final profileData =
            MyProfileDto.fromJson(response.data["responseData"]);
        _preferences.setUserProfile(profileData.personalInfo);
        _preferences.setWellBeingScore(
            (profileData.personalInfo?.wellBeingScore ?? 0).toString());
        return UIResponse.completed(profileData);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }
  /*949946464646*/

  @override
  Future<UIResponse<dynamic>> logout() async {
    try {
      final response = await _dio.get(
        ApiEndPoints().logout,
      );
      print("logout Response");
      print(response);
      if (response.data["success"]) {
        //final notificationResponse = MyNotificationResponse.fromJson(response.data["responseData"]);
        return UIResponse.completed(response.data["responseData"]);
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<dynamic>> deleteAccount() async {
    try {
      final response = await _dio.delete(
        ApiEndPoints().delete,
      );
      print("deleteAccount Response");
      print(response);
      return UIResponse.error(response.data["message"]);
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<HealthCoachResponse?>> getHealthCoachData() async {
    try {
      final response = await _dio.get(ApiEndPoints().getChat);
      if (response.statusCode == 200) {
        if (response.data["responseData"] != null) {
          final healthCoachData =
              HealthCoachResponse.fromJson(response.data["responseData"]);
          return UIResponse.completed(healthCoachData);
        } else {
          return UIResponse.completed(null);
        }
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }

  @override
  Future<UIResponse<ConsultantsProductResponse?>> getConsultantProduct() async {
    try {
      final response = await _dio.get(ApiEndPoints().getConsultantProduct);
      if (response.statusCode == 200) {
        if (response.data["responseData"] != null) {
          final healthCoachData = ConsultantsProductResponse.fromJson(
              response.data["responseData"]);
          return UIResponse.completed(healthCoachData);
        } else {
          return UIResponse.completed(null);
        }
      } else {
        return UIResponse.error(response.data["message"]);
      }
    } on DioException catch (error) {
      return UIResponse.error(handleDioError(error));
    }
  }
}
