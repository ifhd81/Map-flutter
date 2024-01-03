
class UpdateLocationResponseModelData {


  String? lat;
  String? lng;
  int? driverId;
  String? updatedAt;
  String? createdAt;
  int? id;

  UpdateLocationResponseModelData({
    this.lat,
    this.lng,
    this.driverId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });
  UpdateLocationResponseModelData.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toString();
    lng = json['lng']?.toString();
    driverId = json['driver_id']?.toInt();
    updatedAt = json['updated_at']?.toString();
    createdAt = json['created_at']?.toString();
    id = json['id']?.toInt();
  }

}

class UpdateLocationResponseModel {


  bool? success;
  String? message;
  UpdateLocationResponseModelData? data;
  int? code;

  UpdateLocationResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });
  UpdateLocationResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? UpdateLocationResponseModelData.fromJson(json['data']) : null;
    code = json['code']?.toInt();
  }

}
