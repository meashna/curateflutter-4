class OTPScreenState {
  final bool isLoading;
  final String? status;
  final String error;
  final String? message;
  final bool isError;
  final bool isCompleted;
  final bool isDataLoaded;
  final bool isConpanionLoaded;
  final bool isConpanionLoading;
  final bool isNoInternet;

  OTPScreenState({
    this.isLoading = false,
    this.status = "",
    this.error = "",
    this.message = "",
    this.isCompleted = false,
    this.isConpanionLoaded = false,
    this.isConpanionLoading = false,
    this.isDataLoaded = false,
    this.isError = false,
    this.isNoInternet = false,
  });
}