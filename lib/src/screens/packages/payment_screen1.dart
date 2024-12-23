import 'dart:io';

import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/ConsultantsProductResponse.dart';
import '../../data/models/ConsultantPaymentStatusResponse.dart' as metadd;

class PaymentScreen1 extends StatefulWidget {
  final Map<String, dynamic> data;
  const PaymentScreen1({super.key, required this.data});

  @override
  State<PaymentScreen1> createState() => _PaymentScreen1State();
}

class _PaymentScreen1State extends State<PaymentScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      /* appBar:PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight), child: CustomAppbar(),),*/
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 56.sps),
            Expanded(
                flex: 4,
                child: Center(
                    child: Image.asset(
                  ImageAssetPath.icPayment,
                ))),
            SizedBox(
              height: 20.sps,
            ),
            Center(
              child: Text(
                "Payment Successful",
                style: $styles.text.h6.copyWith(color: AppColors.blackColor),
              ),
            ),
            SizedBox(
              height: 16.sps,
            ),
            Padding(
              padding: EdgeInsets.all(16.sps),
              child: Card(
                surfaceTintColor: AppColors.white,
                color: AppColors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 16.sps, horizontal: 24.sps),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order summary",
                        style: $styles.text.h8.copyWith(color: AppColors.black),
                      ),
                      SizedBox(height: 16.sps),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Talk to our experts",
                              style: $styles.text.body2
                                  .copyWith(color: AppColors.black),
                            ),
                          ),
                          Text(
                            "Rs ${widget.data["price"]}",
                            style: $styles.text.title3
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.sps),
                      const Divider(
                        color: AppColors.blackColor,
                        height: 0,
                      ),
                      SizedBox(height: 58.sps),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Total",
                              style: $styles.text.h8
                                  .copyWith(color: AppColors.black),
                            ),
                          ),
                          Text(
                            "Rs ${widget.data["price"]}",
                            style: $styles.text.title3
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppButton(
                background: AppColors.primary,
                text: "Talk to our Health coach",
                onClicked: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  /* var whatsappUrl =
                      "whatsapp://send?phone=${(cubit.healthData?.healthCoach?.countryCode ?? "") + (cubit.healthData?.healthCoach?.mobile ?? "")}" +
                          "&text=${Uri.encodeComponent("Hi Dr. ${cubit.healthData?.healthCoach?.name ?? ""}, \nI want to discuss my health related issues")}";
*/

                  print("Talk to expert click");
                  print(widget.data["data"]);
                  MetaData1 data = widget.data["data"];

                  var whatsappUrl = data.whatsappLink ?? "";

                  /*var whatsappUrl =
                      "whatsapp://send?phone=${ "+91" + (data.mobile??"")}" +
                          "&text=${Uri.encodeComponent( (data.message??""))}";*/

                  const String whatsAppPlayStorelink =
                      "https://play.google.com/store/apps/details?id=com.whatsapp&hl=en&gl=US";
                  var whatsUpAppStoreLink =
                      "https://apps.apple.com/us/app/whatsapp-messenger/id310633997";

                  if (!await launch(whatsappUrl)) {
                    if (Platform.isAndroid) {
                      if (!await launchUrl(Uri.parse(whatsAppPlayStorelink))) {
                        AppUtils.showToast(
                            'Could not launch $whatsAppPlayStorelink');
                        throw Exception(
                            'Could not launch $whatsAppPlayStorelink');
                      }
                    } else {
                      if (!await launchUrl(Uri.parse(whatsUpAppStoreLink))) {
                        AppUtils.showToast(
                            'Could not launch $whatsUpAppStoreLink');
                        throw Exception(
                            'Could not launch $whatsUpAppStoreLink');
                      }
                    }
                    AppUtils.showToast('Could not launch $whatsappUrl');
                    throw Exception('Could not launch $whatsappUrl');
                  }
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom)
          ],
        ),
      ),
    );
  }
}
