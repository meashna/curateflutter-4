import 'dart:io'; // Provides access to platform-specific code (Android/iOS).
import 'package:curate/src/constants/app_constants.dart'; // Custom app constants.
import 'package:curate/src/constants/asset_path.dart'; // Asset paths for images/icons.
import 'package:curate/src/screens/app_screens.dart'; // Screen navigation paths.
import 'package:curate/src/screens/mainscreen/chat/cubit/chat_cubit.dart'; // Bloc cubit for chat functionality.
import 'package:curate/src/styles/colors.dart'; // Custom colors.
import 'package:curate/src/styles/styles.dart'; // Custom text styles.
import 'package:curate/src/utils/extensions.dart'; // Custom extensions.
import 'package:curate/src/widgets/refresh_indicator_widget.dart'; // Custom refresh indicator widget.
import 'package:flutter/material.dart'; // Flutter framework.
import 'package:flutter_bloc/flutter_bloc.dart'; // Bloc for state management.
import 'package:flutter_profile_picture/flutter_profile_picture.dart'; // Profile picture widget.
import 'package:flutter_svg/flutter_svg.dart'; // SVG image support.
import 'package:url_launcher/url_launcher.dart'; // To launch URLs.
import '../../../utils/app_utils.dart'; // Utility functions.
import '../../../widgets/no_internet_widget.dart'; // Widget to display when no internet.
import '../../../widgets/shimmer_widget.dart'; // Shimmer effect for loading states.

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static Widget create() {
    return BlocProvider(
      create: (BuildContext context) => ChatCubit(),
      child: const ChatScreen(),
    );
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatCubit cubit;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatLoading) {
          isLoading = true;
        } else if (state is ChatInitial) {
          isLoading = false;
        } else if (state is ChatSuccess) {
          isLoading = false;
        } else if (state is ChatError) {
          isLoading = false;
          AppUtils.showToast(state.errorMessage);
        } else if (state is ChatNoInternet) {
          isLoading = false;
          //AppUtils.showToast(AppConstants.noInternetTitle);
        }
      },
      builder: (context1, state) {
        cubit = BlocProvider.of<ChatCubit>(context1);
        if (state is ChatInitial ||
            state is ChatError ||
            state is ChatSuccess ||
            state is ChatLoading) {
          return getMainContent();
        } else if (state is ChatNoInternet) {
          if (cubit.healthData != null) {
            return Container(
              color: AppColors.screenBackground,
              child: getMainContent(),
            );
          } else {
            return NoInternetWidget(() {
              cubit.getHealthCoach();
            });
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget getMainContent() {
    return CustomRefresIndicator(
      onRefresh: () => cubit.getHealthCoach(),
      child: Stack(
        children: [
          Container(
            color: AppColors.screenBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.sps),
                  child: Text(
                    "Chat",
                    style:
                        $styles.text.h5.copyWith(color: AppColors.blackColor),
                  ),
                ),
                if (isLoading)
                  getListSkelton()
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.sps),
                        child: Text(
                          AppConstants.chatDescription,
                          textAlign: TextAlign.start,
                          style: $styles.text.body2
                              .copyWith(color: AppColors.darkGreyColor),
                        ),
                      ),
                      SizedBox(height: 24.sps),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.sps),
                        child: GestureDetector(
                          onTap: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            var whatsappUrl = cubit.healthData?.link ??
                                "https://wa.link/g1p6rd";
                            const String whatsAppPlayStorelink =
                                "https://play.google.com/store/apps/details?id=com.whatsapp&hl=en&gl=US";
                            const String whatsUpAppStoreLink =
                                "https://apps.apple.com/us/app/whatsapp-messenger/id310633997";
                            if (!await launch(whatsappUrl)) {
                              if (Platform.isAndroid) {
                                if (!await launchUrl(
                                    Uri.parse(whatsAppPlayStorelink))) {
                                  AppUtils.showToast(
                                      'Could not launch $whatsAppPlayStorelink');
                                  throw Exception(
                                      'Could not launch $whatsAppPlayStorelink');
                                }
                              } else {
                                if (!await launchUrl(
                                    Uri.parse(whatsUpAppStoreLink))) {
                                  AppUtils.showToast(
                                      'Could not launch $whatsUpAppStoreLink');
                                  throw Exception(
                                      'Could not launch $whatsUpAppStoreLink');
                                }
                              }
                              AppUtils.showToast(
                                  'Could not launch $whatsappUrl');
                              throw Exception('Could not launch $whatsappUrl');
                            }
                          },
                          child: Card(
                            color: AppColors.white,
                            surfaceTintColor: AppColors.white,
                            child: Padding(
                              padding: EdgeInsets.all(16.sps),
                              child: Row(
                                children: [
                                  ProfilePicture(
                                    name: "H",
                                    radius: 26.sps,
                                    fontsize: 21,
                                    count: 2,
                                    random: true,
                                  ),
                                  SizedBox(
                                    width: 12.sps,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Health Coach",
                                          style: $styles.text.h7.copyWith(
                                              color: AppColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    ImageAssetPath.icWhatsApp,
                                    width: 50.sps,
                                    height: 50.sps,
                                    fit: BoxFit.fill,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Visibility(
                  visible: (cubit.healthData != null),
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45.sps),
                      child: Image.asset(
                        ImageAssetPath.icSpash,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getListSkelton() {
    return Column(
      children: [
        SizedBox(
          height: 12.sps,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sps),
          child: ShimmerWidget.rectangular(height: 16.sps),
        ),
        Padding(
          padding: EdgeInsets.all(16.sps),
          child: Card(
            color: AppColors.white,
            margin: EdgeInsets.only(bottom: 12.sps),
            surfaceTintColor: AppColors.white,
            child: Padding(
              padding: EdgeInsets.all(16.sps),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.rectangular(height: 16.sps, width: 120.sps),
                  SizedBox(
                    height: 12.sps,
                  ),
                  ShimmerWidget.rectangular(height: 16.sps),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
