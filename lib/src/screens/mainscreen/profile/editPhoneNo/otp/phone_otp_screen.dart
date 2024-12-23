import 'dart:async';
import 'dart:io';

import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/OTPTextField.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';
import 'cubit/phone_otp_cubit.dart';
import 'cubit/phone_otp_state.dart';

class PhoneOTPScreen extends StatefulWidget {
  final Map<String, dynamic> tokenData;
  PhoneOTPScreen({super.key, required this.tokenData});

  static Widget create(Map<String, dynamic> tokenData) {
    return BlocProvider(
        create: (BuildContext context) => PhoneOTPCubit(data: tokenData),
        child: PhoneOTPScreen(
          tokenData: tokenData,
        ));
  }

  var totalTime = 60;
  Timer? timer;
  var resendButton = false;
  //Map<String,dynamic>?  tokenData ;

  @override
  State<PhoneOTPScreen> createState() => _PhoneOTPScreenState();
}

class _PhoneOTPScreenState extends State<PhoneOTPScreen>
    with WidgetsBindingObserver {
  //var model = OTPScreenVM();
  var otpString = "";
  var showError = false;
  PhoneOTPCubit? cubit;
  DateTime? bgDate;
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (Platform.isIOS && bgDate != null) {
          Duration dd = DateTime.now().difference(bgDate!);
          var timeSpent = 60 - widget.totalTime;
          widget.totalTime = 60 - (timeSpent + dd.inSeconds);
          bgDate = null;
        }
        // Handle this case
        break;
      case AppLifecycleState.inactive:
        // Handle this case
        break;
      case AppLifecycleState.paused:
        // Handle this case
        print("hugyftyghjnlkm");
        print(widget.totalTime);
        bgDate = DateTime.now();
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: CustomAppbar(),
      ),
      body: BlocConsumer<PhoneOTPCubit, OTPPhoneState>(
          listener: (context, state) {
        if (state is OTPPhoneLoading) {
          context.loaderOverlay.show();
        } else if (state is OTPPhoneInitial) {
          context.loaderOverlay.hide();
        } else if (state is OTPPhoneSuccess) {
          context.loaderOverlay.hide();
          widget.timer?.cancel();
          goToNextPage();
        } else if (state is OTPPhoneNoInternet) {
          context.loaderOverlay.hide();
          AppUtils.showToast(AppConstants.noInternetTitle);
        } else if (state is OTPPhoneError) {
          context.loaderOverlay.hide();
          AppUtils.showToast(state.errorMessage);
        }
      }, builder: (context, state) {
        cubit = BlocProvider.of<PhoneOTPCubit>(context);
        return mainContent();
      }),
    );
  }

  Widget mainContent() {
    const focusedBorderColor = AppColors.lightGrey;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 50.sps,
      height: 60.sps,
      textStyle: $styles.text.h6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sps),
        border: Border.all(color: focusedBorderColor),
      ),
    );

    return SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height - (kToolbarHeight + 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.sps),
                  Center(
                    child: Text(
                      "OTP Verification",
                      style:
                          $styles.text.h6.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  SizedBox(height: 16.sps),
                  Center(
                    child: Text(
                      "We’ve sent an OTP to ${widget.tokenData["phoneNo"]},\n please enter it below to proceed",
                      style: $styles.text.body1
                          .copyWith(color: AppColors.blackColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24.sps),
                  Center(
                    child: Pinput(
                      obscureText: true,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      length: 6,
                      onCompleted: (pin) {
                        otpString = pin;
                        print("Completed: $pin");
                      },
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(10.sps),
                          border: Border.all(color: focusedBorderColor),
                          color: AppColors.white,
                        ),
                      ),
                      defaultPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(10.sps),
                          color: AppColors.white,
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.sps),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.sps),
                          border: Border.all(color: AppColors.error),
                        ),
                      ),
                    ),
                  ),
                  /* OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 44,
                    outlineBorderRadius: 8,
                    style: $styles.text.h6,
                    hasError: showError,
                    obscureText: true,
                    spaceBetween: 10,
                    contentPadding: EdgeInsets.symmetric(vertical: 16.sps),
                    textFieldAlignment: MainAxisAlignment.center,
                    isDense: false,
                    otpFieldStyle: OtpFieldStyle(
                        backgroundColor:AppColors.white
                    ),
                    fieldStyle: FieldStyle.box,
                    onCompleted: (pin) {
                      showError=false;
                      otpString = pin;
                      print("Completed: " + pin);
                    },
                  ),*/

                  Visibility(
                      maintainAnimation: true,
                      maintainState: true,
                      visible: showError,
                      child: Column(
                        children: [
                          SizedBox(height: 16.sps),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              "The OTP you entered is wrong, please try again with correct OTP",
                              style: $styles.text.body2
                                  .copyWith(color: AppColors.errorColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32.0, horizontal: 12.0),
                      child: InkWell(
                        onTap: () {
                          if (widget.totalTime == 0) {
                            resendClicked();
                          }
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Resend code",
                                style: (widget.totalTime == 0)
                                    ? ($styles.text.h8
                                        .copyWith(color: AppColors.blackColor))
                                    : ($styles.text.body1.copyWith(
                                        color: AppColors.darkGreyColor))),
                            TextSpan(
                                text: (widget.totalTime == 0)
                                    ? ""
                                    : "${" in"} ${"00:"}${widget.totalTime < 10 ? '0' : ''}${widget.totalTime}",
                                style: $styles.text.body1
                                    .copyWith(color: AppColors.darkGreyColor)),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppButton(
              background: AppColors.primary,
              text: "Submit",
              onClicked: () {
                buttonClicked();
              },
            ),
          ),
        ],
      ),
    );
  }

  void buttonClicked() {
    if (otpString.isNotEmpty) {
      cubit?.verifyOTP(otpString, widget.tokenData["authToken"]);
    } else {
      setState(() {
        showError = true;
      });
    }
  }

  void resendClicked() {
    resendOTP(widget.tokenData["authToken"]);
  }

  void goToNextPage() {
    Future.delayed(const Duration(milliseconds: 500), () {
      FocusManager.instance.primaryFocus?.unfocus();
      RouteNavigator.pushNamedAndRemoveUntil(
          context, AppScreens.editProfile, AppScreens.mainScreen);
    });
  }

  Future<void> resendOTP(String token) async {
    context.loaderOverlay.show();

    UIResponse? response = await cubit?.resendOTP(token);
    if (response?.status == Status.COMPLETED) {
      context.loaderOverlay.hide();
      print("response.message");
      print(response?.data);
      AppUtils.showSnackBar(context, response?.data);
      widget.timer?.cancel();
      widget.totalTime = 60;
      startTimer();
    } else if (response?.status == Status.ERROR) {
      context.loaderOverlay.hide();
      print("response.message");
      print(response?.message);
      AppUtils.showSnackBar(context, response?.message);
    }
  }

  void startTimer() {
    widget.resendButton = true;
    const onsec = Duration(seconds: 1);
    widget.timer = Timer.periodic(onsec, (timer) {
      if (widget.totalTime == 0) {
        widget.resendButton = false;
        setState(() {});
        widget.timer?.cancel();
      } else {
        setState(() {
          widget.totalTime--;
        });
      }
    });
  }
}
