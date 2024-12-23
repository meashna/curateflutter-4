/*class ApiUtils {
  ApiUtils._();

  static ApiError getApiError(DioError error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    if (response != null) {
      final data = response.data;
      if (data != null) {
        return ApiError.fromJson(data, statusCode);
      } else {
        return ApiError(statusCode: statusCode);
      }
    } else {
      return ApiError.fromMessage(error.message, statusCode);
    }
  }
}*/
