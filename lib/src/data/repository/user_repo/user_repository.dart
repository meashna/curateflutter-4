import 'dart:io';

import 'package:curate/src/data/models/ConsultantsProductResponse.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/AssessmentStatusDto.dart';
import 'package:curate/src/data/models/response/authenticate/SignUpResponse.dart';
import 'package:curate/src/data/models/response/authenticate/VerifyOtpResponse.dart';
import 'package:curate/src/data/models/response/chat/HealthCoachResponse.dart';
import 'package:curate/src/data/models/response/dayPlan/DayPlanDto.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogResponse.dart';
import 'package:curate/src/data/models/response/healthLog/PeriodFlowResponse.dart';
import 'package:curate/src/data/models/response/home2/Data.dart';
import 'package:curate/src/data/models/response/home2/HomeApiResponse.dart';
import 'package:curate/src/data/models/response/mood/MoodDetailResponse.dart';
import 'package:curate/src/data/models/response/myplan/PlanResponse.dart';
import 'package:curate/src/data/models/response/profile/MyProfileDto.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:curate/src/data/models/response/profile/UpdateMobileResponse.dart';
import 'package:curate/src/data/models/response/questions/WellbeingQuestionDto.dart';

import '../../models/AppVersionResponse.dart';
import '../../models/ApplePayTransactionObject.dart' as applePay;
import '../../models/ChoosePackageResponse.dart' as choosePackage;
import '../../models/ConsultantPaymentStatusResponse.dart';
import '../../models/NotificationListModel.dart' as notificationList;
import '../../models/apis/api_response.dart';
import '../../models/response/authenticate/ProfileDto.dart';
import '../../models/response/home2/TodoListResponses.dart';
import '../../models/response/questions/WellbeingScoreDto.dart';

/*import 'package:kuby/src/data/models/ReviewListResponse.dart';
import 'package:kuby/src/data/models/SignUpResponse.dart';
import '../../models/apis/api_response.dart';
import '../../models/productModels/ProductListResponse.dart';*/

abstract class UserRepository {
  Future<UIResponse<WellbeingScoreDto>> submitQuestions(
      List<Map<String, dynamic>> answers, int questionType);
  Future<UIResponse<SignUpResponse>> signUp(
      String countryCode, String countryName, String code, String mobileNo);
  Future<UIResponse<SignUpResponse>> updateMobile(
      String countryCode, String countryName, String code, String mobileNo);
  Future<UIResponse<VerifyOtpResponse>> verifyOTP(String otp, String token);
  Future<UIResponse<UpdateMobileResponse>> verifyUpdatePhone(
      String otp, String token);
  Future<UIResponse<dynamic>> resendOtp(String token);
  Future<UIResponse<PersonalInfo>> saveProfileData(
      String name, String dob, String height, String weight);
  Future<UIResponse<WellbeingQuestionDto>> getWellbeingScore(int questionType);
  Future<UIResponse<HomeApiResponse>> getHomeData();
  Future<UIResponse<DayPlanDto>> getDayData(String orderId);
  Future<UIResponse<PlanResponse>> getPlanData(int? selectedWeek);
  Future<UIResponse<AssessmentStatusDto>> getAssessmentStatus();
  Future<UIResponse<TodoListResponses>> saveActivityData(
      Map<String, dynamic>? map);
  Future<UIResponse<Data>> getGratitideData(Map<String, dynamic>? map);
  Future<UIResponse<MoodDetailResponse>> getMoodDetails(int weekCount);
  Future<UIResponse<choosePackage.ChoosePackageResponse>> getProducts();
  Future<UIResponse<applePay.ApplePayTransactionObject>> getAppleTransaction(
      Map<String, dynamic> queryData);
  Future<UIResponse<notificationList.NotificationListModel>> getNotification(
      {Map<String, dynamic>? queryData});
  Future<UIResponse<dynamic>> getProductsOrderId(num id);
  Future<UIResponse<dynamic>> createUpiPaymentRequest(num id, String upiId);
  Future<UIResponse<AppVersionResponse>> getAppVersion();
  Future<UIResponse<ConsultantPaymentStatusResponse>> consultantProductStatus();
  Future<UIResponse<HealthLogData>> addPatientLog(
      Map<String, dynamic> requestData);
  Future<UIResponse<HealthLogData>> updatePatientLog(
      Map<String, dynamic> requestData, num id);
  Future<UIResponse<HealthLogResponse>> getPatientLog(
      Map<String, dynamic>? map);
  Future<UIResponse<PeriodFlowResponse>> getPeriodFlows();
  Future<UIResponse<MyProfileDto>> getProfileData();
  Future<UIResponse<dynamic>> logout();
  Future<UIResponse<dynamic>> deleteAccount();
  Future<UIResponse<HealthCoachResponse?>> getHealthCoachData();
  Future<UIResponse<ConsultantsProductResponse?>> getConsultantProduct();

/* Future<ApiResponse<LoginResponse>> signIn(String email, String password);
  Future<ApiResponse<SignUpResponse>> forgotPassword(String email);*/
/* Future<ApiResponse<dynamic>> changePassword(String oldPassword,String newPassword,);
  Future<ApiResponse<GetProfileResponse>> getUserProfile();
  Future postComment({required Map<String, dynamic> queryData});
  Future<ApiResponse<CommentListResponse>> getComments({required Map<String, dynamic> queryData});

  */
}
