import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:curate/src/screens/splash/splash_screen1.dart';
import 'package:curate/src/utils/notification/notification_count_bloc/notification_count_cubit.dart';
import 'package:curate/src/utils/notification/push_notifcation_service.dart';
import 'package:curate/src/utils/order_socket/order_socket_cubit.dart';
import 'package:curate/src/utils/order_socket/order_socket_state.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:curate/src/logic/SettingsLogic.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/utils/app_dependencies.dart';
import 'package:curate/src/utils/routes/app_router.dart';
import 'package:curate/src/utils/restart_widget.dart';
import 'package:curate/src/utils/themes.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);*/
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  await PushNotificationService().setupInteractedMessage();
  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  setupDependencies();
  await Future.delayed(const Duration(milliseconds: 500));
  NotificationCountCubit notificationCountBloc = NotificationCountCubit();
  OrderSocketCubit orderSocketCubit = OrderSocketCubit();
  final RemoteMessage? message =
      await PushNotificationService.firebaseMessaging.getInitialMessage();
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider.value(value: notificationCountBloc),
          BlocProvider.value(value: orderSocketCubit),
          //BlocProvider.value(value: cartCountCubit),
        ],
        child: MyApp(
          message: message,
        )),
  );
}

class MyApp extends StatefulWidget {
  final RemoteMessage? message;
  const MyApp({super.key, this.message});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _router = AppRouter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = false;
    return RestartWidget(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Sizer(
          builder: (context, orientation, deviceType) {
            /*    WidgetsFlutterBinding.ensureInitialized();
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);*/
            // Set system UI to Dark with Light icons
            SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              statusBarColor: AppColors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ));

            // final isTablet = SizerUtil.deviceType == DeviceType.tablet;
            // final isTablet = deviceType == DeviceType.tablet;

            return GlobalLoaderOverlay(
              overlayWholeScreen: true,
              overlayColor: AppColors.darkGrey.withOpacity(0.7),
              child: MaterialApp(
                title: 'Curate',
                debugShowCheckedModeBanner: false,
                theme: theme,
                navigatorKey: RouteNavigator.navigatorKey,
                // navigatorKey: navigatorKey,
                /*  localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                CountryLocalizations.delegate,
              ],*/
                home: SplashScreen1.create(widget.message),
                //home: ChoosePackageScreen.create(),
                onGenerateRoute: _router.getRoute,
                navigatorObservers: [
                  _router.routeObserver,
                  ChuckerFlutter.navigatorObserver
                ],
                builder: (context, child) {
                  return BlocConsumer<OrderSocketCubit, OrderSocketState>(
                    builder: (socketContext, socketState) {
                      if (socketState.isDataLoaded) {
                        context.loaderOverlay.hide();
                      }
                      return child!;
                    },
                    listener: (socketContext, socketState) {
                      if (socketState.isDataLoaded) {
                        context.loaderOverlay.hide();
                        print("socketState.data");
                        print(socketState.data);
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Add syntax sugar for quickly accessing the main logical controllers in the app
/// We deliberately do not create shortcuts for services, to discourage their use directly in the view/widget layer.
/*AppLogic get appLogic => GetIt.I.get<AppLogic>();
WondersLogic get wondersLogic => GetIt.I.get<WondersLogic>();
TimelineLogic get timelineLogic => GetIt.I.get<TimelineLogic>();*/
SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();

//LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();

//AppLocalizations get $strings => localeLogic.strings;

/*LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();
UnsplashLogic get unsplashLogic => GetIt.I.get<UnsplashLogic>();
MetAPILogic get metAPILogic => GetIt.I.get<MetAPILogic>();
CollectiblesLogic get collectiblesLogic => GetIt.I.get<CollectiblesLogic>();
WallPaperLogic get wallpaperLogic => GetIt.I.get<WallPaperLogic>();
AppLocalizations get $strings => localeLogic.strings;*/
