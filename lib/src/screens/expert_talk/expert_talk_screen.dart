import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../data/manager/preferences_manager.dart';
import '../../data/models/ConsultantsProductResponse.dart';
import '../../utils/order_socket/order_socket_cubit.dart';
import '../../utils/order_socket/order_socket_state.dart';
import '../../widgets/app_text_feild/app_text_from_feild.dart';
import '../../widgets/no_internet_widget.dart';
import 'cubit/expert_talk_cubit.dart';

class ExpertTalkScreen extends StatefulWidget {
  const ExpertTalkScreen({super.key});
  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => ExpertTalkCubit(),
        child: const ExpertTalkScreen());
  }

  @override
  State<ExpertTalkScreen> createState() => _ExpertTalkScreenState();
}

class _ExpertTalkScreenState extends State<ExpertTalkScreen> {
  late ExpertTalkCubit cubit;
  ConsultantsProductResponse? consultantsProductResponse;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderSocketCubit, OrderSocketState>(
      builder: (socketContext, socketState) {
        return BlocConsumer<ExpertTalkCubit, ExpertTalkState>(
            builder: (context, state) {
          cubit = BlocProvider.of<ExpertTalkCubit>(context);

          if (state is ExpertTalkStateNoInternet) {
            return NoInternetWidget(() {
              cubit.getConsultantProduct();
            });
          }
          if (state is ExpertTalkStateError) {
            return CustomErrorWidget(() {
              cubit.getConsultantProduct();
            });
          }
          if (state is ExpertTalkStateLoading) {
            return const Scaffold();
          }
          String? title, description;
          num? price;
          List<String>? descriptionSplit = [];
          consultantsProductResponse = cubit.consultantsProductResponse;
          if (consultantsProductResponse != null) {
            title = consultantsProductResponse!.product?.title;
            description = consultantsProductResponse!.product?.description;
            price = consultantsProductResponse!.product?.price;
            descriptionSplit =
                consultantsProductResponse!.product?.metaDataContent;
          }

          return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size(double.infinity, kToolbarHeight),
                child: CustomAppbar()),
            body: Container(
              color: AppColors.screenBackground,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.sps),
                    Center(
                      child: Text(
                        title ?? "Talk to our experts",
                        style: $styles.text.h6
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ),
                    SizedBox(height: 16.sps),
                    descriptionSplit != null
                        ? Expanded(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: descriptionSplit.length + 1,
                                itemBuilder: (context, index) {
                                  return getStatement(
                                      (index == (descriptionSplit!.length ?? 0))
                                          ? ""
                                          : descriptionSplit[index] ?? "",
                                      index);
                                }),
                          )
                        : Container(),
                    SizedBox(height: 16.sps),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppButton(
                        background: AppColors.primary,
                        text: "${"Talk to our expert @ Rs."}$price/-",
                        onClicked: () {
                          showUpiSheet(context, socketContext);

                          //showConfirmBottomSheet();
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).viewPadding.bottom)
                  ]),
            ),
          );
        }, listener: (context, state) {
          if (state is ExpertTalkStateSuccess) {
            context.loaderOverlay.hide();
          }
          if (state is ExpertTalkStateLoading) {
            context.loaderOverlay.show();
          }
          if (state is ExpertTalkStateEmpty) {
            context.loaderOverlay.hide();
          }
          if (state is ExpertTalkStateError) {
            context.loaderOverlay.hide();
          }
          if (state is ExpertTalkStateNoInternet) {
            context.loaderOverlay.hide();
          }
        });
      },
      listener: (socketContext, socketState) {
        //AppUtils.showToast("Socket called");
        context.loaderOverlay.hide();
        if (socketState.isDataLoaded) {
          context.loaderOverlay.hide();
          if (socketState.data!["status"] == 6) {
            Map<String, dynamic> argument = {
              "data":
                  cubit.consultantsProductResponse?.product?.metaData?.first,
              "price": cubit.consultantsProductResponse?.product?.price ?? "0"
            };
            RouteNavigator.popAllAndPushNamedReplacement(
                context, AppScreens.expertPayment,
                arguments: argument);
            //RouteNavigator.pushNamed(context,AppScreens.expertPayment,arguments: argument);
          } else {
            showAlertDialog(socketContext, socketState.data!);
          }
        }
      },
    );
  }

  Future showConfirmBottomSheet() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        backgroundColor: AppColors.lightestGreyColor1,
        context: context,
        builder: (context) {
          return Wrap(
            spacing: 32.sps,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 32.sps),
                    child: Center(
                        child: Image.asset(ImageAssetPath.icExpertPayment)),
                  ),
                  Positioned(
                      right: 10.sps,
                      top: 16.sps,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50.sps,
                          width: 50.sps,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.white),
                          child: Image.asset(
                            ImageAssetPath.icClose,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 32.sps,
              ),
              Center(
                child: Text(
                  "Our health coach will be\n contacting you shortly!",
                  style: $styles.text.h6.copyWith(color: AppColors.black),
                ),
              ),
              SizedBox(
                height: 32.sps,
              ),
            ],
          );
        });
  }

  Widget getStatement(String text, int index) {
    if (index ==
        (cubit.consultantsProductResponse!.product?.metaDataContent?.length ??
            0)) {
      return Image.asset(ImageAssetPath.icOnboarding2);
    } else {
      return Container(
          padding: EdgeInsets.only(left: 16.sps, right: 16.sps, bottom: 12.sps),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ImageAssetPath.icTick),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sps),
                  child: Text(text,
                      style: $styles.text.body2
                          .copyWith(color: AppColors.darkGrey)),
                ),
              ),
            ],
          ));
    }
  }

  void showUpiSheet(BuildContext mainContext, BuildContext socketContext) {
    TextEditingController controller = TextEditingController();
    var cubit = BlocProvider.of<ExpertTalkCubit>(mainContext);
    var orderCubit = BlocProvider.of<OrderSocketCubit>(socketContext);
    validateUpiID(String value) {
      if (value.isEmpty) {
        return "Upi id is required";
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
                  Container(
                    padding: EdgeInsets.only(top: 32.sps, bottom: 20.sps),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20.sps,
                        ),
                        Expanded(
                            child: Text(
                          "Payment Amount",
                          style:
                              $styles.text.h9.copyWith(color: AppColors.black),
                        )),
                        SizedBox(
                          width: 16.sps,
                        ),
                        Text(
                          "Rs. ${consultantsProductResponse!.product?.price ?? 0}/-",
                          style:
                              $styles.text.h9.copyWith(color: AppColors.black),
                        ),
                        SizedBox(
                          width: 20.sps,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 40.sps, top: 0.sps),
                    child: Row(
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: AppButton(
                                text: "Pay",
                                horizontalPadding: 16,
                                verticalPadding: 12.sps,
                                background: AppColors.primary,
                                onClicked: () async {
                                  if (controller.text.isNotEmpty) {
                                    Navigator.pop(context);
                                    Future.delayed(Duration(milliseconds: 800),
                                        () {
                                      mainContext.loaderOverlay.show();
                                    });

                                    Map<String, dynamic> data =
                                        await cubit.getOrderId(
                                            id: consultantsProductResponse!
                                                .product?.id,
                                            upiID: controller.text);
                                    var time =
                                        DateTime.now().millisecondsSinceEpoch;
                                    if (data["status"] == 5) {
                                      orderCubit.runSocket();
                                      Map<String, dynamic> orderData = {
                                        "id": data["id"],
                                        "time": time
                                      };
                                      final preferences =
                                          GetIt.I<PreferencesManager>();
                                      preferences.setOrderSatatus(orderData);
                                      Future.delayed(Duration(minutes: 10), () {
                                        mainContext.loaderOverlay.hide();
                                      });
                                    } else {
                                      print("hugyftdfcghijko");
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
                ],
              ),
            );
          });
        });
  }

  showAlertDialog(BuildContext context, Map<String, dynamic> data) {
    // set up the button
    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Payment status"),
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
}
