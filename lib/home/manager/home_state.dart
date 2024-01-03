part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class UpdateLocationLoadingState extends HomeState {}
class UpdateLocationErrorState extends HomeState {}
class UpdateLocationSuccessState extends HomeState {}

class ChangeOnlineStatusLoadingState extends HomeState {}
class ChangeOnlineStatusErrorState extends HomeState {}
class ChangeOnlineStatusSuccessState extends HomeState {}

class GetProfileLoadingState extends HomeState {}
class GetProfileSuccessState extends HomeState {}
class GetProfileErrorState extends HomeState {}

class ChangeStatusOfDriverToOnlineState extends HomeState {}
class ChangeStatusOfDriverToOfflineState extends HomeState {}

class ChangeOnlineButtonSuccessState extends HomeState {}
