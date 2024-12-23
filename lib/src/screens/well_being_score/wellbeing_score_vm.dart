import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/data/repository/user_repo/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class WellbeingScoreVM extends ChangeNotifier{
  WellbeingScoreVM();



  final _preferences = GetIt.I<PreferencesManager>();
  final _myRepo = UserRepositoryImpl();

  Future<String?> getWellbeingScore()  {
    return _preferences.getWellBeingScore();
  }












}