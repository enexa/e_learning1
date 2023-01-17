import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class Vedeo extends StatefulWidget {
  const Vedeo({super.key});

  @override
  State<Vedeo> createState() => _VedeoState();
}
class _VedeoState extends State<Vedeo> {
  late YoutubePlayerController controller;
  @override
  void initState(){
   
    super.initState();
    const url='https://www.youtube.com/watch?v=TAmZn2f7Pg8&list=PLj0msIsUsJ04KL5v25N8jD-Tfd23CUFNr';
    controller=YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }
  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    controller.pause();
    super.deactivate();
  }
  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)=>YoutubePlayerBuilder( 
    player: 
    YoutubePlayer(
      controller: controller,
    ),
    builder: (context,player)=> Scaffold(
      appBar: AppBar(
        title: const Text('vedeo'),
      ),
      body: ListView (
       children: [
        player,
        const SizedBox(height: 10),
        const Text('this is the vedeo of c++'),
        ElevatedButton(onPressed:(){
          const url='https://www.youtube.com/watch?v=8pEwAD0IZ0k&list=PLj0msIsUsJ04KL5v25N8jD-Tfd23CUFNr&index=2';
          controller.load(YoutubePlayer.convertUrlToId(url)!);
        } , child: const Text('Next Vedeo') ),
       ],
      ),
    ),  );
  }