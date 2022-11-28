// To parse this JSON data, do
//
//     final postDetailPayload = postDetailPayloadFromJson(jsonString);

import 'dart:convert';

PostDetailPayload postDetailPayloadFromJson(String str) => PostDetailPayload.fromJson(json.decode(str));

String postDetailPayloadToJson(PostDetailPayload data) => json.encode(data.toJson());

class PostDetailPayload {
  PostDetailPayload({
    this.nextPage,
    this.requestTime,
    this.nextPageSugg,
    this.mode,
    this.groupId,
  });

  int? nextPage;
  int? requestTime;
  int? nextPageSugg;
  int? mode;
  int? groupId;

  factory PostDetailPayload.fromJson(Map<String, dynamic> json) => PostDetailPayload(
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    requestTime: json["requestTime"] == null ? null : json["requestTime"],
    nextPageSugg: json["nextPageSugg"] == null ? null : json["nextPageSugg"],
    mode: json["mode"] == null ? null : json["mode"],
    groupId: json["groupId"] == null ? null : json["groupId"],
  );

  Map<String, dynamic> toJson() => {
    "nextPage": nextPage == null ? null : nextPage,
    "requestTime": requestTime == null ? null : requestTime,
    "nextPageSugg": nextPageSugg == null ? null : nextPageSugg,
    "mode": mode == null ? null : mode,
    "groupId": groupId == null ? null : groupId,
  };
}
