
enum ApiStatus { success, error }

class ApiResponse<T> {
  ApiStatus status;
  String? error;
  String? message;
  T? data;

  ApiResponse({required this.status, this.error, this.data,this.message});

  ApiResponse.success({this.status = ApiStatus.success, this.data,this.message});

  ApiResponse.error({this.status = ApiStatus.error, this.error});
}
