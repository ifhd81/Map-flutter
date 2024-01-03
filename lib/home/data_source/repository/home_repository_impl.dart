import 'package:dartz/dartz.dart';
import 'package:map_flutter/constants/error_messages.dart';
import 'package:map_flutter/exceptions/network_exception.dart';
import 'package:map_flutter/exceptions/server_exception.dart';
import 'package:map_flutter/home/data_source/model/request/update_location_request_model.dart';
import 'package:map_flutter/home/data_source/model/response/profile_response_model.dart';
import 'package:map_flutter/home/data_source/model/response/update_location_response_model.dart';
import 'package:map_flutter/home/data_source/remote/home_data_source.dart';
import 'package:map_flutter/network_service/network_service.dart';

import 'home_repository.dart';



class HomeRepositoryImpl implements HomeRepository {
  @override
  HomeDataSource homeDataSource;
  @override
  NetworkService networkService;

  HomeRepositoryImpl({
    required this.homeDataSource,
    required this.networkService,
  });

  @override
  Future<Either<String, UpdateLocationResponseModel>> updateLocation({bool isEng = true, required UpdateLocationRequestModel updateLocationRequestModel}) async {
    try {
      final connected = await networkService.isConnected;
      if (!connected) {
        throw const NetworkException(
          arMessage: Network_Connection_Ar_Error,
          enMessage: Network_Connection_En_Error,
        );
      }
      final result = await homeDataSource.updateLocation(updateLocationRequestModel:updateLocationRequestModel);
      return Right(result);
    } on ServerException catch (e) {
      return Left(isEng ? e.enMessage : e.arMessage);
    } on NetworkException catch (e) {
      return Left(isEng ? e.enMessage : e.arMessage);
    }
  }

  @override
  Future<Either<String, ProfileResponseModel>> changeOnlineStatus({bool isEng = true, required bool isOnline}) async {
    try {
      final connected = await networkService.isConnected;
      if (!connected) {
        throw const NetworkException(
          arMessage: Network_Connection_Ar_Error,
          enMessage: Network_Connection_En_Error,
        );
      }
      final result = await homeDataSource.changeOnlineStatus(isOnline: isOnline);
      return Right(result);
    } on ServerException catch (e) {
      return Left(isEng ? e.enMessage : e.arMessage);
    } on NetworkException catch (e) {
      return Left(isEng ? e.enMessage : e.arMessage);
    }
  }

  @override
  Future<Either<String, ProfileResponseModel>> getProfile({bool isEng = true}) async {
    try {
      final connected = await networkService.isConnected;
      if (!connected) {
        throw const NetworkException(
          arMessage: Network_Connection_Ar_Error,
          enMessage: Network_Connection_En_Error,
        );
      }
      final result = await homeDataSource.getProfile();
      return Right(result);
    } on ServerException catch (e) {
      return Left(isEng ? e.enMessage : e.arMessage);
    } on NetworkException catch (e) {
      return Left(isEng ? e.enMessage : e.arMessage);
    }
  }


}