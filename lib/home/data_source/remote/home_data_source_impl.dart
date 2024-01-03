import 'package:map_flutter/constants/end_points.dart';
import 'package:map_flutter/constants/shared_preferences_consts.dart';
import 'package:map_flutter/dio_service/dio_service.dart';
import 'package:map_flutter/home/data_source/model/request/update_location_request_model.dart';
import 'package:map_flutter/home/data_source/model/response/profile_response_model.dart';
import 'package:map_flutter/home/data_source/model/response/update_location_response_model.dart';
import 'package:map_flutter/home/data_source/remote/home_data_source.dart';
import 'package:map_flutter/utils/dio_method.dart';

class HomeDataSourceImpl implements HomeDataSource {
  @override
  DioService dioService;

  HomeDataSourceImpl({required this.dioService});

  @override
  Future<UpdateLocationResponseModel> updateLocation({required UpdateLocationRequestModel updateLocationRequestModel}) async {
    final result = await serverRequest(
      call: () async => await dioService.post(
          endPoint: updateLocationEndPoint,
          data: updateLocationRequestModel.toJson(),
          token: accessToken
      ),
    );
    final response = UpdateLocationResponseModel.fromJson(result);
    return response;
  }

  @override
  Future<ProfileResponseModel> changeOnlineStatus({required bool isOnline}) async {
    final result = await serverRequest(
      call: () async => await dioService.post(
        endPoint: changeOnlineStatusEndPoint,
        token: accessToken,
        data: {
          'is_online' : isOnline
        }
      ),
    );
    final response = ProfileResponseModel.fromJson(result);
    return response;
  }

  @override
  Future<ProfileResponseModel> getProfile() async {
    final result = await serverRequest(
      call: () async => await dioService.get(
          endPoint: getProfileEndPoint,
          token: accessToken
      ),
    );
    final response = ProfileResponseModel.fromJson(result);
    return response;
  }

  }
