import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_flutter/di/injection_container.dart';
import 'package:map_flutter/home/data_source/model/request/update_location_request_model.dart';
import 'package:map_flutter/home/data_source/model/response/profile_response_model.dart';
import 'package:map_flutter/home/data_source/model/response/update_location_response_model.dart';
import 'package:map_flutter/home/data_source/repository/home_repository.dart';
import 'package:map_flutter/shared_preferences/preference_helper.dart';
import 'package:map_flutter/widgets/toast.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository}) : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  UpdateLocationResponseModel? updateLocationResponseModel;
  ProfileResponseModel? profileResponseModel ;

  bool isOnline = false ;
  bool isConfirmedSelected = false ;

  PreferenceHelper preferenceHelper = PreferenceHelper(preferencesProvider: serviceLocator());

  void changeEmit(){
    emit(ChangeStatusOfDriverToOnlineState());
  }

  Future updateLocation(
      {required UpdateLocationRequestModel updateLocationRequestModel}) async {
    emit(UpdateLocationLoadingState());
    final result = await homeRepository.updateLocation(
        updateLocationRequestModel: updateLocationRequestModel);
    result.fold(
      (l) {
        emit(UpdateLocationErrorState());
        showToast(text: l, state: ToastStates.ERROR);
      },
      (r) {
        updateLocationResponseModel = r;
        showToast(text: 'send location to server', state: ToastStates.SUCCESS);
        emit(UpdateLocationSuccessState());
      },
    );
  }


  Future changeOnlineStatus({required bool isOnlines}) async {
    emit(ChangeOnlineStatusLoadingState());
    final result = await homeRepository.changeOnlineStatus(isOnline: isOnlines);
    result.fold(
      (l) {
        emit(ChangeOnlineStatusErrorState());
        showToast(text: l, state: ToastStates.ERROR);
      },
      (r) {
        emit(ChangeOnlineStatusSuccessState());
      },
    );
  }

  Future<void> changeStatusOfDriver ({required UpdateLocationRequestModel updateLocationRequestModel})async{
    isOnline =!isOnline ;
    if(isOnline) {
      changeOnlineStatus(isOnlines: true).whenComplete(() {
        updateLocation(updateLocationRequestModel: updateLocationRequestModel);
        emit(ChangeStatusOfDriverToOnlineState());
      });

    }
    if(!isOnline) {
      changeOnlineStatus(isOnlines: false);
      emit(ChangeStatusOfDriverToOfflineState());
    }
    getProfile();
  }


  Future getProfile() async {
    emit(GetProfileLoadingState());
    final result = await homeRepository.getProfile();
    result.fold(
          (l) {
        emit(GetProfileErrorState());
        showToast(text: l, state: ToastStates.ERROR);
      },
          (r) {
        profileResponseModel = r ;
        emit(GetProfileSuccessState());
      },
    );
  }



}
