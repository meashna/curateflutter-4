
class ApiError {
  /*final ErrorDto? errors;
  final int? statusCode;

  ApiError({this.errors, this.statusCode});

  factory ApiError.fromMessage(String message, int? statusCode) {
    return ApiError(errors: ErrorDto(error: message), statusCode: statusCode);
  }

  factory ApiError.fromJson(Map<String, dynamic> json, int? statusCode) {
    json['statusCode'] = statusCode;
    return _$ApiErrorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  String? getFirstError() {
    final email = getFirstErrorFromList(errors?.email);
    if (email != null) return email;

    final password = getFirstErrorFromList(errors?.password);
    if (password != null) return password;

    final deviceType = getFirstErrorFromList(errors?.deviceType);
    if (deviceType != null) return deviceType;

    final deviceId = getFirstErrorFromList(errors?.deviceId);
    if (deviceId != null) return deviceId;

    final token = getFirstErrorFromList(errors?.token);
    if (token != null) return token;

    final version = getFirstErrorFromList(errors?.version);
    if (version != null) return version;

    final user = getFirstErrorFromList(errors?.user);
    if (user != null) return user;

    final oldPassword = getFirstErrorFromList(errors?.oldPassword);
    if (oldPassword != null) return oldPassword;

    final newPassword = getFirstErrorFromList(errors?.newPassword);
    if (newPassword != null) return newPassword;

    final confirmPassword = getFirstErrorFromList(errors?.confirmPassword);
    if (confirmPassword != null) return confirmPassword;

    final googleId = getFirstErrorFromList(errors?.googleId);
    if (googleId != null) return googleId;

    final name = getFirstErrorFromList(errors?.name);
    if (name != null) return name;

    final code = getFirstErrorFromList(errors?.code);
    if (code != null) return code;

    final username = getFirstErrorFromList(errors?.username);
    if (username != null) return username;

    final couponCode = getFirstErrorFromList(errors?.couponCode);
    if (couponCode != null) return couponCode;

    final courseId = getFirstErrorFromList(errors?.courseId);
    if (courseId != null) return courseId;

    final error = errors?.error;
    if (error != null) return error;

    return null;
  }

  String? getFirstErrorFromList(List<String>? error) {
    if (error == null || error.isEmpty) return null;
    return error.first;
  }

  bool isUnauthenticated() => statusCode == 401;*/
}