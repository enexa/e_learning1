import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'mycourse.dart';

class VideoPage extends StatefulWidget {
  final String title;
  final String description;
  final String thumbnail;
  final List<MyVideo> videos;

  VideoPage({
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.videos,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool _playArea = false;
  late VideoPlayerController _controller;
  late VoidCallback _videoPlayerListener;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videos[0].videoUrl);
    _videoPlayerListener = () {
      if (_controller.value.isInitialized) {
        if (!_controller.value.isPlaying &&
            _controller.value.position == _controller.value.duration) {
          // Video playback completed, handle accordingly
        }
        setState(() {});
      }
    };
    _controller.addListener(_videoPlayerListener);
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_videoPlayerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.blueAccent,
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            _playArea == false
                ? Container(
                    padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(child: Container()),
                            const Icon(
                              Icons.info_outline,
                              size: 20,
                              color: Colors.white,
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(widget.title),
                        SizedBox(height: 5),
                        Text(widget.description),
                        SizedBox(height: 50),
                        Row(
                          children: [
                            Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 250,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _playArea = false;
                                  });
                                },
                                child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                              ),
                              Expanded(child: Container()),
                              Icon(Icons.info_outline, size: 20, color: Colors.white)
                            ],
                          ),
                        ),
                        _playView(context),
                      ],
                    ),
                  ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  ),
                ),
                child: ListView.builder(
                  itemCount: widget.videos.length,
                  itemBuilder: (context, index) {
                    final video = widget.videos[index];
                    return GestureDetector(
                      onTap: () {
                        _playVideo(video.videoUrl);
                      },
                      child: Container(
                        height: 135,
                        color: Colors.white,
                        width: 200,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(widget.thumbnail),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    Text(widget.title),
                                    SizedBox(height: 5),
                                    Text(widget.description),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueAccent,
                                  ),
                                  child: Text(
                                    'Watch Now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Row(
                                  children: [
                                    for (int i = 0; i < 70; i++)
                                      Container(
                                        width: 3,
                                        height: 1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _playVideo(String videoUrl) {
    setState(() {
      _controller.removeListener(_videoPlayerListener);
      _controller.dispose();
      _controller = VideoPlayerController.network(videoUrl);
      _controller.addListener(_videoPlayerListener);
      _controller.initialize().then((_) {
        _controller.play();
        setState(() {
          _playArea = true;
        });
      });
    });
  }

  Widget _playView(BuildContext context) {
    if (_controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(_controller),
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
