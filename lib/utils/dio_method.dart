import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:map_flutter/constants/error_messages.dart';
import 'package:map_flutter/exceptions/server_exception.dart';

Future serverRequest({
  required Future<Response> Function() call,
}) async {
  try {
    final r = await call.call();
    debugPrint("Response_Data => ${r.data}");
    debugPrint("Response_Code => ${r.statusCode}");

    if (r.data['data'] == null || r.data['status'] == false) {
      throw const ServerException(
        enMessage: Server_Request_En_Error,
        arMessage: Server_Request_Ar_Error,
      );
    }

    return r.data;
  } on DioError catch (e) {

    debugPrint("Error_Message => ${e.message}");
    debugPrint("Error_Error => ${e.error.toString()}");
    debugPrint("Error_Type => ${e.type.toString()}");

    throw const ServerException(
      enMessage: Server_Request_En_Error,
      arMessage: Server_Request_Ar_Error,
    );
  }
}
