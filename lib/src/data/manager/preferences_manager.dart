import 'dart:convert';

import 'package:curate/src/data/models/LanguageResponse.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:rxdart/src/transformers/flat_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile_model.dart';

class PreferencesManager {
  static const _keyUserToken = 'keyUserToken';
  static const _UUID = 'UUID';
  static const _keyprofileImage = 'keyprofileImage';
  static const _keyUserProfile = 'keyUserProfile';
  static const _orderStatus = 'orderStatus';
  static const _keyLanguages = 'keyLanguages';
  static const keyLanguageCode = 'language_code';
  static const keyIsGuestUser = 'guest_user';
  static const keyFullName = 'name';
  static const keyWellbeingScore = 'score';
  static const keyEmail = 'email';
  static const keyUserId = 'userId';
  static const keyUserNotificationPermissionAsked =
      'keyUserNotificationPermissionAsked';
  static const keyIsFirstTimeTutorial = 'first_time_tutorial';
  static const keyIsFirstTimePopups = 'first_time_popup';

  Future<bool> isLoggedIn() async {
    final preferences = await _getPreferences();
    return preferences.containsKey(_keyUserToken) &&
        preferences.containsKey(_keyUserProfile);
  }

  Future<bool> isGuestUser() async {
    final preferences = await _getPreferences();
    return preferences.getBool(keyIsGuestUser) ?? false;
  }

  void setGuestUser(bool isGuestUser) async {
    (await _getPreferences()).setBool(keyIsGuestUser, isGuestUser);
  }

  Future<SharedPreferences> _getPreferences() async =>
      await SharedPreferences.getInstance();

  Future<String?> getUserToken() async {
    return (await _getPreferences()).getString(_keyUserToken);
  }

  Future<String?> getUUID() async {
    return (await _getPreferences()).getString(_UUID);
  }

  Future<num?> getUserId() async {
    return (await _getPreferences()).getInt(keyUserId);
  }

  Future<String?> getUserProfileIma() async {
    return (await _getPreferences()).getString(_keyprofileImage);
  }

  Future<String?> getEmail() async {
    return (await _getPreferences()).getString(keyEmail);
  }

  void setNotificationPermissionAsked(bool? notificationPermissionAsked) async {
    (await _getPreferences()).setBool(
        keyUserNotificationPermissionAsked, notificationPermissionAsked!);
  }

  Future<bool?> isNotificationPermissionAsked() async {
    return (await _getPreferences())
        .getBool(keyUserNotificationPermissionAsked);
  }

  void setUserToken(String? token) async {
    if (token == null || token.isEmpty) {
      (await _getPreferences()).remove(_keyUserToken);
    } else {
      (await _getPreferences()).setString(_keyUserToken, token);
    }
  }

  void setUUID(String? UUID) async {
    if (UUID == null || UUID.isEmpty) {
      (await _getPreferences()).remove(_UUID);
    } else {
      (await _getPreferences()).setString(_UUID, UUID);
    }
  }

  void setProfileImage(String? image) async {
    if (image == null || image.isEmpty) {
      (await _getPreferences()).remove(_keyprofileImage);
    } else {
      (await _getPreferences()).setString(_keyprofileImage, image);
    }
  }

  Future<PersonalInfo?> getUserProfile() async {
    final userJson = (await _getPreferences()).getString(_keyUserProfile);
    if (userJson == null || userJson.isEmpty) {
      return null;
    }
    try {
      final userMap = jsonDecode(userJson);
      return PersonalInfo.fromJson(userMap);
    } catch (exception) {
      return null;
    }
  }

  void setUserProfile(PersonalInfo? userProfile) async {
    if (userProfile == null) {
      (await _getPreferences()).remove(_keyUserProfile);
    } else {
      final userJson = jsonEncode(userProfile.toJson());
      (await _getPreferences()).setString(_keyUserProfile, userJson);
    }
  }

  Future<void> removeOrderData() async {
    (await _getPreferences()).remove(_orderStatus);
  }

  Future<Map<String, dynamic>?> getOrderStatus() async {
    final userJson = (await _getPreferences()).getString(_orderStatus);
    if (userJson == null || userJson.isEmpty) {
      return null;
    }
    print("orderJson");
    print(userJson);
    try {
      final userMap = jsonDecode(userJson);
      return userMap;
    } catch (exception) {
      return null;
    }
  }

  void setOrderSatatus(Map<String, dynamic>? userProfile) async {
    if (userProfile == null) {
      (await _getPreferences()).remove(_orderStatus);
    } else {
      final userJson = jsonEncode(userProfile);
      (await _getPreferences()).setString(_orderStatus, userJson);
    }
  }

  Future<LanguageResponse?> getLanguages() async {
    final languageJson = (await _getPreferences()).getString(_keyLanguages);
    if (languageJson == null || languageJson.isEmpty) {
      return null;
    }

    try {
      final userMap = jsonDecode(languageJson);
      return LanguageResponse.fromJson(userMap);
    } catch (exception) {
      return null;
    }
  }

  void setLanguages(LanguageResponse languageResponse) async {
    final userJson = jsonEncode(languageResponse.toJson());
    (await _getPreferences()).setString(_keyLanguages, userJson);
  }

  Future<String?> getWellBeingScore() async {
    try {
      return (await _getPreferences()).getString(keyWellbeingScore);
    } catch (exception) {
      return null;
    }
  }

  void setWellBeingScore(String? score) async {
    print(
        "WELLBEING SCORINGGGGGGGGGGGGGG--------------------WELLBEING SCORINGGGGGGGGGGGGGG------------WELLBEING SCORINGGGGGGGGGGGGGG----------WELLBEING SCORINGGGGGGGGGGGGGG");
    print(score ?? 0);

    if (score == null || score.isEmpty) {
      (await _getPreferences()).remove(keyWellbeingScore);
    } else {
      (await _getPreferences()).setString(keyWellbeingScore, score);
    }
  }

  Future<String?> getFullName() async {
    return (await _getPreferences()).getString(keyFullName);
  }

  void setFullName(String? name) async {
    if (name == null || name.isEmpty) {
      (await _getPreferences()).remove(keyFullName);
    } else {
      (await _getPreferences()).setString(keyFullName, name);
    }
  }

  void setEmail(String? email) async {
    if (email == null || email.isEmpty) {
      (await _getPreferences()).remove(keyEmail);
    } else {
      (await _getPreferences()).setString(keyEmail, email);
    }
  }

  void setUserId(num? userID) async {
    if (userID == null) {
      (await _getPreferences()).remove(keyUserId);
    } else {
      (await _getPreferences()).setInt(keyUserId, userID.toInt());
    }
  }

  void logout() async {
    (await _getPreferences()).clear();
  }

  Future<bool> isFirstTimeForPopup() async {
    var isFirstTime = (await _getPreferences()).getBool(keyIsFirstTimePopups);
    if (isFirstTime != null && !isFirstTime) {
      (await _getPreferences()).setBool(keyIsFirstTimePopups, false);
      return false;
    } else {
      (await _getPreferences()).setBool(keyIsFirstTimePopups, false);
      return true;
    }
  }

  void setFirstTimeForTutorials(bool isFt) async {
    (await _getPreferences()).setBool(keyIsFirstTimeTutorial, isFt);
  }

  Future<bool> isFirstTimeForTutorials() async {
    return (await _getPreferences()).getBool(keyIsFirstTimeTutorial) ?? true;
  }

  /* Future<UserDto?> getUserProfile() async {
    final userJson = (await _getPreferences()).getString(_keyUserProfile);
    if (userJson == null || userJson.isEmpty) {
      return null;
    }

    try {
      final userMap = jsonDecode(userJson);
      return UserDto.fromJson(userMap);
    } catch (exception) {
      return null;
    }
  }

  void setUserProfile(UserDto? user) async {
    if (user == null) {
      (await _getPreferences()).remove(_keyUserProfile);
    } else {
      final userJson = jsonEncode(user.toJson());
      (await _getPreferences()).setString(_keyUserProfile, userJson);
    }
  }*/

  /// Get [String] from the [SharedPreferences]
  Stream<String?> getString(String key) {
    return _getSharedPreference()
        .map((preference) => preference.getString(key));
  }

  /// Set [String] to the [SharedPreferences]
  Stream<bool> setString(String key, String value) {
    return _getSharedPreference().flatMap(
        (preference) => _convertToRx(preference.setString(key, value)));
  }

  Stream<SharedPreferences> _getSharedPreference() {
    return _convertToRx(_getPreferences());
  }

  Stream<T> _convertToRx<T>(Future<T> future) {
    return future.asStream();
  }
}
