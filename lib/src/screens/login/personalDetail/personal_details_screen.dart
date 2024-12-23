import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/screens/login/personalDetail/cubit/personal_detail_cubit.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:curate/src/widgets/app_text_feild/app_text_from_feild.dart';
import 'package:curate/src/widgets/app_text_feild/text_feild_input_formatter.dart';
import 'package:curate/src/widgets/helpers/slider_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import '../../../constants/app_constants.dart';

class PersonalDetails1 extends StatefulWidget {
  const PersonalDetails1({super.key});

  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => PersonalDetailCubit(),
        child: const PersonalDetails1());
  }

  @override
  State<PersonalDetails1> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails1> {
  final _key1 = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();
  String dateFormatted = "";
  late TextEditingController nameController = TextEditingController();
  double intValue = 0;
  double heightValue = 100;
  double weightValue = 20;
  int calculatedYear = 0;
  ui.Image? customImage;
  bool isFirstStep = true;
  bool isHeigtSelected = false;
  bool isWeightSelected = false;
  late PersonalDetailCubit cubit;

  /* Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: 85,
        targetWidth: 60);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }*/

  @override
  void initState() {
    super.initState();
    dateInput.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (isFirstStep)
          ? AppBar(
              backgroundColor: AppColors.screenBackground,
              elevation: 0,
              automaticallyImplyLeading: false)
          : AppBar(
              backgroundColor: AppColors.screenBackground,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  if (isFirstStep) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      isFirstStep = true;
                    });
                  }
                },
                child: Container(
                  width: 50.sps,
                  height: 50.sps,
                  margin: EdgeInsets.only(left: 16.sps),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: Image.asset(ImageAssetPath.icBack,
                      width: 20.sps, height: 20.sps),
                ),
              ),
            ),
      body: Container(
          color: AppColors.screenBackground,
          child: BlocConsumer<PersonalDetailCubit, PersonalDetailState>(
            listener: (context, state) {
              if (state is PersonalDetailLoading) {
                context.loaderOverlay.show();
              } else if (state is PersonalDetailInitial) {
                context.loaderOverlay.hide();
              } else if (state is PersonalDetailSuccess) {
                context.loaderOverlay.hide();
                goToNextPage();
              } else if (state is PersonalDetailNoInternet) {
                context.loaderOverlay.hide();
                AppUtils.showToast(AppConstants.noInternetTitle);
              } else if (state is PersonalDetailError) {
                context.loaderOverlay.hide();
                AppUtils.showToast(state.errorMessage);
              }
            },
            builder: (context, state) {
              cubit = BlocProvider.of<PersonalDetailCubit>(context);
              return mainContent();
            },
          )),
    );
  }

  Widget mainContent() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height - (kToolbarHeight + 48),
              child: Form(
                key: _key1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.sps),
                    Center(
                      child: Text(
                        (isFirstStep) ? "Personal details" : "Measurements",
                        style: $styles.text.h6
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 10.spt,
                            margin: const EdgeInsets.only(
                                left: 16, right: 8, top: 16),
                            decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 10.spt,
                            margin: const EdgeInsets.only(right: 16, top: 16),
                            decoration: BoxDecoration(
                                color: isFirstStep
                                    ? AppColors.lightestGreyColor
                                    : AppColors.primary,
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0))),
                          ),
                        ),
                      ],
                    ),
                    isFirstStep ? getBasicDetails() : getSliderWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppButton(
            background: AppColors.primary,
            text: "Continue",
            onClicked: () {
              if (isFirstStep) {
                if (_key1.currentState!.validate()) {
                  personalDetailsClicked();
                }
              } else {
                if (!isHeigtSelected) {
                  AppUtils.showToast("Please select height.");
                  return;
                }
                if (!isWeightSelected) {
                  AppUtils.showToast("Please select weight.");
                  return;
                }
                buttonClicked(weightValue, heightValue);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget getBasicDetails() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sps, vertical: 25.sps),
          child: AppTextFormField(
            hintText: "Name",
            labelText: "Name",
            isRequired: false,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp("^[A-Za-z\\s]*")),
            ],
            keyboardType: TextInputType.name,
            maxLength: 20,
            validator: (value) => _validateName(value!),
            textEditingController: nameController,
          ),
        ),
        GestureDetector(
          onTap: () {
            openDatePicker();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sps),
            child: AppTextFormField(
              hintText: "DD / MM / YYYY",
              labelText: "Date of birth",
              isRequired: false,
              preIconPath: ImageAssetPath.icCalendar,
              disableEditing: true,
              validator: (value) => _validateDOB(value!),
              textEditingController: dateInput,
              /*      onTap: (){

              },*/
            ),
          ),
        ),
      ],
    );
  }

  Widget getSliderWidget() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Height",
                      style:
                          $styles.text.h7.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: AppColors.lightGreenColor,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 8.0),
                        child: Text(
                          "$heightValue ${"cm"}",
                          style: $styles.text.h7
                              .copyWith(color: AppColors.blackColor),
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 8.0),
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40.0, left: 20),
                      child: Text(""),
                    ),
                    const Positioned(
                      right: 16.0,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0, left: 36),
                        child: Text("200"),
                      ),
                    ),
                    LocalSliderWidget(
                      imagePath: ImageAssetPath.icHeightAvo,
                      min: 0.0,
                      max: 100.0,
                      onChanged: (double value) {
                        isHeigtSelected = true;
                        setState(() {
                          heightValue =
                              double.parse((value + 100).toStringAsFixed(2));
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Current weight",
                      style:
                          $styles.text.h7.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: AppColors.lightGreenColor,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 8.0),
                        child: Text(
                          "$weightValue ${"kg"}",
                          style: $styles.text.h7
                              .copyWith(color: AppColors.blackColor),
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 8.0),
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40.0, left: 20),
                      child: Text(""),
                    ),
                    const Positioned(
                      right: 16.0,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0, left: 36),
                        child: Text("300"),
                      ),
                    ),
                    LocalSliderWidget(
                      imagePath: ImageAssetPath.icHeightAvo,
                      min: 0.0,
                      max: 100.0,
                      onChanged: (double value) {
                        isWeightSelected = true;
                        setState(() {
                          weightValue = (double.parse(
                              ((2.8 * value) + 20).toStringAsFixed(2)));
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _validateName(String value) {
    if (value.isEmpty) {
      return "Name is required" /*context?.resources.strings.cantBeEmpty*/;
    } else {
      return null;
    }
  }

  _validateDOB(String value) {
    if (value.isEmpty) {
      return "Date of birth is required" /*context?.resources.strings.cantBeEmpty*/;
    } else if (calculatedYear < 13) {
      return "You must be at least 13 years old to use our app.";
    } else {
      return null;
    }
  }

  void personalDetailsClicked() {
    String? name = nameController.text;
    String? dob = dateFormatted;
    if (name.isEmpty) {
      AppUtils.showToast("Please enter name");
      return;
    }
    if (dob.isEmpty) {
      AppUtils.showToast("Please select date");
      return;
    }
    setState(() {
      isFirstStep = false;
    });
  }

  void buttonClicked(double weightValue, double heightValue) {
    String? name = nameController.text;
    String? dob = dateFormatted;
    if (weightValue < 30) {
      return AppUtils.showToast("Please select weight value");
    } else if (heightValue < 100) {
      return AppUtils.showToast("Please select height value");
    }
    cubit.getProfileData(
        name, dob, heightValue.toString(), weightValue.toString());
  }

  Future<void> openDatePicker() async {
    DateTime date = DateTime.now();
    DateTime lastDate = DateTime(date.year - 13, date.month, date.day);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: lastDate,
      lastDate: lastDate,
      firstDate: DateTime(1950),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
                primary: AppColors.darkGreenColor,
                onPrimary: Colors.white,
                onSurface: AppColors.black,
                surface: AppColors.white,
                surfaceTint: AppColors.white),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('MMM dd,yyyy').format(pickedDate);
      dateFormatted = DateFormat('yyyy-MM-dd').format(pickedDate);
      calculatedYear = calculateAge(pickedDate);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16
      setState(() {
        dateInput.text = formattedDate; //set output date to TextField value.
      });
    } else {}
  }

  void goToNextPage() {
    Map<String, dynamic> data = {
      "name": (cubit.profileResponse?.name ?? ""),
    };
    RouteNavigator.popAllAndPushNamedReplacement(
        context, AppScreens.wellBeingIntroScreen,
        arguments: data);
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
