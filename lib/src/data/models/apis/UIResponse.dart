

class UIResponse<T> {
  Status status = Status.LOADING;
  T? data;
  String message = '';

  UIResponse.none() : status = Status.NONE;
  UIResponse.loading() : status = Status.LOADING;
  UIResponse.completed(this.data) : status = Status.COMPLETED;
  UIResponse.error(this.message) : status = Status.ERROR;



  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { NONE,LOADING, COMPLETED, ERROR }