class MainResponseModel {
  bool? status;
  String? code;
  String? message;
  MainResponseModel({
    this.status,
    this.code,
    this.message,
  });
  MainResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code']?.toString();
    message = json['message']?.toString();
  }
}
