import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/ChoosePackageResponse.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/order_socket/order_socket_state.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../constants/api_constants.dart';
import '../../../data/manager/preferences_manager.dart';
import '../../../utils/order_socket/order_socket_cubit.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_feild/app_text_from_feild.dart';
import 'cubit/choose_package_cubit.dart';
import 'dart:io' show Platform;

class ChoosePackageScreen extends StatefulWidget {
  final Map<String, dynamic>? argumentData;
  const ChoosePackageScreen({super.key, this.argumentData});

  @override
  State<ChoosePackageScreen> createState() => _ChoosePackageScreenState();

  static Widget create(Map<String, dynamic>? argumentData) {
    return BlocProvider(
        create: (BuildContext context) =>
            ChoosePackageCubit(argumentData, context),
        child: ChoosePackageScreen(
          argumentData: argumentData,
        ));
  }
}

class _ChoosePackageScreenState extends State<ChoosePackageScreen> {
  ChoosePackageResponse? choosePackageResponse;
  List<ProductDetails> products = <ProductDetails>[];
  Data? elementType;
  bool showSkip = false;

  @override
  void initState() {
    super.initState();
    if (widget.argumentData != null) {
      showSkip = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            RouteNavigator.goBack();
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
        title: Text("Choose your plan",
            style: $styles.text.body1.copyWith(color: AppColors.blackColor)),
        centerTitle: true,
        actions: [
          showSkip
              ? GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppScreens.getStarted);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sps),
                    child: Center(
                      child: Text(
                        "Skip",
                        style: $styles.text.body2
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: Container(
        color: AppColors.screenBackground,
        child: BlocConsumer<OrderSocketCubit, OrderSocketState>(
          builder: (socketContext, socketState) {
            return BlocConsumer<ChoosePackageCubit, ChoosePackageState>(
              builder: (context1, state) {
                var cubit = BlocProvider.of<ChoosePackageCubit>(context);
                choosePackageResponse = cubit.choosePackageResponse;
                products = cubit.products;
                if (state is ChoosePackageLoading) {
                  return const Scaffold();
                }
                if (state is ChoosePackageNoInternet) {
                  return NoInternetWidget(() {
                    cubit.getPackageData();
                  });
                }
                if (state is ChoosePackageError) {
                  return CustomErrorWidget(() {
                    cubit.getPackageData();
                  });
                }
                if (choosePackageResponse == null) {
                  return NoDataWidget(
                      image: ImageAssetPath.icNoData,
                      title: "No plan available");
                }

                List<Widget> statements = <Widget>[];
                statements.add(getTitle());
                statements.add(SizedBox(height: 16));
                for (var element in (choosePackageResponse!.points ?? [])) {
                  if (element.title != null) {
                    statements.add(getStatement(element.title ?? ""));
                  }
                }

                for (var element in (choosePackageResponse!.data ?? [])) {
                  int index =
                      (choosePackageResponse!.data ?? []).indexOf(element);
                  if (element.type == 1) {
                    statements.add(InkWell(
                        onTap: () async {
                          elementType = element;
                          if (Platform.isIOS) {
                            cubit.setSelectedIOSproduct(elementType);
                          } else {
                            showUpiSheet(
                                context1, socketContext, Platform.isIOS);
                          }
                        },
                        child: getKickStarterWidget1(element)));
                  }
                  if (element.type == 2) {
                    statements.add(InkWell(
                        onTap: () async {
                          elementType = element;
                          if (Platform.isIOS) {
                            cubit.setSelectedIOSproduct(elementType);
                          } else {
                            showUpiSheet(
                                context1, socketContext, Platform.isIOS);
                          }
                        },
                        child: getPopularWidget(element)));
                  }
                  if (element.type == 3) {
                    statements.add(InkWell(
                        onTap: () async {
                          elementType = element;
                          if (Platform.isIOS) {
                            cubit.setSelectedIOSproduct(elementType);
                          } else {
                            showUpiSheet(
                                context1, socketContext, Platform.isIOS);
                          }
                        },
                        child: getPrepregnancyWidget(element)));
                  }
                }
                /* if(Platform.isIOS){
              products.forEach((element) {
                int index = (products).indexOf(element);
                if(element.id == "com.curate.plan3Month"){
                  statements.add(InkWell(
                      onTap: () async {
                        var cubit = BlocProvider.of<ChoosePackageCubit>(context);
                        cubit.purchaseIOSProduct(element);
                      },
                      child: getIOSKickStarterWidget1(element)));
                }
                else if(element.id == "com.curate.plan6Month"){
                  statements.add(InkWell(
                      onTap: () async {
                        var cubit = BlocProvider.of<ChoosePackageCubit>(context);
                        cubit.setSelectedIOSproduct(element);
                        showUpiSheet(context1,socketContext,Platform.isIOS);
                        */ /*elementType = element;
                      paymnetSelectedindex = index;
                      showUpiSheet(context1,socketContext);*/ /*
                      },
                      child: getIOSPopularWidget(element)));
                }
               else if(element.id == "com.curate.plan12Month"){
                  statements.add(InkWell(
                      onTap: () async {
                        var cubit = BlocProvider.of<ChoosePackageCubit>(context);
                        cubit.setSelectedIOSproduct(element);
                        showUpiSheet(context1,socketContext,Platform.isIOS);
                      },
                      child: getIOSPrepregnancyWidget(element)));
                }else {
                  statements.add(InkWell(
                      onTap: () async {
                        var cubit = BlocProvider.of<ChoosePackageCubit>(context);
                        cubit.setSelectedIOSproduct(element);
                        showUpiSheet(context1,socketContext,Platform.isIOS);

                      },
                      child: getIOSKickStarterWidget1(element)));
                }

              });
            }else{
              (choosePackageResponse!.data ?? []).forEach((element) {
                int index = (choosePackageResponse!.data ?? []).indexOf(element);
                if (element.type == 1) {
                  statements.add(InkWell(
                      onTap: () async {
                        elementType = element;
                        showUpiSheet(context1,socketContext,Platform.isIOS);
                      },
                      child: getKickStarterWidget1(element)));
                }
                if (element.type == 2) {
                  statements.add(InkWell(
                      onTap: () async {
                        elementType = element;
                        showUpiSheet(context1,socketContext,Platform.isIOS);
                      },
                      child: getPopularWidget(element)));
                }
                if (element.type == 3) {
                  statements.add(InkWell(
                      onTap: () async {
                        elementType = element;
                        showUpiSheet(context1,socketContext,Platform.isIOS);
                      },
                      child: getPrepregnancyWidget(element)));
                }
              });
            }*/

                return ListView(
                  children: statements,
                );
              },
              listener: (context, state) {
                if (state is ChoosePackageLoading) {
                  context.loaderOverlay.show();
                } else if (state is ChoosePackageInitial) {
                  context.loaderOverlay.hide();
                } else if (state is ChoosePackageError) {
                  context.loaderOverlay.hide();
                }
              },
            );
          },
          listener: (socketContext, socketState) {
            if (socketState.isDataLoaded) {
              context.loaderOverlay.hide();
              print("socketState.data");
              print(socketState.data);
              if (socketState.data!["status"] == 6) {
                Map<String, dynamic> data = {};
                if (widget.argumentData != null) {
                  data.addAll({"beforeLogin": true});
                }
                data.addAll({"data": elementType!});
                RouteNavigator.pushNamedAndRemoveUntil(
                    context, AppScreens.payment, AppScreens.mainScreen,
                    arguments: data);
                //RouteNavigator.pushNamed(context,AppScreens.payment,arguments:  data);
              } else {
                showAlertDialog(socketContext, socketState.data!);
              }
            }
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, Map<String, dynamic> data) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Payment status"),
      content: Text(
          data["status"] == 6 ? "Payment successfull." : "Payment failed."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showUpiSheet(
      BuildContext mainContext, BuildContext socketContext, bool isIOS) {
    TextEditingController controller = TextEditingController();
    var cubit = BlocProvider.of<ChoosePackageCubit>(mainContext);
    var orderCubit = BlocProvider.of<OrderSocketCubit>(socketContext);
    bool isUpiClicked = false;
    validateUpiID(String value) {
      if (value.isEmpty) {
        return "Upi id is required" /*context?.resources.strings.cantBeEmpty*/;
      } else {
        return null;
      }
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        isScrollControlled: true,
        backgroundColor: AppColors.lightestGreyColor1,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  // SizedBox(height: 100.sps,),
                  if (elementType != null) ...[
                    if (elementType!.type == 1) ...[
                      getKickStarterWidget1(elementType!),
                    ],
                    if (elementType!.type == 2) ...[
                      getPopularWidget(elementType!),
                    ],
                    if (elementType!.type == 3) ...[
                      getPrepregnancyWidget(elementType!),
                    ]
                  ],
                  SizedBox(
                    height: 32.sps,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20.sps),
                    child: isIOS && !isUpiClicked
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                SizedBox(
                                  width: 20.sps,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 45.sps,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Center(
                                      child: AppButton(
                                        text: "In-App Purchase",
                                        horizontalPadding: 16,
                                        verticalPadding: 12.sps,
                                        background: AppColors.primary,
                                        onClicked: () async {
                                          Navigator.pop(context);
                                          cubit.setSelectedIOSproduct(
                                              elementType);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 45.sps,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Center(
                                      child: AppButton(
                                        text: "Upi Pay",
                                        horizontalPadding: 16,
                                        verticalPadding: 12.sps,
                                        background: AppColors.primary,
                                        onClicked: () async {
                                          isUpiClicked = true;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ])
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20.sps,
                              ),
                              Expanded(
                                flex: 2,
                                child: AppTextFormField(
                                  hintText: "Enter your UPI Id",
                                  isLabelVisible: false,
                                  keyboardType: TextInputType.text,
                                  textEditingController: controller,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(' ')
                                  ],
                                  maxLength: 40,
                                  maxLines: 1,
                                  validator: (value) => validateUpiID(value!),
                                  isRequired: false,
                                  labelText: '',
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 45.sps,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Center(
                                    child: AppButton(
                                      text: "Pay",
                                      horizontalPadding: 16,
                                      verticalPadding: 12.sps,
                                      background: AppColors.primary,
                                      onClicked: () async {
                                        if (controller.text.isNotEmpty) {
                                          Navigator.pop(context);
                                          context.loaderOverlay.show();
                                          Map<String, dynamic> data =
                                              await cubit.getOrderId(
                                                  id: elementType?.id,
                                                  upiID: controller.text);
                                          var time = DateTime.now()
                                              .millisecondsSinceEpoch;
                                          print("data");
                                          print(data);
                                          if (data["status"] ==
                                              ApiConstants
                                                  .paymentStatusPending) {
                                            orderCubit.runSocket();
                                            Map<String, dynamic> orderData = {
                                              "id": data["id"],
                                              "time": time
                                            };
                                            final preferences =
                                                GetIt.I<PreferencesManager>();
                                            preferences
                                                .setOrderSatatus(orderData);
                                            Future.delayed(Duration(minutes: 5),
                                                () {
                                              mainContext.loaderOverlay.hide();
                                            });
                                          } else {
                                            mainContext.loaderOverlay.hide();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(
                    height: 32.sps,
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget getStatement(String text) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.sps),
        margin: EdgeInsets.only(bottom: 12.sps),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(ImageAssetPath.icTick),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sps),
                child: Text(text,
                    style:
                        $styles.text.body2.copyWith(color: AppColors.darkGrey)),
              ),
            ),
          ],
        ));
  }

  Widget getTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44.0),
      child: Text(
        "Choose a plan which works\n best for you",
        style: $styles.text.h6.copyWith(color: AppColors.blackColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getIOSKickStarterWidget1(ProductDetails element) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        color: AppColors.lightGreenColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      element.title ?? "",
                      style: $styles.text.title3
                          .copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 4.sps, horizontal: 16.sps),
                    decoration: const BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(element.description ?? "",
                        style: $styles.text.title3
                            .copyWith(color: AppColors.darkGreenColor)),
                  )
                ],
              ),
              SizedBox(height: 18.sps),
              RichText(
                  text: TextSpan(
                      text: "Rs. ",
                      style:
                          $styles.text.h7.copyWith(color: AppColors.blackColor),
                      children: [
                    TextSpan(
                      text: (element.rawPrice ?? 0).toStringAsFixed(2),
                      style:
                          $styles.text.h5.copyWith(color: AppColors.blackColor),
                    ),
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  Widget getIOSPopularWidget(ProductDetails element) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: AppColors.greenColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                color: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 8.sps),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageAssetPath.icPopular,
                      height: 16.sps,
                      width: 16.sps,
                    ),
                    SizedBox(
                      width: 8.sps,
                    ),
                    Text(
                      "Popular",
                      style:
                          $styles.text.title3.copyWith(color: AppColors.white),
                    ),
                  ],
                )),
            Padding(
              padding:
                  EdgeInsets.only(top: 16.sps, left: 16.sps, right: 16.sps),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      element.title ?? "",
                      style: $styles.text.title3
                          .copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 4.sps, horizontal: 16.sps),
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(element.description ?? "",
                        style: $styles.text.title3
                            .copyWith(color: AppColors.darkGreenColor)),
                  )
                ],
              ),
            ),
            SizedBox(height: 18.sps),
            Padding(
              padding:
                  EdgeInsets.only(bottom: 16.sps, left: 16.sps, right: 16.sps),
              child: RichText(
                  text: TextSpan(
                      text: "Rs. ",
                      style:
                          $styles.text.h7.copyWith(color: AppColors.blackColor),
                      children: [
                    TextSpan(
                      text: (element.rawPrice ?? 0).toStringAsFixed(2),
                      style:
                          $styles.text.h5.copyWith(color: AppColors.blackColor),
                    ),
                  ])),
            )
          ],
        ),
      ),
    );
  }

  Widget getIOSPrepregnancyWidget(ProductDetails element) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        color: AppColors.darkestGreenColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      element.title ?? "",
                      style:
                          $styles.text.title3.copyWith(color: AppColors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 4.sps, horizontal: 16.sps),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(element.description ?? "",
                        style: $styles.text.title3
                            .copyWith(color: AppColors.darkGreenColor)),
                  )
                ],
              ),
              SizedBox(height: 18.sps),
              RichText(
                  text: TextSpan(
                      text: "Rs. ",
                      style: $styles.text.h7.copyWith(color: AppColors.white),
                      children: [
                    TextSpan(
                      text: (element.rawPrice ?? 0).toStringAsFixed(2),
                      style: $styles.text.h5.copyWith(color: AppColors.white),
                    ),
/*     TextSpan(
                          text:" / ",
                          style: $styles.text.body2.copyWith(color: AppColors.lightestGreyColor),
                        ),
                        TextSpan(
                          text:"month",
                          style: $styles.text.body2.copyWith(color: AppColors.lightestGreyColor),
                        )*/
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  Widget getKickStarterWidget1(Data element) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        color: AppColors.lightGreenColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      element.title ?? "",
                      style: $styles.text.title3
                          .copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 4.sps, horizontal: 16.sps),
                    decoration: const BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(element.durationTitle ?? "",
                        style: $styles.text.title3
                            .copyWith(color: AppColors.darkGreenColor)),
                  )
                ],
              ),
              SizedBox(height: 18.sps),
              RichText(
                  text: TextSpan(
                      text: "Rs. ",
                      style:
                          $styles.text.h7.copyWith(color: AppColors.blackColor),
                      children: [
                    TextSpan(
                      text: (element.price ?? 0).toStringAsFixed(2),
                      style:
                          $styles.text.h5.copyWith(color: AppColors.blackColor),
                    ),
/*  TextSpan(
                          text: "/",
                          style: $styles.text.body2.copyWith(color: AppColors.darkGrey),
                        ),
                        TextSpan(
                          text:"days",
                          style: $styles.text.body2.copyWith(color: AppColors.darkGrey),
                        )*/
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  Widget getPopularWidget(Data element) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: AppColors.greenColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                color: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 8.sps),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageAssetPath.icPopular,
                      height: 16.sps,
                      width: 16.sps,
                    ),
                    SizedBox(
                      width: 8.sps,
                    ),
                    Text(
                      "Popular",
                      style:
                          $styles.text.title3.copyWith(color: AppColors.white),
                    ),
                  ],
                )),
            Padding(
              padding:
                  EdgeInsets.only(top: 16.sps, left: 16.sps, right: 16.sps),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      element.title ?? "",
                      style: $styles.text.title3
                          .copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 4.sps, horizontal: 16.sps),
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(element.durationTitle ?? "",
                        style: $styles.text.title3
                            .copyWith(color: AppColors.darkGreenColor)),
                  )
                ],
              ),
            ),
            SizedBox(height: 18.sps),
            Padding(
              padding:
                  EdgeInsets.only(bottom: 16.sps, left: 16.sps, right: 16.sps),
              child: RichText(
                  text: TextSpan(
                      text: "Rs. ",
                      style:
                          $styles.text.h7.copyWith(color: AppColors.blackColor),
                      children: [
                    TextSpan(
                      text: (element.price ?? 0).toStringAsFixed(2),
                      style:
                          $styles.text.h5.copyWith(color: AppColors.blackColor),
                    ),
/*  TextSpan(
                          text:" / ",
                          style: $styles.text.body2.copyWith(color: AppColors.darkGrey),
                        ),
                        TextSpan(
                          text:"month",
                          style: $styles.text.body2.copyWith(color: AppColors.darkGrey),
                        )*/
                  ])),
            )
          ],
        ),
      ),
    );
  }

  Widget getPrepregnancyWidget(Data element) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        color: AppColors.darkestGreenColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      element.title ?? "",
                      style:
                          $styles.text.title3.copyWith(color: AppColors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 4.sps, horizontal: 16.sps),
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(element.durationTitle ?? "",
                        style: $styles.text.title3
                            .copyWith(color: AppColors.darkGreenColor)),
                  )
                ],
              ),
              SizedBox(height: 18.sps),
              RichText(
                  text: TextSpan(
                      text: "Rs. ",
                      style: $styles.text.h7.copyWith(color: AppColors.white),
                      children: [
                    TextSpan(
                      text: (element.price ?? 0).toStringAsFixed(2),
                      style: $styles.text.h5.copyWith(color: AppColors.white),
                    ),
/*     TextSpan(
                          text:" / ",
                          style: $styles.text.body2.copyWith(color: AppColors.lightestGreyColor),
                        ),
                        TextSpan(
                          text:"month",
                          style: $styles.text.body2.copyWith(color: AppColors.lightestGreyColor),
                        )*/
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
