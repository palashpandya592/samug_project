// To parse this JSON data, do
//
//     final postDetailModel = postDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:video_player/video_player.dart';

PostDetailModel postDetailModelFromJson(String str) => PostDetailModel.fromJson(json.decode(str));

String postDetailModelToJson(PostDetailModel data) => json.encode(data.toJson());

class PostDetailModel {
  PostDetailModel({
    this.data,
    this.status,
    this.success,
  });

  Data? data;
  Status? status;
  bool? success;

  factory PostDetailModel.fromJson(Map<String, dynamic> json) => PostDetailModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "status": status == null ? null : status!.toJson(),
    "success": success == null ? null : success,
  };
}

class Data {
  Data({
    this.cdnUrl,
    this.cdnUrlEmbd,
    this.fileUrlPrefix,
    this.hlsStatus,
    this.nextPage,
    this.nextPageSugg,
    this.postDetails,
    this.postGroup,
    this.requestTime,
    this.totalPost,
  });

  String? cdnUrl;
  String? cdnUrlEmbd;
  String? fileUrlPrefix;
  String? hlsStatus;
  int? nextPage;
  int? nextPageSugg;
  List<PostDetail>? postDetails;
  List<PostGroup>? postGroup;
  String? requestTime;
  int? totalPost;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cdnUrl: json["cdnUrl"] == null ? null : json["cdnUrl"],
    cdnUrlEmbd: json["cdnUrlEmbd"] == null ? null : json["cdnUrlEmbd"],
    fileUrlPrefix: json["fileUrlPrefix"] == null ? null : json["fileUrlPrefix"],
    hlsStatus: json["hlsStatus"] == null ? null : json["hlsStatus"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    nextPageSugg: json["nextPageSugg"] == null ? null : json["nextPageSugg"],
    postDetails: json["postDetails"] == null ? null : List<PostDetail>.from(json["postDetails"].map((x) => PostDetail.fromJson(x))),
    postGroup: json["postGroup"] == null ? null : List<PostGroup>.from(json["postGroup"].map((x) => PostGroup.fromJson(x))),
    requestTime: json["requestTime"] == null ? null : json["requestTime"],
    totalPost: json["totalPost"] == null ? null : json["totalPost"],
  );

  Map<String, dynamic> toJson() => {
    "cdnUrl": cdnUrl == null ? null : cdnUrl,
    "cdnUrlEmbd": cdnUrlEmbd == null ? null : cdnUrlEmbd,
    "fileUrlPrefix": fileUrlPrefix == null ? null : fileUrlPrefix,
    "hlsStatus": hlsStatus == null ? null : hlsStatus,
    "nextPage": nextPage == null ? null : nextPage,
    "nextPageSugg": nextPageSugg == null ? null : nextPageSugg,
    "postDetails": postDetails == null ? null : List<dynamic>.from(postDetails!.map((x) => x.toJson())),
    "postGroup": postGroup == null ? null : List<dynamic>.from(postGroup!.map((x) => x.toJson())),
    "requestTime": requestTime == null ? null : requestTime,
    "totalPost": totalPost == null ? null : totalPost,
  };
}

class PostDetail {
  PostDetail({
    this.accountId,
    this.displayName,
    this.followStatus,
    this.fullName,
    this.id,
    this.postDetails,
    this.profileImage,
    this.suggestionMode,
    this.userLikeStatus,
    this.watchStatus,
    this.zamugDisplayName,
    this.zamugId,
    this.zamugImage,
    this.zamugName,
  });

  String? accountId;
  String? displayName;
  String? followStatus;
  String? fullName;
  String? id;
  PostDetails? postDetails;
  String? profileImage;
  String? suggestionMode;
  String? userLikeStatus;
  String? watchStatus;
  String? zamugDisplayName;
  String? zamugId;
  String? zamugImage;
  String? zamugName;

  factory PostDetail.fromJson(Map<String, dynamic> json) => PostDetail(
    accountId: json["accountId"] == null ? null : json["accountId"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    followStatus: json["followStatus"] == null ? null : json["followStatus"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    id: json["id"] == null ? null : json["id"],
    postDetails: json["postDetails"] == null ? null : PostDetails.fromJson(json["postDetails"]),
    profileImage: json["profileImage"] == null ? null : json["profileImage"],
    suggestionMode: json["suggestionMode"] == null ? null : json["suggestionMode"],
    userLikeStatus: json["userLikeStatus"] == null ? null : json["userLikeStatus"],
    watchStatus: json["watchStatus"] == null ? null : json["watchStatus"],
    zamugDisplayName: json["zamugDisplayName"] == null ? null : json["zamugDisplayName"],
    zamugId: json["zamugId"] == null ? null : json["zamugId"],
    zamugImage: json["zamugImage"] == null ? null : json["zamugImage"],
    zamugName: json["zamugName"] == null ? null : json["zamugName"],
  );

  Map<String, dynamic> toJson() => {
    "accountId": accountId == null ? null : accountId,
    "displayName": displayName == null ? null : displayName,
    "followStatus": followStatus == null ? null : followStatus,
    "fullName": fullName == null ? null : fullName,
    "id": id == null ? null : id,
    "postDetails": postDetails == null ? null : postDetails!.toJson(),
    "profileImage": profileImage == null ? null : profileImage,
    "suggestionMode": suggestionMode == null ? null : suggestionMode,
    "userLikeStatus": userLikeStatus == null ? null : userLikeStatus,
    "watchStatus": watchStatus == null ? null : watchStatus,
    "zamugDisplayName": zamugDisplayName == null ? null : zamugDisplayName,
    "zamugId": zamugId == null ? null : zamugId,
    "zamugImage": zamugImage == null ? null : zamugImage,
    "zamugName": zamugName == null ? null : zamugName,
  };
}

class PostDetails {
  PostDetails({
    this.id,
    this.accountId,
    this.accountType,
    this.countryId,
    this.latitude,
    this.longitude,
    this.postCommentsCount,
    this.postDetails,
    this.postDhan,
    this.postDhanCount,
    this.postDislikes,
    this.postExclusiveTag,
    this.postLanguage,
    this.postLastUpdate,
    this.postLikes,
    this.postMetadata,
    this.postPersonalTag,
    this.postRewards,
    this.postSnapshoot,
    this.postThumbnail,
    this.postTimestamp,
    this.postTrendingTag,
    this.postType,
    this.postVisibility,
    this.postZamugTag,
    this.postadminRemarks,
    this.postcreatedDate,
    this.postfiles,
    this.poststatus,
    this.shareCount,
    this.shareOtherCount,
    this.sharedBy,
    this.transcodeDetails,
    this.transcodeUid,
    this.viewCount, required controller,
  });

  String? id;
  int? accountId;
  int? accountType;
  int? countryId;
  double? latitude;
  double? longitude;
  int? postCommentsCount;
  String? postDetails;
  List<PostDhan>? postDhan;
  int? postDhanCount;
  int? postDislikes;
  dynamic postExclusiveTag;
  List<String>? postLanguage;
  String? postLastUpdate;
  int? postLikes;
  String? postMetadata;
  dynamic postPersonalTag;
  int? postRewards;
  String? postSnapshoot;
  List<dynamic>? postThumbnail;
  String? postTimestamp;
  List<String>? postTrendingTag;
  int? postType;
  int? postVisibility;
  List<PostZamugTag>? postZamugTag;
  List<dynamic>? postadminRemarks;
  DateTime? postcreatedDate;
  List<String>? postfiles;
  int? poststatus;
  int? shareCount;
  int? shareOtherCount;
  int? sharedBy;
  String? transcodeDetails;
  String? transcodeUid;
  int? viewCount;
  VideoPlayerController? controller;

  factory PostDetails.fromJson(Map<String, dynamic> json) => PostDetails(
    id: json["_id"] == null ? null : json["_id"],
    accountId: json["accountId"] == null ? null : json["accountId"],
    accountType: json["accountType"] == null ? null : json["accountType"],
    countryId: json["countryId"] == null ? null : json["countryId"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    postCommentsCount: json["postCommentsCount"] == null ? null : json["postCommentsCount"],
    postDetails: json["postDetails"] == null ? null : json["postDetails"],
    postDhan: json["postDhan"] == null ? null : List<PostDhan>.from(json["postDhan"].map((x) => PostDhan.fromJson(x))),
    postDhanCount: json["postDhanCount"] == null ? null : json["postDhanCount"],
    postDislikes: json["postDislikes"] == null ? null : json["postDislikes"],
    postExclusiveTag: json["postExclusiveTag"],
    postLanguage: json["postLanguage"] == null ? null : List<String>.from(json["postLanguage"].map((x) => x)),
    postLastUpdate: json["postLastUpdate"] == null ? null : json["postLastUpdate"],
    postLikes: json["postLikes"] == null ? null : json["postLikes"],
    postMetadata: json["postMetadata"] == null ? null : json["postMetadata"],
    postPersonalTag: json["postPersonalTag"],
    postRewards: json["postRewards"] == null ? null : json["postRewards"],
    postSnapshoot: json["postSnapshoot"] == null ? null : json["postSnapshoot"],
    postThumbnail: json["postThumbnail"] == null ? null : List<dynamic>.from(json["postThumbnail"].map((x) => x)),
    postTimestamp: json["postTimestamp"] == null ? null : json["postTimestamp"],
    postTrendingTag: json["postTrendingTag"] == null ? null : List<String>.from(json["postTrendingTag"].map((x) => x)),
    postType: json["postType"] == null ? null : json["postType"],
    postVisibility: json["postVisibility"] == null ? null : json["postVisibility"],
    postZamugTag: json["postZamugTag"] == null ? null : List<PostZamugTag>.from(json["postZamugTag"].map((x) => PostZamugTag.fromJson(x))),
    postadminRemarks: json["postadminRemarks"] == null ? null : List<dynamic>.from(json["postadminRemarks"].map((x) => x)),
    postcreatedDate: json["postcreatedDate"] == null ? null : DateTime.parse(json["postcreatedDate"]),
    postfiles: json["postfiles"] == null ? null : List<String>.from(json["postfiles"].map((x) => x)),
    poststatus: json["poststatus"] == null ? null : json["poststatus"],
    shareCount: json["shareCount"] == null ? null : json["shareCount"],
    shareOtherCount: json["shareOtherCount"] == null ? null : json["shareOtherCount"],
    sharedBy: json["sharedBy"] == null ? null : json["sharedBy"],
    transcodeDetails: json["transcodeDetails"] == null ? null : json["transcodeDetails"],
    transcodeUid: json["transcodeUid"] == null ? null : json["transcodeUid"],
    viewCount: json["viewCount"] == null ? null : json["viewCount"],
    controller: json["controller"] == null ? null : json["controller"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "accountId": accountId == null ? null : accountId,
    "accountType": accountType == null ? null : accountType,
    "countryId": countryId == null ? null : countryId,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "postCommentsCount": postCommentsCount == null ? null : postCommentsCount,
    "postDetails": postDetails == null ? null : postDetails,
    "postDhan": postDhan == null ? null : List<dynamic>.from(postDhan!.map((x) => x.toJson())),
    "postDhanCount": postDhanCount == null ? null : postDhanCount,
    "postDislikes": postDislikes == null ? null : postDislikes,
    "postExclusiveTag": postExclusiveTag,
    "postLanguage": postLanguage == null ? null : List<dynamic>.from(postLanguage!.map((x) => x)),
    "postLastUpdate": postLastUpdate == null ? null : postLastUpdate,
    "postLikes": postLikes == null ? null : postLikes,
    "postMetadata": postMetadata == null ? null : postMetadata,
    "postPersonalTag": postPersonalTag,
    "postRewards": postRewards == null ? null : postRewards,
    "postSnapshoot": postSnapshoot == null ? null : postSnapshoot,
    "postThumbnail": postThumbnail == null ? null : List<dynamic>.from(postThumbnail!.map((x) => x)),
    "postTimestamp": postTimestamp == null ? null : postTimestamp,
    "postTrendingTag": postTrendingTag == null ? null : List<dynamic>.from(postTrendingTag!.map((x) => x)),
    "postType": postType == null ? null : postType,
    "postVisibility": postVisibility == null ? null : postVisibility,
    "postZamugTag": postZamugTag == null ? null : List<dynamic>.from(postZamugTag!.map((x) => x.toJson())),
    "postadminRemarks": postadminRemarks == null ? null : List<dynamic>.from(postadminRemarks!.map((x) => x)),
    "postcreatedDate": postcreatedDate == null ? null : "${postcreatedDate!.year.toString().padLeft(4, '0')}-${postcreatedDate!.month.toString().padLeft(2, '0')}-${postcreatedDate!.day.toString().padLeft(2, '0')}",
    "postfiles": postfiles == null ? null : List<dynamic>.from(postfiles!.map((x) => x)),
    "poststatus": poststatus == null ? null : poststatus,
    "shareCount": shareCount == null ? null : shareCount,
    "shareOtherCount": shareOtherCount == null ? null : shareOtherCount,
    "sharedBy": sharedBy == null ? null : sharedBy,
    "transcodeDetails": transcodeDetails == null ? null : transcodeDetails,
    "transcodeUid": transcodeUid == null ? null : transcodeUid,
    "viewCount": viewCount == null ? null : viewCount,
    "controller": controller == null ? null : controller,
  };
}

class PostDhan {
  PostDhan({
    this.dhanCount,
    this.dhanType,
  });

  int? dhanCount;
  int? dhanType;

  factory PostDhan.fromJson(Map<String, dynamic> json) => PostDhan(
    dhanCount: json["dhanCount"] == null ? null : json["dhanCount"],
    dhanType: json["dhanType"] == null ? null : json["dhanType"],
  );

  Map<String, dynamic> toJson() => {
    "dhanCount": dhanCount == null ? null : dhanCount,
    "dhanType": dhanType == null ? null : dhanType,
  };
}

class PostZamugTag {
  PostZamugTag({
    this.tagId,
    this.tagName,
  });

  String? tagId;
  String? tagName;

  factory PostZamugTag.fromJson(Map<String, dynamic> json) => PostZamugTag(
    tagId: json["tagId"] == null ? null : json["tagId"],
    tagName: json["tagName"] == null ? null : json["tagName"],
  );

  Map<String, dynamic> toJson() => {
    "tagId": tagId == null ? null : tagId,
    "tagName": tagName == null ? null : tagName,
  };
}

class PostGroup {
  PostGroup({
    this.uid,
    this.groupName,
    this.groupMode,
    this.imageType,
    this.imagePath,
    this.orderId,
    this.status,
    this.createdId,
    this.createdDate,
  });

  int? uid;
  String? groupName;
  String? groupMode;
  String? imageType;
  String? imagePath;
  String? orderId;
  String? status;
  String? createdId;
  String? createdDate;

  factory PostGroup.fromJson(Map<String, dynamic> json) => PostGroup(
    uid: json["uid"] == null ? null : json["uid"],
    groupName: json["groupName"] == null ? null : json["groupName"],
    groupMode: json["groupMode"] == null ? null : json["groupMode"],
    imageType: json["imageType"] == null ? null : json["imageType"],
    imagePath: json["imagePath"] == null ? null : json["imagePath"],
    orderId: json["orderId"] == null ? null : json["orderId"],
    status: json["status"] == null ? null : json["status"],
    createdId: json["createdId"] == null ? null : json["createdId"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid == null ? null : uid,
    "groupName": groupName == null ? null : groupName,
    "groupMode": groupMode == null ? null : groupMode,
    "imageType": imageType == null ? null : imageType,
    "imagePath": imagePath == null ? null : imagePath,
    "orderId": orderId == null ? null : orderId,
    "status": status == null ? null : status,
    "createdId": createdId == null ? null : createdId,
    "createdDate": createdDate == null ? null : createdDate,
  };
}

class Status {
  Status({
    this.code,
    this.message,
  });

  String? code;
  String? message;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
