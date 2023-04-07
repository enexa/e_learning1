// ignore_for_file: library_prefixes, unused_label, list_remove_unrelated_type

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:e_learning/models/user.dart';

import 'package:flutter/material.dart';
import 'package:e_learning/constants.dart';

class MyClass extends StatefulWidget {

  final String? channelname;
  final String? username;
  final int uid;
   const MyClass({super.key, this.channelname, this.username, required this.uid});

  @override
  State<MyClass> createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  late RtcEngine _engine; 
    List<AgoraUser?> users = [];
  AgoraClient?_client;
  AgoraRtmChannel? _channel;
  bool muted = false;
  bool vedeoDisabled = false;
  @override
  void initState() {
    
    super.initState();
    initialize();
  }
  @override
  void dispose() {

    _engine.leaveChannel();
    users.clear() ;
    super.dispose();
  }
  Future<void>  initialize() async{
 await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed, ) {
          
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
       
            var Uid;
            users.add(AgoraUser(uid:Uid));
          });
        },
      ));
  
    
        onConnectionStateChanged:(connection, state, reason) {
          debugPrint('[onConnectionStateChanged] connection: ${connection.toJson()}, state: $state, reason: $reason');
        if(state == ConnectionStateType.connectionStateDisconnected){
      _channel?.leave();
      _client?.release();
        }

    
        };
    _channel?.onMemberJoined=(AgoraRtmMember member) {
      debugPrint('[onMemberJoined] member: ${member.toJson()}');
      setState(() {
        // users.add(member.userId);
      });
    
    };
    _channel?.onMemberLeft=(AgoraRtmMember member) {
      debugPrint('[onMemberLeft] member: ${member.toJson()}');
      setState(() {
        users.remove(member.userId);
      });
    };
    _channel?.onMessageReceived=(AgoraRtmMessage message, AgoraRtmMember member) {
      debugPrint('[onMessageReceived] message: ${message.toJson()}, member: ${member.toJson()}');
    };
      
   await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.joinChannel(channelId: '', options:const  ChannelMediaOptions(autoSubscribeAudio: true, autoSubscribeVideo: true), token: '', uid: widget.uid);
   await _channel?.join(); 

  }
     
       
     

  
 

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
 body: Stack(
  children: [
    _broadcastview(),
    _toolbars(),

  ],
 ),
    );
  }
  
 Widget _broadcastview() {
  if(users.isEmpty){
    return const Center(child: CircularProgressIndicator(),);
  }
  return Expanded(child: AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    ));
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
          RawMaterialButton(onPressed: _onendcall, child:  Icon(vedeoDisabled?Icons.videocam_off:Icons.videocam, color:    
          vedeoDisabled?Colors.white:Colors.blue
          ),shape: const CircleBorder(),
            elevation:20.0 ,
            fillColor: Colors.blue,
            padding: const EdgeInsets.all(15.0),),
          RawMaterialButton(onPressed: _onswitchcamera,shape: const CircleBorder(),
            elevation:20.0 ,
            fillColor: Colors.blue,
            padding: const EdgeInsets.all(15.0), child: const Icon(Icons.switch_camera, color: Colors.white,),),


        ],
      ),
    ),
  );
 }
  
   
  

  _ontogglemute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  
   _ontogglevedeodisable() {
    setState(() {
      vedeoDisabled = !vedeoDisabled;
    });
    _engine.muteLocalVideoStream(vedeoDisabled);
  }
  
   _onswitchcamera() {
    _engine.switchCamera();
  }
  
   _onendcall() {
    Navigator.pop(context);
  }
  }