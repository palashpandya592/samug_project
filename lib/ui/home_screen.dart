import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samug_project/constant/app_colors.dart';
import 'package:samug_project/constant/app_images.dart';
import 'package:samug_project/constant/app_strings.dart';
import 'package:samug_project/controller/home_controller.dart';
import 'package:samug_project/model/post_detail_model.dart';
import 'package:samug_project/ui/video_player.dart';
import 'package:samug_project/ui/widget/common_widget.dart';
import 'package:samug_project/utills/widget/app_bar.dart';
import 'package:samug_project/utills/widget/search_field.dart';
import 'package:samug_project/utills/widget/space_divider.dart';
import 'package:video_player/video_player.dart';

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
      statusBarColor: Colors.black,
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
        title: Text(AppStrings.homeScreen,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: AppColors.black)),
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
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: AppColors.blue)),
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
        child: SingleChildScrollView(
          controller: homeController.scrollController,
          child: GetBuilder<HomeController>(
            init: homeController,
            builder: (_) => _.postDetailModel?.data == null ||
                    homeController.isFirstLoadRunning
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      searchField(
                        hintText: 'Search your favourite',
                      ),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                            controller: homeController.postScrollController,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(right: 0),
                            itemCount:
                                _.postDetailModel?.data?.postGroup!.length,
                            itemBuilder: (context, index) {
                              PostGroup postGroup =
                                  _.postDetailModel!.data!.postGroup![index];
                              return Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, top: 17),
                                  child: profileListCommon(
                                      image:
                                          '${_.postDetailModel!.data!.fileUrlPrefix}${postGroup.imagePath}',
                                      text: postGroup.groupName));
                            }),
                      ),
                      verticalSpace(height: 30),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              _.postDetailModel!.data!.postDetails!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            PostDetail postDetail =
                                _.postDetailModel!.data!.postDetails![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            '${_.postDetailModel!.data!.fileUrlPrefix}${postDetail.profileImage!}')),
                                    /**/
                                    title: Text(postDetail.fullName!,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: AppColors.black)),
                                    subtitle: RichText(
                                      text: TextSpan(
                                          text: '@${postDetail.accountId}',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors.green),
                                          children: <InlineSpan>[
                                            WidgetSpan(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 3),
                                                child: Image.asset(
                                                  AppImages.watch,
                                                  height: 18,
                                                  width: 10,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: '3 Hours ago',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: AppColors.grey),
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
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
                                        postDetail.postDetails!.postDetails!,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
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
                                    child: postDetail.postDetails?.postType == 1
                                        ? ImageSlideshow(
                                            initialPage: 0,
                                            indicatorColor: AppColors.blue,
                                            indicatorBackgroundColor:
                                                Colors.grey,
                                            indicatorRadius: 4,
                                            children: slideShow(
                                                _.postDetailModel!.data!
                                                    .fileUrlPrefix!,
                                                postDetail
                                                    .postDetails!.postfiles!),
                                            onPageChanged: (value) {},
                                            autoPlayInterval: 3000,
                                            isLoop: true,
                                          )
                                        : postDetail.postDetails?.postType == 2
                                            ? Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _.controller!.play();
                                                    },
                                                    child: Container(
                                                        height: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: _.controller ==
                                                                null
                                                            ? Container()
                                                            : VideoPlayer(
                                                                _.controller!)),
                                                  ),
                                                  Positioned(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        12,
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2.6,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _.controller!.play();
                                                      },
                                                      icon: CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            AppColors.white,
                                                        child: Icon(
                                                          _.controller!.value
                                                                  .isPlaying
                                                              ? Icons.pause
                                                              : _
                                                                      .finishedPlaying
                                                                  ? Icons
                                                                      .play_arrow
                                                                  : Icons
                                                                      .play_arrow,
                                                          color: AppColors
                                                              .darkBlueVideo,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : postDetail.postDetails
                                                        ?.postType ==
                                                    3
                                                ? Column(
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
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          '${_.postDetailModel!.data!.fileUrlPrefix}${postDetail.postDetails!.postfiles}',
                                                                          //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuxqMeF2C3HwYt2FQoHi69iREY6CgOKYMtng&usqp=CAU'
                                                                        ),
                                                                        fit: BoxFit.fill)),
                                                          ),
                                                          Positioned(
                                                              top: 100,
                                                              left: 100,
                                                              child:
                                                                  Image.asset(
                                                                AppImages.audio,
                                                                height: 50,
                                                                width: 150,
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
                                                              snapshot.data;
                                                          return SeekBar(
                                                            duration: positionData
                                                                    ?.duration ??
                                                                Duration.zero,
                                                            position: positionData
                                                                    ?.position ??
                                                                Duration.zero,
                                                            bufferedPosition:
                                                                positionData
                                                                        ?.bufferedPosition ??
                                                                    Duration
                                                                        .zero,
                                                            onChangeEnd:
                                                                _.player.seek,
                                                          );
                                                        },
                                                      ),
                                                      ControlButtons(_.player),
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
                                          text: postDetail
                                              .postDetails!.postCommentsCount
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
                                              postDetail.postDetails
                                                      ?.postDhan?[0].dhanCount
                                                      .toString() ??
                                                  "Gift Dhan",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
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
                          padding: const EdgeInsets.only(top: 30, bottom: 40),
                          color: Colors.amber,
                          child: const Center(
                            child: Text('You have fetched all of the content'),
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

RichText _convertHashtag(String text) {
  List<String> split = text.split(RegExp("#"));
  List<String> hashtags = split.getRange(1, split.length).fold([], (t, e) {
    var texts = e.split(" ");
    if (texts.length > 1) {
      return List.from(t)
        ..addAll(["#${texts.first}", "${e.substring(texts.first.length)}"]);
    }
    return List.from(t)..add("#${texts.first}");
  });
  return RichText(
    text: TextSpan(
      children: [TextSpan(text: split.first)]..addAll(hashtags
          .map((text) => text.contains("#")
              ? TextSpan(text: text, style: TextStyle(color: Colors.blue))
              : TextSpan(text: text))
          .toList()),
    ),
  );
}
