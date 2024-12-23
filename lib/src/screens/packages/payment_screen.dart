import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:curate/src/data/models/ChoosePackageResponse.dart'
    as packageResponse;

class PaymentScreen extends StatefulWidget {
  //final packageResponse.Data data;
  final Map<String, dynamic> mapData;
  const PaymentScreen({super.key, required this.mapData});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late packageResponse.Data data;
  bool beforeLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.mapData["data"];
    if (widget.mapData.containsKey("beforeLogin")) {
      beforeLogin = widget.mapData["beforeLogin"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: AppBar(
          backgroundColor: AppColors.screenBackground,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                              data.title ?? "",
                              style: $styles.text.body2
                                  .copyWith(color: AppColors.black),
                            ),
                          ),
                          Text(
                            "Rs ${(data.price ?? 0).toStringAsFixed(2)}",
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
                      SizedBox(height: 24.sps),
                      Text(
                        "Total",
                        style: $styles.text.h8.copyWith(color: AppColors.black),
                      ),
                      SizedBox(height: 12.sps),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "(Billed Amount)",
                              style: $styles.text.body2
                                  .copyWith(color: AppColors.black),
                            ),
                          ),
                          Text(
                            "Rs ${(data.price ?? 0).toStringAsFixed(2)}",
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
                text: beforeLogin ? "Start PCOS reversal" : "Home",
                onClicked: () {
                  if (beforeLogin) {
                    Navigator.pushNamed(context, AppScreens.getStarted);
                  } else {
                    Navigator.pushNamed(context, AppScreens.mainScreen);
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
