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
    return SafeArea(
      child: Scaffold(
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
                             
                             
                            ],
                          ),
                          
                        const  SizedBox(height: 150),
                          Row(
                            children: [
                             
                            
                              
                             const  Padding(
                                 padding:  EdgeInsets.all(8.0),
                                 child:  Icon(
                                  Icons.info_outline,
                                  size: 20,
                                  color: Colors.white,
                              ),
                               ),
                              
                               Text(widget.description),
                         
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
                                  child:  GestureDetector(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                                ),
                               
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
                  
                  ),
                  child: ListView.builder(
                    itemCount: widget.videos.length,
                    itemBuilder: (context, index) {
                      final video = widget.videos[index];
                      return GestureDetector(
                        onTap: () {
                          _playVideo(video.videoUrl);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                             color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 108,
                          
                            width: 200,
                            child: Column(
                              children: [
                                Row(
                                 children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
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
                                ),
          
                                 SizedBox(width: 20),
                                  Text(
                                  'Lecture ${index + 1}',
                                    style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 16,
                                          ),
                                                   ),
                                               ],
                                                ),
    
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                  
                                    Row(
                                      children: [
                                        for (int i = 0; i < 70; i++)
                                        const Divider(
                                          color: Colors.blue,
                                          height: 2,
                                          thickness: 2,
                                         )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
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
    final position = _controller.value.position;
    final duration = _controller.value.duration;

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
                child: Stack(
                  children: [
                    Center(
                      child: IconButton(
                        icon: Icon(
                          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 50.0,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          });
                        },
                      ),
                    ),
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      padding: const EdgeInsets.only(bottom: 20.0),
                      colors:const VideoProgressColors(
                        playedColor: Colors.red,
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Text(
                        '${formatDuration(position)} / ${formatDuration(duration)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
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

String formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

}
