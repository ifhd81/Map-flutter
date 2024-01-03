import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_flutter/home/data_source/model/request/update_location_request_model.dart';
import 'package:map_flutter/home/manager/home_cubit.dart';
import 'package:map_flutter/styles/colors.dart';
import 'package:map_flutter/widgets/custom_button.dart';
import 'package:map_flutter/widgets/headline_text.dart';
import 'package:map_flutter/widgets/medium_text.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? currentPosition;
  Timer? timer;
  StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    super.initState();
    FlutterBackgroundService().invoke('setAsForeground');
    HomeCubit.get(context).getProfile().whenComplete(() {
      HomeCubit.get(context).isOnline =
          HomeCubit.get(context).profileResponseModel!.data!.isOnline ?? false;
      determinePosition().whenComplete(() {
        _getCurrentLocation();
      });
      _startLocationStream(context);
      setState(() {});
    });
  }

  @override
  void dispose() {
    positionStream
        ?.cancel(); // Cancel the location stream when the widget is disposed
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: currentPosition ?? LatLng(21.5687815, 39.1356415),
                    zoom: 20,
                  ),
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                  onCameraMove: (CameraPosition position) {
                    setState(() {});
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                ),
                Positioned(
                  bottom: 40.h,
                  left: 10.w,
                  right: 10.w,
                  child: Container(
                    width: 360.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            color: AppColor.black.withOpacity(.1),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MediumText(text: 'Hello'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HeadLineText(text: 'Aminata N’Diaye'),
                              state is GetProfileLoadingState
                                  ? CircularProgressIndicator()
                                  : MyButton(
                                      onPressed: () {
                                        HomeCubit.get(context)
                                            .changeStatusOfDriver(
                                                updateLocationRequestModel:
                                                    UpdateLocationRequestModel(
                                          lat: currentPosition!.latitude
                                              .toString(),
                                          long: currentPosition!.longitude
                                              .toString(),
                                        ));
                                        HomeCubit.get(context)
                                            .changeOnlineStatus(
                                                isOnlines:
                                                    HomeCubit.get(context)
                                                        .isOnline);
                                      },
                                      text: HomeCubit.get(context).isOnline ==
                                              true
                                          ? 'online'
                                          : "offline",
                                      isLoading: false,
                                      width: 88.w,
                                      height: 36.h,
                                      isUpper: false,
                                      color: HomeCubit.get(context).isOnline ==
                                              true
                                          ? AppColor.greenTextColor
                                          : AppColor.headlineTextColor,
                                    )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _startLocationStream(BuildContext context) {
    print('Amr is playing in code!123');
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 500,
      ),
      // Set a distance threshold for updates (e.g., 10 meters)
    ).listen((Position position) {
      if (HomeCubit.get(context).isOnline == true) {
        setState(() {
          currentPosition = LatLng(position.latitude, position.longitude);
          mapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: currentPosition!, zoom: 20)
              //17 is new zoom level
              ));
          print('User is moving! Latitude: ${position.latitude}, Longitude: ${position.longitude}');
          HomeCubit.get(context).updateLocation(
              updateLocationRequestModel: UpdateLocationRequestModel(
            lat: currentPosition!.latitude.toString(),
            long: currentPosition!.longitude.toString(),
          ));
        });
      }
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
