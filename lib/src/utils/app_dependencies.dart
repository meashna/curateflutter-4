import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../data/manager/preferences_manager.dart';
import '../data/dio_client.dart';
import '../data/repository/user_repo/user_repository.dart';
import '../data/repository/user_repo/user_repository_impl.dart';
import '../logic/SettingsLogic.dart';



final GetIt _getIt = GetIt.instance;

void setupDependencies() {
  // Logger
  _getIt.registerSingleton<Logger>(Logger());

  // Preference Manager
  _getIt.registerSingleton<PreferencesManager>(PreferencesManager());

  // HTTP Client
  _getIt.registerSingleton<Dio>(DioClient().getDio());

  // Repositories
  _getIt.registerSingleton<UserRepository>(UserRepositoryImpl());

  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  // Localizations
 // GetIt.I.registerLazySingleton<LocaleLogic>(() => LocaleLogic());


 /* // Repositories
  _getIt.registerSingleton<UserRepository>(UserRepositoryImpl());

  _getIt.registerSingleton<LearnCalligraphyRepository>(
      LearnCalligraphyRepositoryImpl());

  _getIt.registerSingleton<ExploreRepository>(
      ExploreRepositoryImpl());

  _getIt.registerSingleton<GoogleLoginManager>(GoogleLoginManager());

  _getIt.registerSingleton<AppleLoginManager>(AppleLoginManager());

  _getIt.registerSingleton<HistoryTimelineRepository>(HistoryTimelineRepositoryImpl());

  _getIt.registerSingleton<ProgressRepository>(ProgressRepositoryImpl());

  _getIt.registerSingleton<BookmarkRepository>(BookmarkRepositoryImpl());

  _getIt.registerSingleton<ChartRepository>(ChartRepositoryImpl());

  _getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl());

  _getIt.registerSingleton<PaymentRepository>(PaymentRepositoryImpl());

  _getIt.registerSingleton<ContactUsRepository>(ContactUsRepositoryImpl());

  _getIt.registerSingleton<CouponCodeRepository>(CouponCodeRepositoryImpl());

  _getIt.registerSingleton<NotificationsRepository>(
      NotificationsRepositoryImpl());*/
}
