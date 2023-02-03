class HttpResponseModal {
  //  Status Code - 200
  //  Response    - Data
  //  Status Code - 201 and 401
  //  Response    - No Data
  //  Status Code - 100
  //  Response    - No Internet Connectivity
  //  Status Code - 400
  //  Response    - Unknown error or catch error

  int status;
  dynamic message;

  HttpResponseModal({required this.status, required this.message});

  factory HttpResponseModal.parseHttpResponse(Map<String, dynamic> json) {
    return HttpResponseModal(status: json['status'] as int, message: json['message'] as dynamic);
  }

  Map<String, dynamic> getData() => {"status": status, "message": message};
}
