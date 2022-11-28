import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:samug_project/model/post_detail_model.dart';
import 'package:samug_project/model/post_detail_payload.dart';

class ApiService {
  Dio dio = Dio();

  @override
  Future<PostDetailModel?> postDetailApi(
      {PostDetailPayload? postDetailPayload}) async {
    try {
      var data = postDetailPayload!.toJson();
      var response = await dio.post('https://apiv2.samug.com/v1/dash/usrDash',
          data: data,
          options: Options(
            headers: {
              "disableEncryption": true,
              "Content-Type": "application/json",
              "authorization":
                  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50SWQiOiIiLCJhdXRob3JpemVkIjp0cnVlLCJsb2dpblRva2VuIjoiTkswMlhDVDBKWlNSMk42N0NaOFMzRk9HQ1I5UFNDRUgiLCJyZWdpc3RyYXRpb25JZCI6IjEiLCJ1c2VySWQiOiI1In0.dscfc84TkltzQeRoepdp8cFVBldXHRv4Iuk4xoH3K2M",
            },
          ));
      return PostDetailModel.fromJson(response.data);
    } catch (e) {
      print("error $e");
    }

  }
}
