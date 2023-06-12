import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:e_learning/view/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import '../../widget/constants.dart';

class LiveStream extends StatefulWidget {
  const LiveStream({Key? key}) : super(key: key);

  @override
  State<LiveStream> createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool  muted=false;
  bool vedeoDisabled=false;
  @override
  void initState() {
    super.initState();
    initAgora();
  }
  void dispose() {

    _engine.leaveChannel();
  
    super.dispose();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
            
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
         backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child:  Icon(Icons.arrow_back_ios_new,color: Get.isDarkMode?Colors.white:Colors.black,),
        ),
        title:  Text('BDU Live Class',style:headingstyle(Get.isDarkMode?Colors.white:Colors.black)),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          Positioned(
                bottom: 16,
                left: 2,
                right: 2,
                child: _toolbars(),
              ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
  Widget _toolbars() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RawMaterialButton(onPressed: _ontogglemute,shape: const CircleBorder(),
          elevation:20.0 ,
          fillColor: muted? Colors.blue:Colors.white,
          padding: const EdgeInsets.all(15.0), child:  Icon(muted?Icons.mic_off: Icons.mic, color:muted? Colors.white:Colors.blue,),
          ),
          RawMaterialButton(onPressed:_ontogglevedeodisable,shape: const CircleBorder(),
          elevation:20.0 ,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(15.0), child: const Icon(Icons.call_end, color: Colors.red,),
          ),

      
          // ignore: sort_child_properties_last
         
          RawMaterialButton(onPressed: _onswitchcamera,shape: const CircleBorder(),
            elevation:20.0 ,
            fillColor: Colors.blue,
            padding: const EdgeInsets.all(15.0), child: const Icon(Icons.switch_camera, color: Colors.white,),),


        ],
      ),
    ),
  );
 }
  
   
  _onendcall() {
   Get.back();
  }

  _ontogglemute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  
   _ontogglevedeodisable() {
    Get.back();
    setState(() {
      vedeoDisabled = !vedeoDisabled;
    });
    _engine.muteLocalVideoStream(vedeoDisabled);
  }
  
   _onswitchcamera() {
    _engine.switchCamera();
}}