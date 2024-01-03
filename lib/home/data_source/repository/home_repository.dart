import 'package:dartz/dartz.dart';
import 'package:map_flutter/home/data_source/model/request/update_location_request_model.dart';
import 'package:map_flutter/home/data_source/model/response/profile_response_model.dart';
import 'package:map_flutter/home/data_source/model/response/update_location_response_model.dart';
import 'package:map_flutter/home/data_source/remote/home_data_source.dart';
import 'package:map_flutter/network_service/network_service.dart';

abstract class HomeRepository {
  late NetworkService networkService;
  late HomeDataSource homeDataSource;

  Future<Either<String, UpdateLocationResponseModel>> updateLocation({
    bool isEng = true,
    required UpdateLocationRequestModel updateLocationRequestModel
  });

  Future<Either<String, ProfileResponseModel>> changeOnlineStatus({
    bool isEng = true,
    required bool isOnline
  });

  Future<Either<String, ProfileResponseModel>> getProfile({
    bool isEng = true,
  });

}