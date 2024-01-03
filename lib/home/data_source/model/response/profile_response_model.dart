class ProfileResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ProfileResponseModel({this.success, this.message, this.data, this.code});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }
}

class Data {
  int? id;
  String? name;
  String? phone;
  String? fcmToken;
  String? deviceType;
  String? currentLocationId;
  bool? isOnline;
  String? token;


  Data(
      {this.id,
        this.name,
        this.phone,
        this.fcmToken,
        this.deviceType,
        this.currentLocationId,
        this.isOnline,
        this.token
});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    fcmToken = json['fcm_token'];
    deviceType = json['device_type'];
    currentLocationId = json['current_location_id'];
    isOnline = json['is_online'];
    token = json['token'];
  }
}




