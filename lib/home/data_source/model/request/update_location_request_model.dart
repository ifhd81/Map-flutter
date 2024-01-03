class UpdateLocationRequestModel {
  String? lat, long;

  UpdateLocationRequestModel({
    this.lat,
    this.long,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = long;
    return data;
  }
}
