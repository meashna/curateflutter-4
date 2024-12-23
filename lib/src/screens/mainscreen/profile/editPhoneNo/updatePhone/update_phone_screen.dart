import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/screens/login/signin/cubit/signin_cubit.dart';
import 'package:curate/src/screens/mainscreen/profile/editPhoneNo/updatePhone/cubit/update_phone_cubit.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:curate/src/widgets/app_text_feild/app_text_from_feild.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UpdatePhoneScreen extends StatefulWidget {
  const UpdatePhoneScreen({super.key});

  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => UpdatePhoneCubit(),
        child: const UpdatePhoneScreen());
  }

  @override
  State<UpdatePhoneScreen> createState() => _UpdatePhoneScreenState();
}

class _UpdatePhoneScreenState extends State<UpdatePhoneScreen> {
  final _key1 = GlobalKey<FormState>();
  var isLoading = false;
  late UpdatePhoneCubit cubit;
  //var model = SignupVM();
  final countryPicker = const FlCountryCodePicker();
  late TextEditingController phoneNoController = TextEditingController();

  CountryCode countryCode =
      CountryCode(name: "India", code: "IN", dialCode: "+91");

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: CustomAppbar(),
      ),
      body: Container(
          color: AppColors.screenBackground,
          child: BlocConsumer<UpdatePhoneCubit, UpdatePhoneState>(
            listener: (context, state) {
              if (state is UpdatePhoneLoading) {
                context.loaderOverlay.show();
              } else if (state is UpdatePhoneInitial) {
                context.loaderOverlay.hide();
              } else if (state is UpdatePhoneSuccess) {
                context.loaderOverlay.hide();
                goToNextPage();
              } else if (state is UpdatePhoneNoInternet) {
                context.loaderOverlay.hide();
                AppUtils.showToast(AppConstants.noInternetTitle);
              } else if (state is UpdatePhoneError) {
                context.loaderOverlay.hide();
                AppUtils.showToast(state.errorMessage);
              }
            },
            builder: (context, state) {
              cubit = BlocProvider.of<UpdatePhoneCubit>(context);
              return mainContent();
            },
          )),
    );
  }

  Widget mainContent() {
    return Form(
      key: _key1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.sps),
          Center(
            child: Text(
              "Update phone number",
              style: $styles.text.h6.copyWith(color: AppColors.blackColor),
            ),
          ),
          SizedBox(height: 32.sps),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sps),
            child: Text(
              "Your phone number",
              style: $styles.text.body2.copyWith(color: AppColors.blackColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sps),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    final code =
                        await countryPicker.showPicker(context: context);
                    setState(() {
                      countryCode = code!;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 14.sps, horizontal: 8.sps),
                    margin: EdgeInsets.only(top: 6.sps),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                            color: AppColors.lightestGreyColor, width: 1.5),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.sps))),
                    child: Row(
                      children: [
                        countryCode.flagImage(),
                        SizedBox(
                          width: 8.sps,
                        ),
                        Text(countryCode.dialCode),
                        SizedBox(
                          width: 8.sps,
                        ),
                        Image.asset(ImageAssetPath.icDownArrow,
                            width: 16.sps, height: 16.sps)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.sps,
                ),
                Expanded(
                  child: AppTextFormField(
                    hintText: "Your phone",
                    isLabelVisible: false,
                    keyboardType: TextInputType.phone,
                    textEditingController: phoneNoController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    maxLength: 12,
                    maxLines: 1,
                    validator: (value) => _validatePhoneNo(value!),
                    isRequired: false,
                    labelText: '',
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(16.sps),
            child: AppButton(
              background: AppColors.primary,
              text: "Send OTP",
              onClicked: () {
                FocusManager.instance.primaryFocus?.unfocus();
                buttonClicked();
                /* Navigator.pushNamed(
                    context, AppScreens.otpVerification);*/
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom)
        ],
      ),
    );
  }

  _validatePhoneNo(String value) {
    if (value.isEmpty) {
      return "Phone number is required" /*context?.resources.strings.cantBeEmpty*/;
    } else if (value.length < 9) {
      return "Invalid phone number";
    } else {
      return null;
    }
  }

  void goToNextPage() {
    Map<String, dynamic> data = {
      "phoneNo": cubit.countryCode + cubit.phoneNo,
      "authToken": cubit.signUpResponse?.token,
    };

    Navigator.pushNamed(context, AppScreens.phoneOtp, arguments: data);
  }

  void buttonClicked() {
    if (_key1.currentState!.validate()) {
      final phoneNo = phoneNoController.text;
      cubit.phoneNo = phoneNo;
      cubit.countryCode = countryCode.dialCode;
      cubit.code = countryCode.code;
      cubit.countryName = countryCode.name;
      cubit.signInApi();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNoController.dispose();
  }
}
