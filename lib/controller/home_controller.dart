import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samug_project/model/post_detail_model.dart';
import 'package:samug_project/model/post_detail_payload.dart';
import 'package:samug_project/service/api_service_class.dart';
import 'package:video_player/video_player.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:samug_project/ui/video_player.dart';
import 'package:rxdart/rxdart.dart' as r;

class HomeController extends GetxController {
  String? isPicture = '';
  VideoPlayerController? controller;
  final player = AudioPlayer();
  bool finishedPlaying = false;
  PostDetailModel postDetailModel = PostDetailModel();
  bool isLoading = false;
  int groupId = 1;

  @override
  Future<void> onInit() async {
    getData(nextPage: 0, nextPageSugg: 0);

    ///video player
    controller = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4')
      ..initialize().then((_) {
        update();
      });
    controller!.addListener(() {
      finishedPlaying = true;
      update();
    });

    ///audio player
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(
          "https://file-examples.com/storage/fe4b6a81a0637fef794ccfe/2017/11/file_example_MP3_5MG.mp3")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    super.onInit();
  }

  getData({required int nextPage, required int nextPageSugg, int? groupID}) {
    groupId = groupID ?? 1;
    postDetailModel = PostDetailModel();
    update();
    getPostDetailData(
        postDetailPayload: PostDetailPayload(
      nextPage: nextPage,
      requestTime: 0,
      nextPageSugg: nextPageSugg,
      mode: 1,
      groupId: groupID ?? 1,
    ));
  }

  getMoreDataData({required int nextPage, required int nextPageSugg, int? groupID}) {
    groupId = groupID ?? 1;
    getPostDetailData(
        postDetailPayload: PostDetailPayload(
          nextPage: nextPage,
          requestTime: 0,
          nextPageSugg: nextPageSugg,
          mode: 1,
          groupId: groupID ?? 1,
        ));
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.stop();
    }
  }

  Stream<PositionData> get positionDataStream =>
      r.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  getPostDetailData({PostDetailPayload? postDetailPayload}) async {
    PostDetailModel getPostDetailModel = PostDetailModel();
    getPostDetailModel = (await ApiService()
        .postDetailApi(postDetailPayload: postDetailPayload))!;
    if (postDetailModel.data == null) {
      postDetailModel = getPostDetailModel;
    } else {
      List<PostDetail>? postDetails = postDetailModel.data!.postDetails;
      getPostDetailModel.data!.postDetails = [
        ...postDetails!,
        ...getPostDetailModel.data!.postDetails ?? []
      ];
      postDetailModel = getPostDetailModel;
    }
    update();
    //return postDetailModel;
  }
}
