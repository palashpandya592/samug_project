import 'package:chewie/chewie.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:samug_project/constant/app_colors.dart';
import 'package:samug_project/constant/app_images.dart';
import 'package:samug_project/constant/app_strings.dart';
import 'package:samug_project/constant/app_styles.dart';
import 'package:samug_project/controller/home_controller.dart';
import 'package:samug_project/model/post_detail_model.dart';
import 'package:samug_project/ui/video_player.dart';
import 'package:samug_project/ui/audio_player.dart';
import 'package:samug_project/ui/widget/common_widget.dart';
import 'package:samug_project/utills/widget/app_bar.dart';
import 'package:samug_project/utills/widget/loader.dart';
import 'package:samug_project/utills/widget/search_field.dart';
import 'package:samug_project/utills/widget/space_divider.dart';
import 'package:video_player/video_player.dart';

import '../model/post_detail_payload.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  HomeController homeController = HomeController();

  @override
  void initState() {
    super.initState();

    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    homeController.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(
        centerTitle: false,
        leading: Image.asset(
          AppImages.dashboardImage,
          height: 20,
          width: 20,
        ),
        title: Text(AppStrings.homeScreen, style: AppStyle.poppins400()),
        action: [
          Row(
            children: [
              Image.asset(
                AppImages.gift,
                height: 20,
                width: 20,
              ),
              horizontalSpace(width: 4),
              Text('142',
                  style: AppStyle.poppins400(size: 15, color: AppColors.blue)),
              horizontalSpace(width: 10),
              Image.asset(
                AppImages.notification,
                height: 20,
                width: 20,
              ),
              horizontalSpace(width: 15),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GetBuilder<HomeController>(
          init: homeController,
          builder: (_) => _.postDetailModel?.data == null ||
                  homeController.isFirstLoadRunning
              ? const Center(child: CircularProgressIndicator())
              : ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: CustomRefreshIndicator(
                    builder: MaterialIndicatorDelegate(
                      backgroundColor: Colors.white,
                      builder: (context, controller) {
                        return const CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
                    onRefresh: () async {
                      print("refresh ");
                    },
                    child: SingleChildScrollView(
                      controller: homeController.scrollController,
                      child: Column(
                        children: [
                          searchField(
                            hintText: AppStrings.searchText,
                          ),
                          SizedBox(
                            height: 130,
                            child: ListView.builder(
                                controller: homeController.postScrollController,
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(right: 0),
                                itemCount: _.postGroupList!.length,
                                itemBuilder: (context, index) {
                                  PostGroup postGroup = _.postGroupList![index];
                                  return GestureDetector(
                                    onTap: () async {
                                      _.postDetailsList = [];
                                      await _.getPostDetailData(
                                          postDetailPayload: PostDetailPayload(
                                        nextPage: 20,
                                        requestTime: 0,
                                        nextPageSugg: 5,
                                        mode: 1,
                                        groupId: postGroup.uid,
                                      ));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15, top: 17),
                                        child: profileListCommon(
                                            image:
                                                '${_.postDetailModel!.data!.fileUrlPrefix}${postGroup.imagePath}',
                                            text: postGroup.groupName)),
                                  );
                                }),
                          ),
                          verticalSpace(height: 30),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: _.postDetailsList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                PostDetail postDetail =
                                    _.postDetailsList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${_.postDetailModel!.data!.fileUrlPrefix}${postDetail.profileImage!}')),
                                        title: Text(postDetail.fullName!,
                                            style: AppStyle.poppins400(
                                                size: 13,
                                                color: AppColors.black)),
                                        subtitle: RichText(
                                          text: TextSpan(
                                              text: '@${postDetail.accountId}',
                                              style: AppStyle.poppins400(
                                                  size: 12,
                                                  color: AppColors.green),
                                              children: <InlineSpan>[
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, right: 3),
                                                    child: Image.asset(
                                                      AppImages.watch,
                                                      height: 18,
                                                      width: 10,
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${_.getDurationInDate(postDetail.postDetails!.postTimestamp.toString())} ${DateFormat('yyyy-MM-dd').format(DateTime.parse(postDetail.postDetails!.postTimestamp.toString()).toLocal()) == DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal()) ? ' Hours ago' : ' Days ago'}',
                                                  style: AppStyle.poppins400(
                                                      color: AppColors.grey,
                                                      size: 12),
                                                )
                                              ]),
                                        ),
                                        trailing: Wrap(
                                          children: [
                                            imageWithText(
                                                text: postDetail.postDetails
                                                        ?.postDhan?[0].dhanCount
                                                        .toString() ??
                                                    "50"),
                                            imageWithText(
                                                text: postDetail.postDetails!
                                                        .postDhan?[0].dhanCount
                                                        .toString() ??
                                                    "25"),
                                            horizontalSpace(width: 12),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Image.asset(
                                                AppImages.dots,
                                                width: 20,
                                                height: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            postDetail
                                                .postDetails!.postDetails!,
                                            style: AppStyle.poppins400(
                                                size: 12,
                                                color: AppColors.black)),
                                      ),
                                      verticalSpace(height: 5),
                                      Row(
                                        children: [
                                          _convertHashtag(postDetail
                                              .postDetails!.postMetadata!),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, bottom: 20),
                                        child: postDetail
                                                    .postDetails!.postType ==
                                                1
                                            ? ImageSlideshow(
                                                initialPage: 0,
                                                indicatorColor: AppColors.blue,
                                                indicatorBackgroundColor:
                                                    Colors.grey,
                                                indicatorRadius: 4,
                                                children: slideShow(
                                                    _.postDetailModel!.data!
                                                        .fileUrlPrefix!,
                                                    postDetail.postDetails!
                                                        .postfiles!),
                                                onPageChanged: (value) {},
                                                autoPlayInterval: 3000,
                                                isLoop: true,
                                              )
                                            : postDetail.postDetails
                                                        ?.postType ==
                                                    2
                                                ? Stack(
                                                    children: [
                                                      Container(
                                                        height: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: ChewieListItem(
                                                            videoPlayerController:
                                                                VideoPlayerController
                                                                    .network(
                                                                        '${_.postDetailModel?.data?.fileUrlPrefix}${postDetail.postDetails?.postfiles![0]}'),
                                                            looping: true),
                                                      ),
                                                    ],
                                                  )
                                                : postDetail.postDetails
                                                            ?.postType ==
                                                        3
                                                    ? postDetail.postDetails!
                                                                    .postfiles ==
                                                                null ||
                                                            postDetail
                                                                .postDetails!
                                                                .postfiles!
                                                                .isEmpty
                                                        ? Container()
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  Container(
                                                                    height: 230,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        image: const DecorationImage(
                                                                            image: NetworkImage(
                                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuxqMeF2C3HwYt2FQoHi69iREY6CgOKYMtng&usqp=CAU',
                                                                            ),
                                                                            fit: BoxFit.fill)),
                                                                  ),
                                                                  Positioned(
                                                                      top: 100,
                                                                      left: 100,
                                                                      child: Image
                                                                          .asset(
                                                                        AppImages
                                                                            .audio,
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            150,
                                                                      ))
                                                                ],
                                                              ),
                                                              StreamBuilder<
                                                                  PositionData>(
                                                                stream: _
                                                                    .positionDataStream,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  final positionData =
                                                                      snapshot
                                                                          .data;
                                                                  return SeekBar(
                                                                    duration: positionData
                                                                            ?.duration ??
                                                                        Duration
                                                                            .zero,
                                                                    position: positionData
                                                                            ?.position ??
                                                                        Duration
                                                                            .zero,
                                                                    bufferedPosition: positionData
                                                                            ?.bufferedPosition ??
                                                                        Duration
                                                                            .zero,
                                                                    onChangeEnd: _
                                                                        .player
                                                                        .seek,
                                                                  );
                                                                },
                                                              ),
                                                              ControlButtons(
                                                                  _.player),
                                                            ],
                                                          )
                                                    : Container(),
                                      ),
                                      Row(
                                        children: [
                                          commentContainer(
                                              image: AppImages.slap,
                                              background: AppColors.blue,
                                              text: postDetail
                                                  .postDetails!.postLikes
                                                  .toString()),
                                          horizontalSpace(width: 10),
                                          commentContainer(
                                              image: AppImages.message,
                                              text: postDetail.postDetails!
                                                  .postCommentsCount
                                                  .toString(),
                                              background: AppColors.grey),
                                          commentContainer(
                                              image: AppImages.eye,
                                              text: postDetail
                                                  .postDetails!.viewCount
                                                  .toString(),
                                              textColor: AppColors.purple),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                  postDetail
                                                          .postDetails
                                                          ?.postDhan?[0]
                                                          .dhanCount
                                                          .toString() ??
                                                      "Gift Dhan",
                                                  style: AppStyle.poppins400(
                                                      color: AppColors.blue)),
                                              Image.asset(
                                                AppImages.gift,
                                                height: 25,
                                                width: 25,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          if (homeController.isLoadMoreRunning == true)
                            const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 40),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          if (homeController.hasNextPage == false)
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 40),
                              color: Colors.amber,
                              child: const Center(
                                child:
                                    Text('You have fetched all of the content'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

Expanded _convertHashtag(String text) {
  List<String> split = text.split(RegExp("#"));
  List<String> hashtags = split.getRange(1, split.length).fold([], (t, e) {
    var texts = e.split(" ");
    if (texts.length > 1) {
      return List.from(t)
        ..addAll(["#${texts.first}", "${e.substring(texts.first.length)}"]);
    }
    return List.from(t)..add("#${texts.first}");
  });
  return Expanded(
    child: RichText(
      overflow: TextOverflow.visible,
      softWrap: true,
      text: TextSpan(
        children: [TextSpan(text: split.first)]..addAll(hashtags
            .map((text) => text.contains("#")
                ? TextSpan(text: text, style: TextStyle(color: Colors.blue))
                : TextSpan(text: text))
            .toList()),
      ),
    ),
  );
}
