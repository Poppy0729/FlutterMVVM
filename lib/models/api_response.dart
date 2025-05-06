class APIResponse {
  int? statusCode;
  String? message;
  dynamic object;
  bool isSuccess = false;
  String? code;

  APIResponse({
    this.statusCode,
    this.message,
    this.object,
    this.isSuccess = false,
    this.code
  });
}