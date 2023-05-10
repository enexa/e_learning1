// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List _videos = [];

  void _getVideos() async {
    var response = await http.get(Uri.parse('http://example.com/api/videos'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List videos = data.map((e) => e['url']).toList();
      setState(() {
        _videos = videos;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: _videos
          .asMap()
          .map(
            (index, videoUrl) => MapEntry(
              index,
              Step(
                title: Text('Video ${index + 1}'),
                content: VideoPlayerWidget(url: videoUrl),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..addListener(() {
        if (_controller.value.isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = _controller.value.isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(_controller),
              AnimatedOpacity(
                opacity: _isPlaying ? 0 : 1,
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    color: Colors.white,
                    iconSize: 50,
                    onPressed: () {
                      setState(() {
                        _controller.play();
                        _isPlaying = true;
                      });
                    },
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _isPlaying ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.pause();
                      _isPlaying = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(widget.url),
      ],
    );
  }
}
