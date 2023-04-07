import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:e_learning/models/user.dart';

class Director{
  RtcEngine? engine;
  AgoraClient?client;
  AgoraRtmChannel? channel; 
  Set<AgoraUser> activeusers ;
  Set<AgoraUser> users;
  AgoraUser? localUid;
  Director({
    this.engine,
    this.client,
    this.channel,
    this.activeusers=const {},
    this.users=const {},
    this.localUid});
    Director copyWith({
    RtcEngine? engine,
    AgoraClient?client,
    AgoraRtmChannel? channel,
    Set<AgoraUser>? activeusers,
    Set<AgoraUser>? users,
    AgoraUser? localUid,
  }) {
    return Director(
      engine: engine ?? this.engine,
      client: client ?? this.client,
      channel: channel ?? this.channel,
      activeusers: activeusers ?? this.activeusers,
      users: users ?? this.users,
      localUid: localUid ?? this.localUid,
    );
  }
}