

import 'package:map_flutter/dio_service/dio_service.dart';
import 'package:map_flutter/home/data_source/model/request/update_location_request_model.dart';
import 'package:map_flutter/home/data_source/model/response/profile_response_model.dart';
import 'package:map_flutter/home/data_source/model/response/update_location_response_model.dart';

abstract class HomeDataSource {
  late DioService dioService;

  Future<UpdateLocationResponseModel> updateLocation(
      {required UpdateLocationRequestModel updateLocationRequestModel});



  Future<ProfileResponseModel> changeOnlineStatus({required bool isOnline});

  Future<ProfileResponseModel> getProfile();


}
