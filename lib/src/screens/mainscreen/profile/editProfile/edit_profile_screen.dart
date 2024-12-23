import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/screens/mainscreen/profile/cubit/profile_screen_cubit.dart';
import 'package:curate/src/screens/mainscreen/profile/editProfile/cubit/edit_profile_cubit.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../data/models/response/profile/PersonalInfo.dart';
import '../../../../data/repository/user_repo/user_repository.dart';
import '../../../../styles/styles.dart';
import '../../../../widgets/app_text_feild/app_text_from_feild.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => EditProfileCubit(),
        child: EditProfileScreen());
  }

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  CountryCode countryCode =
      CountryCode(name: "India", code: "IN", dialCode: "+91");

  late EditProfileCubit cubit;
  bool showUpgradeButton = false;
  var lastDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: CustomAppbar()),
      body: SafeArea(
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = BlocProvider.of<EditProfileCubit>(context);
          return getMainContent();
        },
      )),
    );
  }

  Widget getMainContent() {
    PersonalInfo? profileData = cubit.profileData;
    if (profileData != null) {
      if (profileData.user!.countryName != null) {
        countryCode = CountryCode(
            name: profileData.user!.countryName ?? "India",
            code: profileData.user!.code ?? "IN",
            dialCode: profileData.user!.countryCode ?? "+91");
      }
      if (profileData.purchaseCount != null) {
        var date;
        var duration;
        if ((profileData.purchaseCount ?? 0) >= 1) {
          date = profileData.productStart;
          duration = profileData.productDuration;
        } else {
          date = profileData.trialStart;
          duration = profileData.trialDuration;
        }
        DateTime? parseDateTime = DateTimeUtils.getApiDatetoUtc(date);

        if (parseDateTime != null) {
          lastDate = parseDateTime.add(Duration(days: ((duration ?? 0))));
          var ddd = parseDateTime.add(Duration(days: ((duration ?? 0) - 7)));
          if (ddd.isBefore(DateTime.now()) ||
              ((cubit.profileData?.purchaseCount ?? 0) == 0)) {
            showUpgradeButton = true;
            print(showUpgradeButton);
          }
        }
      }
    }

    //((profileData?.purchaseCount??0)!=0)

    return Container(
      color: AppColors.screenBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text("Profile details",
                  style:
                      $styles.text.h6.copyWith(color: AppColors.blackColor))),
          Padding(
            padding: EdgeInsets.only(left: 16.sps, right: 16.sps, top: 24.sps),
            child: Text(
              "Name",
              style: $styles.text.body2.copyWith(color: AppColors.blackColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sps, right: 16.sps),
            child: AppTextFormField(
              hintText: cubit.profileData?.name ?? "",
              labelText: "",
              defaultText: cubit.profileData?.name ?? "",
              isRequired: false,
              disableEditing: true,
              textCapitalization: TextCapitalization.words,
              maxLength: 20,
            ),
          ),
          SizedBox(height: 24.sps),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sps),
            child: Text(
              "Date of birth",
              style: $styles.text.body2.copyWith(color: AppColors.blackColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sps),
            child: AppTextFormField(
                hintText:
                    DateTimeUtils.getDOBDateFormat(cubit.profileData?.dob) ??
                        "",
                labelText: "",
                defaultText: "Harsh Kumar",
                isRequired: false,
                disableEditing: true,
                preIconPath: ImageAssetPath.icCalendar,
                textCapitalization: TextCapitalization.words,
                maxLength: 20),
          ),
          SizedBox(height: 24.sps),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sps),
                  child: Text(
                    "Your phone number",
                    style: $styles.text.body2
                        .copyWith(color: AppColors.blackColor),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  RouteNavigator.pushNamed(context, AppScreens.updatePhone);
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sps),
                    child: Text(
                      "Edit",
                      style: $styles.text.body2
                          .copyWith(color: AppColors.darkGreenColor),
                    )),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sps),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.sps, horizontal: 8.sps),
                  margin: EdgeInsets.only(top: 6.sps),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(
                          color: AppColors.lightestGreyColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(10.sps))),
                  child: Row(
                    children: [
                      countryCode.flagImage(),
                      SizedBox(
                        width: 8.sps,
                      ),
                      Text(countryCode.dialCode),
                      SizedBox(
                        width: 4.sps,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.sps,
                ),
                Expanded(
                  child: AppTextFormField(
                    hintText: cubit.profileData?.user?.mobile ?? "",
                    isLabelVisible: false,
                    keyboardType: TextInputType.phone,
                    maxLength: 12,
                    maxLines: 1,
                    disableEditing: true,
                    isRequired: false,
                    labelText: '',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.sps),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sps),
            child: Text(
              "Current plan",
              style: $styles.text.body2.copyWith(color: AppColors.blackColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (showUpgradeButton) {
                Navigator.pushNamed(context, AppScreens.choosePlan);
              }
            },
            child: Card(
              color: AppColors.lightGreenColor,
              surfaceTintColor: AppColors.lightGreenColor,
              margin: EdgeInsets.symmetric(horizontal: 16.sps, vertical: 8.sps),
              child: Padding(
                padding: EdgeInsets.all(16.sps),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: ((cubit.profileData?.purchaseCount ?? 0) ==
                                    0)
                                ? Text("Free plan",
                                    style: $styles.text.title3
                                        .copyWith(color: AppColors.blackColor))
                                : Text(
                                    "${((cubit.profileData?.product?.duration ?? 1) / 30).floor()} months plan",
                                    style: $styles.text.title3.copyWith(
                                        color: AppColors.blackColor))),
                        showUpgradeButton
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.sps, vertical: 4.sps),
                                decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.sps))),
                                child: Text(
                                  "Restore",
                                  style: $styles.text.title3.copyWith(
                                      color: AppColors.darkGreenColor),
                                ))
                            : Container()
                      ],
                    ),
                    RichText(
                        text: TextSpan(
                            text: "Rs. ",
                            style: $styles.text.h7
                                .copyWith(color: AppColors.blackColor),
                            children: [
                          TextSpan(
                            text: (cubit.profileData?.product?.price ?? 0)
                                .toString(),
                            style: $styles.text.h5
                                .copyWith(color: AppColors.blackColor),
                          )
                        ])),
                    SizedBox(height: 4.sps),
                    Text(
                        "Expire on ${DateTimeUtils.getExpiryPackageFormat(lastDate)}.",
                        style: $styles.text.body2
                            .copyWith(color: AppColors.darkGreyColor))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppButton(
              background: AppColors.tickRed,
              text: "Delete Account",
              onClicked: () {
                showDeleteDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showDeleteDialog(BuildContext mainContext) {
    return showDialog(
        context: context,
        //barrierDismissible:false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Delete Your Account",
              style: $styles.text.h10.copyWith(color: AppColors.blackColor),
            ),
            content: Text(
                "Your account will permanently delete after 7 days. When you delete your account, you won't be able to retrieve the content information",
                style:
                    $styles.text.title2.copyWith(color: AppColors.blackColor)),
            actions: [
              TextButton(
                  onPressed: () {
                    RouteNavigator.goBack();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(24.sps, 24.sps),
                    maximumSize: Size(24.sps, 24.sps),
                  ),
                  child: Text("No",
                      style: $styles.text.title2
                          .copyWith(color: AppColors.primary))),
              TextButton(
                  onPressed: () async {
                    final userRepository = GetIt.I<UserRepository>();
                    final preferences = GetIt.I<PreferencesManager>();
                    RouteNavigator.goBack();
                    mainContext.loaderOverlay.show();
                    var result = await userRepository.deleteAccount();
                    mainContext.loaderOverlay.hide();
                    preferences.logout();

                    RouteNavigator.popAllAndToReStart(context);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(24.sps, 24.sps),
                    maximumSize: Size(24.sps, 24.sps),
                  ),
                  child: Text("Yes",
                      style: $styles.text.title2
                          .copyWith(color: AppColors.primary))),
            ],
            insetPadding: EdgeInsets.symmetric(horizontal: 16.sps),
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          );
        });
  }

  String getExpiryDate(String date) {
    if (date.isEmpty) {
      return "";
    } else {
      DateTime? dateData = DateTimeUtils.getApiDate111(date);
      dateData?.add(
          Duration(days: (cubit.profileData?.product?.duration ?? 0).toInt()));
      return DateTimeUtils.getExpiryPackageFormat(dateData);
    }
  }
}
