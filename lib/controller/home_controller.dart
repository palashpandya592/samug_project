import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as r;
import 'package:samug_project/model/post_detail_model.dart';
import 'package:samug_project/model/post_detail_payload.dart';
import 'package:samug_project/service/api_service_class.dart';
import 'package:samug_project/ui/video_player.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  String? isPicture = '';
  VideoPlayerController? controller;
  final player = AudioPlayer();
  bool finishedPlaying = false;
  List<PostDetail> postDetailsList = [];
  PostDetailModel? postDetailModel;
  PostDetailModel? fake;

  bool isFirstLoadRunning = false;

  ScrollController scrollController = ScrollController();
  ScrollController postScrollController = ScrollController();

  // bool isLoadMoreRunning = false;

  bool _isLoadMoreRunning = false;
  bool get isLoadMoreRunning => _isLoadMoreRunning;
  set isLoadMoreRunning(value) {
    _isLoadMoreRunning = value;
  }

  bool hasNextPage = true;

  DateTime date1 = DateTime.now();
  DateTime? date2;
  int? dayDuration;
  int? minutesDuration;

  @override
  Future<void> onInit() async {
    await getPostDetailData(
        postDetailPayload: PostDetailPayload(
      nextPage: 0,
      requestTime: 0,
      nextPageSugg: 0,
      mode: 1,
      groupId: 0,
    ));

/*    postScrollController.addListener(() async {
      if (postScrollController.position.pixels ==
          postScrollController.position.maxScrollExtent) {
        print("dkjfdshf===>${postScrollController.position.pixels}");
        print("called 1");
        await getPostDetailData(
            postDetailPayload: PostDetailPayload(
          nextPage: postDetailModel?.data?.nextPage,
          requestTime: 0,
          nextPageSugg: postDetailModel?.data?.nextPageSugg,
          mode: 1,
          groupId: 0,
        ));
      }
      update();
    });*/

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoadMoreRunning = true;
        print("called");
        await getPostDetailData(
            postDetailPayload: PostDetailPayload(
          nextPage: postDetailModel?.data?.nextPage,
          requestTime: 0,
          nextPageSugg: postDetailModel?.data?.nextPageSugg,
          mode: 1,
          groupId: 0,
        ));
      }
      isLoadMoreRunning = false;
    });

    getVideoLoad(
        url:
            '${postDetailModel!.data!.fileUrlPrefix}${postDetailModel!.data!.postDetails![0].postDetails!.postfiles}');

    ///audio player
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(
        postDetailModel!.data!.postDetails![0].postDetails!.postfiles == null ||
                postDetailModel!
                    .data!.postDetails![0].postDetails!.postfiles!.isEmpty
            ? "https://file-examples.com/storage/fe19e1a6e563854389e633c/2017/11/file_example_MP3_700KB.mp3"
            : '${postDetailModel!.data!.fileUrlPrefix}${postDetailModel!.data!.postDetails![0].postDetails!.postfiles}',
      )));
    } catch (e) {
      print("Error loading audio source: $e");
    }
    super.onInit();
  }

  getVideoLoad({String? url}) {
    ///video player
    controller = VideoPlayerController.network(url!)
      ..initialize().then((_) {
        update();
      });
    controller!.addListener(() {
      finishedPlaying = true;
      update();
    });
  }

  @override
  void dispose() {
    scrollController.addListener(loadMore);
    postScrollController.addListener(loadMore);
    super.dispose();
  }

  getUpdate() {
    update();
  }

  void loadMore() async {
    print('load more called');
    if (hasNextPage &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        postScrollController.position.pixels ==
            postScrollController.position.maxScrollExtent &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      isLoadMoreRunning = true;
      try {
        PostDetailModel? response = await ApiService().postDetailApi(
            postDetailPayload: PostDetailPayload(
                nextPage: postDetailModel?.data?.nextPage,
                requestTime: 0,
                groupId: 0,
                mode: 1,
                nextPageSugg: postDetailModel?.data?.nextPageSugg));
      } catch (err) {
        print('Something went wrong!');
      }
      isLoadMoreRunning = false;
      update();
    } else {
      print('not paginat');
    }
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
    postDetailModel =
        await ApiService().postDetailApi(postDetailPayload: postDetailPayload);
    postDetailsList.addAll(postDetailModel!.data!.postDetails!);
    update();
  }

  getDurationInDate(apiDate) {
    DateTime date1 = DateTime.now().toLocal();
    DateTime date2 = DateTime.parse(apiDate).toLocal();
    if (DateFormat('yyyy-MM-dd').format(DateTime.parse(apiDate).toLocal()) ==
        DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal())) {
      minutesDuration = date1.difference(date2).inHours;
      return minutesDuration;
    } else {
      dayDuration = date1.difference(date2).inDays;
      return dayDuration;
    }
  }
}
