import 'package:json_annotation/json_annotation.dart';

import 'events.dart';
import 'rtc_engine.dart';

/// IP 区域。
/// @enum {number} // TODO 该 tag 是否生效？
enum IPAreaCode {
  /// 中国大陆。
  @JsonValue(1 << 0)
  AREA_CN,

  /// 北美区域。
  @JsonValue(1 << 1)
  AREA_NA,

  ///  欧洲区域。
  @JsonValue(1 << 2)
  AREA_EUR,

  /// 除中国大陆以外的亚洲区域。
  @JsonValue(1 << 3)
  AREA_AS,

  /// (Default) Global
  @JsonValue(-1)
  AREA_GLOBAL,
}

/// 用于旁路直播的输出音频的编码规格。
/// @enum {number}
enum AudioCodecProfileType {
  /// (默认) LCAAC 规格，表示基本音频编码规格。 // TODO 英文将 LC-AAC 改成 LCAAC。
  @JsonValue(0)
  LCAAC,

  /// HEAAC 规格，表示高效音频编码规格。
  @JsonValue(1)
  HEAAC,
}

/// 语音音效均衡波段的中心频率。
/// @enum {number}
enum AudioEqualizationBandFrequency {
  /// 31 Hz。
  @JsonValue(0)
  Band31,

  /// 62 Hz。
  @JsonValue(1)
  Band62,

  /// 125 Hz。
  @JsonValue(2)
  Band125,

  /// 250 Hz。
  @JsonValue(3)
  Band250,

  /// 500 Hz。
  @JsonValue(4)
  Band500,

  /// 1 kHz。
  @JsonValue(5)
  Band1K,

  /// 2 kHz。
  @JsonValue(6)
  Band2K,

  /// 4 kHz。
  @JsonValue(7)
  Band4K,

  /// 8 kHz。
  @JsonValue(8)
  Band8K,

  /// 16 kHz。
  @JsonValue(9)
  Band16K,
}

/// 本地音频出错原因。
/// @enum {number}
enum AudioLocalError {
  /// 本地音频状态正常。
  @JsonValue(0)
  Ok,

  /// 本地音频出错原因不明确。
  @JsonValue(1)
  Failure,

  /// 没有权限启动本地音频录制设备。
  @JsonValue(2)
  DeviceNoPermission,

  /// 本地音频录制设备已经在使用中。
  @JsonValue(3)
  DeviceBusy,

  /// 本地音频录制失败，建议你检查录制设备是否正常工作。
  @JsonValue(4)
  RecordFailure,

  /// 本地音频编码失败。
  @JsonValue(5)
  EncodeFailure,
}

/// 本地音频状态。
/// @enum {number}
enum AudioLocalState {
  /// 本地音频默认初始状态。
  @JsonValue(0)
  Stopped,

  /// 本地音频录制设备启动成功。
  @JsonValue(1)
  Recording,

  /// 本地音频首帧编码成功。
  @JsonValue(2)
  Encoding,

  /// 本地音频启动失败。
  @JsonValue(3)
  Failed,
}

/// 混音音乐文件错误码。
/// @enum {number}
enum AudioMixingErrorCode {
  /// 音乐文件打开出错。
  @JsonValue(701)
  CanNotOpen,

  /// 音乐文件打开太频繁。
  @JsonValue(702)
  TooFrequentCall,

  /// 音乐文件播放异常中断。
  @JsonValue(703)
  InterruptedEOF,

  /// 无错误。
  @JsonValue(0)
  OK,
}

/// 混音音乐文件状态。
/// @enum {number}
enum AudioMixingStateCode {
  /// 音乐文件正常播放。
  @JsonValue(710)
  Playing,

  /// 音乐文件暂停播放。
  @JsonValue(711)
  Paused,

  /// 音乐文件停止播放。
  @JsonValue(713)
  Stopped,

  /// 音乐文件报错。
  @JsonValue(714)
  Failed,
}

/// 语音路由。
/// @enum {number}
enum AudioOutputRouting {
  /// 使用默认的音频路由。
  @JsonValue(-1)
  Default,

  /// 使用耳机为语音路由。
  @JsonValue(0)
  Headset,

  /// 使用听筒为语音路由。
  @JsonValue(1)
  Earpiece,

  /// 使用不带麦的耳机为语音路由。
  @JsonValue(2)
  HeadsetNoMic,

  /// 使用手机的扬声器为语音路由。
  @JsonValue(3)
  Speakerphone,

  /// 使用外接的扬声器为语音路由。
  @JsonValue(4)
  Loudspeaker,

  /// 使用蓝牙耳机为语音路由。
  @JsonValue(5)
  HeadsetBluetooth,
}

/// 音频属性。
/// @enum {number}
enum AudioProfile {
  ///默认设置。
  /// - 通信场景下，该选项代表指定 32 kHz 采样率，语音编码，单声道，编码码率最大值为 18 Kbps。
  /// - 直播场景下，该选项代表指定 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 52 Kbps。
  @JsonValue(0)
  Default,

  /// 指定 32 kHz 采样率，语音编码，单声道，编码码率最大值为 18 Kbps。
  @JsonValue(1)
  SpeechStandard,

  /// 指定 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。
  @JsonValue(2)
  MusicStandard,

  /// 指定 48 kHz采样率，音乐编码，双声道，编码码率最大值为 56 Kbps。
  @JsonValue(3)
  MusicStandardStereo,

  /// 指定 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 128 Kbps。
  @JsonValue(4)
  MusicHighQuality,

  /// 指定 48 kHz 采样率，音乐编码，双声道，编码码率最大值为 192 Kbps。
  @JsonValue(5)
  MusicHighQualityStereo,
}

/// `onRecordAudioFrame` 的使用模式。// TODO 将 on 去掉？
/// @enum {number}
/// TODO @nodoc setPlaybackAudioFrameParameters // TODO 这个枚举是用不到吗？
enum AudioRawFrameOperationMode {
  /// 只读模式，用户仅从 AudioFrame 获取原始音频数据，不作任何修改。
  /// 例如，如果用户通过 Agora SDK 采集数据，自己进行 RTMP 推流，则可以选择该模式。
  @JsonValue(0)
  ReadOnly,

  /// 只写模式，用户替换 AudioFrame 中的数据。例如，如果用户自行采集数据，可选择该模式。
  @JsonValue(1)
  WriteOnly,

  /// 读写模式，用户从 AudioFrame 获取数据、修改。
  /// 例如，如果用户自己有音效处理模块，且想要根据实际需要对数据进行后处理 (例如变声)，则可以选择该模式。
  @JsonValue(2)
  ReadWrite,
}

/// 录音质量。
enum AudioRecordingQuality {
  /// 低音质。采样率为 32 kHz，录制 10 分钟的文件大小为 1.2 M 左右。
  @JsonValue(0)
  Low,

  /// 中音质。采样率为 32 kHz，录制 10 分钟的文件大小为 2 M 左右。
  @JsonValue(1)
  Medium,

  /// 高音质。采样率为 32 kHz，录制 10 分钟的文件大小为 3.75 M 左右。
  @JsonValue(2)
  High,
}

/// 远端音频流状态。
/// @enum {number}
enum AudioRemoteState {
  /// 远端音频流默认初始状态。在以下情况下，会报告该状态：
  /// - [AudioRemoteStateReason.LocalMuted]
  /// - [AudioRemoteStateReason.RemoteMuted]
  /// - [AudioRemoteStateReason.RemoteOffline]
  @JsonValue(0)
  Stopped,

  /// 本地用户已接收远端音频首包。
  @JsonValue(1)
  Starting,

  /// 远端音频流正在解码，正常播放。在以下情况下，会报告该状态：
  /// - [AudioRemoteStateReason.NetworkRecovery]
  /// - [AudioRemoteStateReason.LocalUnmuted]
  /// - [AudioRemoteStateReason.RemoteUnmuted]
  @JsonValue(2)
  Decoding,

  /// 远端音频流卡顿。在以下情况下，会报告该状态：
  /// - [AudioRemoteStateReason.NetworkCongestion]
  @JsonValue(3)
  Frozen,

  /// 远端音频流播放失败。在以下情况下，会报告该状态：
  /// - [AudioRemoteStateReason.Internal]
  @JsonValue(4)
  Failed,
}

/// 远端音频流状态改变的原因。
/// @enum {number}
enum AudioRemoteStateReason {
  /// 内部原因。
  @JsonValue(0)
  Internal,

  /// 网络阻塞。
  @JsonValue(1)
  NetworkCongestion,

  /// 网络恢复正常。
  @JsonValue(2)
  NetworkRecovery,

  /// 本地用户停止接收远端音频流或本地用户禁用音频模块。
  @JsonValue(3)
  LocalMuted,

  /// 本地用户恢复接收远端音频流或本地用户启用音频模块。
  @JsonValue(4)
  LocalUnmuted,

  /// 远端用户停止发送音频流或远端用户禁用音频模块。
  @JsonValue(5)
  RemoteMuted,

  /// 远端用户恢复发送音频流或远端用户启用音频模块。
  @JsonValue(6)
  RemoteUnmuted,

  /// 远端用户离开频道。
  @JsonValue(7)
  RemoteOffline,
}

/// 预设的本地语音混响效果选项。
/// @enum {number}
enum AudioReverbPreset {
  /// 原声，即关闭本地语音混响。
  @JsonValue(0x00000000)
  Off,

  /// 流行。
  @JsonValue(0x00000001)
  Popular,

  /// R&B。
  @JsonValue(0x00000002)
  RnB,

  /// 摇滚。
  @JsonValue(0x00000003)
  Rock,

  /// 嘻哈。
  @JsonValue(0x00000004)
  HipHop,

  /// 演唱会。
  @JsonValue(0x00000005)
  VocalConcert,

  /// KTV。// 检查英文里的 enhanced 是否应该去掉？
  @JsonValue(0x00000006)
  KTV,

  /// 录音棚。
  @JsonValue(0x00000007)
  Studio,

  /// KTV（增强版）。
  @JsonValue(0x00100001)
  FX_KTV,

  /// 演唱会（增强版）。
  @JsonValue(0x00100002)
  FX_VOCAL_CONCERT,

  /// 大叔。
  @JsonValue(0x00100003)
  FX_UNCLE,

  /// 小姐姐。
  @JsonValue(0x00100004)
  FX_SISTER,

  /// 录音棚（增强版）。
  @JsonValue(0x00100005)
  FX_STUDIO,

  /// 流行（增强版）。
  @JsonValue(0x00100006)
  FX_POPULAR,

  /// R&B（增强版）。
  @JsonValue(0x00100007)
  FX_RNB,

  /// 留声机。
  @JsonValue(0x00100008)
  FX_PHONOGRAPH,

  /// 虚拟立体声。虚拟立体声是指将单声道的音轨渲染出立体声的效果，使频道内所有用户听到有空间感的声音效果。为达到更好的虚拟立体声效果，
  /// Agora 推荐在调用该方法前将 `setAudioProfile` 的 `profile` 参数设置为 `MusicHighQualityStereo`(5)。
  /// 详见 [RtcEngine.setAudioProfile]。
  /// 详见 [AudioProfile.MusicHighQualityStereo]。
  @JsonValue(0x00200001)
  VIRTUAL_STEREO,
}

/// Audio reverberation type.
/// @enum {number}
enum AudioReverbType {
  /// Level of the dry signal (-20 to 10 dB).
  @JsonValue(0)
  DryLevel,

  /// Level of the early reflection signal (wet signal) (-20 to 10 dB).
  @JsonValue(1)
  WetLevel,

  /// Room size of the reflection (0 to 100 dB). A larger room size means stronger reverberation.
  @JsonValue(2)
  RoomSize,

  /// Length of the initial delay of the wet signal (0 to 200 ms).
  @JsonValue(3)
  WetDelay,

  /// Strength of the late reverberation (0 to 100).
  @JsonValue(4)
  Strength,
}

/// Audio sample rate.
/// @enum {number}
enum AudioSampleRateType {
  /// 32 kHz.
  @JsonValue(32000)
  Type32000,

  /// 44.1 kHz.
  @JsonValue(44100)
  Type44100,

  /// 48 kHz.
  @JsonValue(48000)
  Type48000,
}

/// Audio scenario.
/// @enum {number}
enum AudioScenario {
  /// Default audio application scenario.
  @JsonValue(0)
  Default,

  /// Entertainment scenario supporting voice during gameplay.
  @JsonValue(1)
  ChatRoomEntertainment,

  /// Education scenario prioritizing smoothness and stability.
  @JsonValue(2)
  Education,

  /// Live gaming scenario, enabling the gaming audio effects in the speaker mode in a live broadcast scenario. Choose this scenario for high-fidelity music playback.
  @JsonValue(3)
  GameStreaming,

  /// Showroom scenario, optimizing the audio quality with external professional equipment.
  @JsonValue(4)
  ShowRoom,

  /// Gaming scenario.
  @JsonValue(5)
  ChatRoomGaming,
}

/// (iOS only) Audio session restriction.
/// @enum {number}
/// TODO @nodoc iOS setAudioSessionOperationRestriction
enum AudioSessionOperationRestriction {
  /// No restriction, the SDK has full control of the audio session operations.
  @JsonValue(0)
  None,

  /// The SDK does not change the audio session category.
  @JsonValue(1)
  SetCategory,

  /// The SDK does not change any setting of the audio session (category, mode, categoryOptions).
  @JsonValue(1 << 1)
  ConfigureSession,

  /// The SDK keeps the audio session active when leaving a channel.
  @JsonValue(1 << 2)
  DeactivateSession,

  /// The SDK does not configure the audio session anymore.
  @JsonValue(1 << 7)
  All,
}

/// The preset audio voice configuration used to change the voice effect.
/// @enum {number}
enum AudioVoiceChanger {
  /// Turn off the local voice changer, that is, to use the original voice.
  @JsonValue(0x00000000)
  Off,

  /// The voice of an old man.
  @JsonValue(0x00000001)
  OldMan,

  /// The voice of a little boy.
  @JsonValue(0x00000002)
  BabyBoy,

  /// The voice of a little girl.
  @JsonValue(0x00000003)
  BabyGirl,

  /// The voice of Zhu Bajie, a character in Journey to the West who has a voice like that of a growling bear.
  @JsonValue(0x00000004)
  ZhuBaJie,

  /// The ethereal voice.
  @JsonValue(0x00000005)
  Ethereal,

  /// The voice of Hulk.
  @JsonValue(0x00000006)
  Hulk,

  /// A more vigorous voice.
  @JsonValue(0x00100001)
  BEAUTY_VIGOROUS,

  /// A deeper voice.
  @JsonValue(0x00100002)
  BEAUTY_DEEP,

  /// A mellower voice.
  @JsonValue(0x00100003)
  BEAUTY_MELLOW,

  /// Falsetto.
  @JsonValue(0x00100004)
  BEAUTY_FALSETTO,

  /// A fuller voice.
  @JsonValue(0x00100005)
  BEAUTY_FULL,

  /// A clearer voice.
  @JsonValue(0x00100006)
  BEAUTY_CLEAR,

  /// A more resounding voice.
  @JsonValue(0x00100007)
  BEAUTY_RESOUNDING,

  /// A more ringing voice.
  @JsonValue(0x00100008)
  BEAUTY_RINGING,

  /// A more spatially resonant voice.
  @JsonValue(0x00100009)
  BEAUTY_SPACIAL,

  /// (For male only) A more magnetic voice. Do not use it when the speaker is a female; otherwise, voice distortion occurs.
  @JsonValue(0x00200001)
  GENERAL_BEAUTY_VOICE_MALE_MAGNETIC,

  /// (For female only) A fresher voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.
  @JsonValue(0x00200002)
  GENERAL_BEAUTY_VOICE_FEMALE_FRESH,

  /// (For female only) A more vital voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.
  @JsonValue(0x00200003)
  GENERAL_BEAUTY_VOICE_FEMALE_VITALITY,
}

/// The camera capturer configuration.
/// @enum {number}
enum CameraCaptureOutputPreference {
  /// (default) Self-adapts the camera output parameters to the system performance and network conditions to balance CPU consumption and video preview quality.
  @JsonValue(0)
  Auto,

  /// Prioritizes the system performance. The SDK chooses the dimension and frame rate of the local camera capture closest to those set by setVideoEncoderConfiguration.
  /// See [RtcEngine.setVideoEncoderConfiguration]
  @JsonValue(1)
  Performance,

  /// Prioritizes the local preview quality. The SDK chooses higher camera output parameters to improve the local video preview quality. This option requires extra CPU and RAM usage for video pre-processing.
  @JsonValue(2)
  Preview,

  /// Internal use only.
  @JsonValue(3)
  Unkown,
}

/// The camera direction.
/// @enum {number}
enum CameraDirection {
  /// The rear camera.
  @JsonValue(0)
  Rear,

  /// The front camera.
  @JsonValue(1)
  Front,
}

/// The error code in AgoraChannelMediaRelayError.
/// @enum {number}
enum ChannelMediaRelayError {
  /// The state is normal.
  @JsonValue(0)
  None,

  /// An error occurs in the server response.
  @JsonValue(1)
  ServerErrorResponse,

  /// No server response. You can call the leaveChannel method to leave the channel.
  /// See [RtcEngine.leaveChannel]
  @JsonValue(2)
  ServerNoResponse,

  /// The SDK fails to access the service, probably due to limited resources of the server.
  @JsonValue(3)
  NoResourceAvailable,

  /// Fails to send the relay request.
  @JsonValue(4)
  FailedJoinSourceChannel,

  /// Fails to accept the relay request.
  @JsonValue(5)
  FailedJoinDestinationChannel,

  /// The server fails to receive the media stream.
  @JsonValue(6)
  FailedPacketReceivedFromSource,

  /// The server fails to send the media stream.
  @JsonValue(7)
  FailedPacketSentToDestination,

  /// The SDK disconnects from the server due to poor network connections. You can call the `leaveChannel` method to leave the channel.
  /// See [RtcEngine.leaveChannel]
  @JsonValue(8)
  ServerConnectionLost,

  /// An internal error occurs in the server.
  @JsonValue(9)
  InternalError,

  /// The token of the source channel has expired.
  @JsonValue(10)
  SourceTokenExpired,

  /// The token of the destination channel has expired.
  @JsonValue(11)
  DestinationTokenExpired,
}

/// The event code in AgoraChannelMediaRelayEvent.
/// @enum {number}
enum ChannelMediaRelayEvent {
  /// The user disconnects from the server due to poor network connections.
  @JsonValue(0)
  Disconnect,

  /// The network reconnects.
  @JsonValue(1)
  Connected,

  /// The user joins the source channel.
  @JsonValue(2)
  JoinedSourceChannel,

  /// The user joins the destination channel.
  @JsonValue(3)
  JoinedDestinationChannel,

  /// The SDK starts relaying the media stream to the destination channel.
  @JsonValue(4)
  SentToDestinationChannel,

  /// The server receives the video stream from the source channel.
  @JsonValue(5)
  ReceivedVideoPacketFromSource,

  /// The server receives the audio stream from the source channel.
  @JsonValue(6)
  ReceivedAudioPacketFromSource,

  /// The destination channel is updated.
  @JsonValue(7)
  UpdateDestinationChannel,

  /// The destination channel update fails due to internal reasons.
  @JsonValue(8)
  UpdateDestinationChannelRefused,

  /// The destination channel does not change, which means that the destination channel fails to be updated.
  @JsonValue(9)
  UpdateDestinationChannelNotChange,

  /// The destination channel name is NULL.
  @JsonValue(10)
  UpdateDestinationChannelIsNil,

  /// The video profile is sent to the server.
  @JsonValue(11)
  VideoProfileUpdate,
}

/// The state code in AgoraChannelMediaRelayState.
/// @enum {number}
enum ChannelMediaRelayState {
  /// The SDK is initializing.
  @JsonValue(0)
  Idle,

  /// The SDK tries to relay the media stream to the destination channel.
  @JsonValue(1)
  Connecting,

  /// The SDK successfully relays the media stream to the destination channel.
  @JsonValue(2)
  Running,

  /// A failure occurs.
  @JsonValue(3)
  Failure,
}

/// Channel profile.
/// @enum {number}
enum ChannelProfile {
  /// (Default) The Communication profile.
  /// Use this profile in one-on-one calls or group calls, where all users can talk freely.
  @JsonValue(0)
  Communication,

  /// The LiveBroadcasting profile.
  /// Users in a live-broadcast channel have a role as either broadcaster or audience. A broadcaster can both send and receive streams; an audience can only receive streams.
  @JsonValue(1)
  LiveBroadcasting,

  /// The Gaming profile.
  /// This profile uses a codec with a lower bitrate and consumes less power. Applies to the gaming scenario, where all game players can talk freely.
  @JsonValue(2)
  Game,
}

/// Client role in a live broadcast.
/// @enum {number}
enum ClientRole {
  /// A broadcaster can both send and receive streams.
  @JsonValue(1)
  Broadcaster,

  /// The default role. An audience can only receive streams.
  @JsonValue(2)
  Audience,
}

/// Reasons for the connection state change.
/// @enum {number}
enum ConnectionChangedReason {
  /// The SDK is connecting to Agora’s edge server.
  @JsonValue(0)
  Connecting,

  /// The SDK has joined the channel successfully.
  @JsonValue(1)
  JoinSuccess,

  /// The connection between the SDK and Agora’s edge server is interrupted.
  @JsonValue(2)
  Interrupted,

  /// The connection between the SDK and Agora’s edge server is banned by Agora’s edge server.
  @JsonValue(3)
  BannedByServer,

  /// The SDK fails to join the channel for more than 20 minutes and stops reconnecting to the channel.
  @JsonValue(4)
  JoinFailed,

  /// The SDK has left the channel.
  @JsonValue(5)
  LeaveChannel,

  /// The specified App ID is invalid. Try to rejoin the channel with a valid App ID.
  @JsonValue(6)
  InvalidAppId,

  /// The specified channel name is invalid. Try to rejoin the channel with a valid channel name.
  @JsonValue(7)
  InvalidChannelName,

  /// The generated token is invalid probably due to the following reasons:
  /// - The App Certificate for the project is enabled in Console, but you do not use Token when joining the channel. If you enable the App Certificate, you must use a token to join the channel.
  /// - The uid that you specify in the `joinChannel` method is different from the uid that you pass for generating the token.
  /// See [RtcEngine.joinChannel]
  @JsonValue(8)
  InvalidToken,

  /// The token has expired. Generate a new token from your server.
  @JsonValue(9)
  TokenExpired,

  /// The user is banned by the server.
  @JsonValue(10)
  RejectedByServer,

  /// The SDK tries to reconnect after setting a proxy server.
  @JsonValue(11)
  SettingProxyServer,

  /// The token renews.
  @JsonValue(12)
  RenewToken,

  /// The client IP address has changed, probably due to a change of the network type, IP address, or network port.
  @JsonValue(13)
  ClientIpAddressChanged,

  /// Timeout for the keep-alive of the connection between the SDK and Agora’s edge server. The connection state changes to:
  /// See [ConnectionStateType.Reconnecting]
  @JsonValue(14)
  KeepAliveTimeout,
}

/// Connection states.
/// @enum {number}
enum ConnectionStateType {
  /// The SDK is disconnected from Agora's edge server.
  /// - This is the initial state before `joinChannel`.
  /// See [RtcEngine.joinChannel]
  /// - The SDK also enters this state when the app calls `leaveChannel`.
  /// See [RtcEngine.leaveChannel]
  @JsonValue(1)
  Disconnected,

  /// The SDK is connecting to Agora's edge server.
  /// - When the app calls `joinChannel`, the SDK starts to establish a connection to the specified channel, triggers the `connectionStateChanged` callback, and switches to the Connecting state.
  /// See [RtcEngine.joinChannel]
  /// See [RtcEngineEventHandler.connectionStateChanged]
  /// See [ConnectionStateType.Connecting]
  /// - When the SDK successfully joins the channel, the SDK triggers the `connectionStateChanged` callback and switches to the Connected state.
  /// See [RtcEngineEventHandler.connectionStateChanged]
  /// See [ConnectionStateType.Connected]
  /// - After the SDK joins the channel and when it finishes initializing the media engine, the SDK triggers the `joinChannelSuccess` callback.
  /// See [RtcEngineEventHandler.joinChannelSuccess]
  @JsonValue(2)
  Connecting,

  /// The SDK is connected to Agora's edge server and joins a channel. You can now publish or subscribe to a media stream in the channel.
  /// If the connection to the channel is lost because, for example, the network is down or switched, the SDK automatically tries to reconnect and triggers:
  /// - The `connectionStateChanged` callback, and switches to the Reconnecting state.
  /// See [RtcEngineEventHandler.connectionStateChanged]
  /// See [ConnectionStateType.Reconnecting]
  @JsonValue(3)
  Connected,

  /// The SDK keeps rejoining the channel after being disconnected from a joined channel because of network issues.
  /// - If the SDK cannot rejoin the channel within 10 seconds after being disconnected from Agora’s edge server, the SDK triggers the `connectionLost` callback, stays in the Reconnecting state, and keeps rejoining the channel.
  /// See [RtcEngineEventHandler.connectionLost]
  /// - If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora’s edge server, the SDK triggers the `connectionStateChanged` callback, switches to the Failed state, and stops rejoining the channel.
  /// See [RtcEngineEventHandler.connectionStateChanged]
  /// See [ConnectionStateType.Failed]
  @JsonValue(4)
  Reconnecting,

  /// The SDK fails to connect to Agora's edge server or join the channel.
  /// You must call `leaveChannel` to leave this state, and call `joinChannel` again to rejoin the channel.
  /// See [RtcEngine.leaveChannel]
  /// See [RtcEngine.joinChannel]
  /// If the SDK is banned from joining the channel by Agora’s edge server (through the RESTful API), the SDK triggers the `connectionStateChanged` callbacks.
  /// See [RtcEngineEventHandler.connectionStateChanged]
  @JsonValue(5)
  Failed,
}

/// The video encoding degradation preference under limited bandwidth.
/// @enum {number}
enum DegradationPreference {
  /// (Default) Degrades the frame rate to guarantee the video quality.
  @JsonValue(0)
  MaintainQuality,

  /// Degrades the video quality to guarantee the frame rate.
  @JsonValue(1)
  MaintainFramerate,

  /// Reserved for future use.
  @JsonValue(2)
  Balanced
}

/// Encryption mode
/// @enum {string}
enum EncryptionMode {
  /// (Default) 128-bit AES encryption, XTS mode.
  @JsonValue('aes-128-xts')
  AES128XTS,

  /// 256-bit AES encryption, XTS mode.
  @JsonValue('aes-256-xts')
  AES256XTS,

  /// 128-bit AES encryption, ECB mode.
  @JsonValue('aes-128-ecb')
  AES128ECB,
}

/// Error codes occur when the SDK encounters an error that cannot be recovered automatically without any app intervention.
/// @enum {number}
enum ErrorCode {
  /// No error occurs.
  @JsonValue(0)
  NoError,

  /// A general error occurs (no specified reason).
  @JsonValue(1)
  Failed,

  /// An invalid parameter is used. For example, the specific channel name includes illegal characters.
  @JsonValue(2)
  InvalidArgument,

  /// The SDK module is not ready.
  /// Possible solutions:
  /// - Check the audio device.
  /// - Check the completeness of the app.
  /// - Re-initialize the SDK.
  @JsonValue(3)
  NotReady,

  /// The current state of the SDK does not support this function.
  @JsonValue(4)
  NotSupported,

  /// The request is rejected. This is for internal SDK use only, and is not returned to the app through any method or callback.
  @JsonValue(5)
  Refused,

  /// The buffer size is not big enough to store the returned data.
  @JsonValue(6)
  BufferTooSmall,

  /// The SDK is not initialized before calling this method.
  @JsonValue(7)
  NotInitialized,

  /// No permission exists. Check whether the user has granted access to the audio or video device.
  @JsonValue(9)
  NoPermission,

  /// An API method timeout occurs. Some API methods require the SDK to return the execution result, and this error occurs if the request takes too long (over 10 seconds) for the SDK to process.
  @JsonValue(10)
  TimedOut,

  /// The request is canceled. This is for internal SDK use only, and is not returned to the app through any method or callback.
  @JsonValue(11)
  Canceled,

  /// The method is called too often. This is for internal SDK use only, and is not returned to the app through any method or callback.
  @JsonValue(12)
  TooOften,

  /// The SDK fails to bind to the network socket. This is for internal SDK use only, and is not returned to the app through any method or callback.
  @JsonValue(13)
  BindSocket,

  /// The network is unavailable. This is for internal SDK use only, and is not returned to the app through any method or callback.
  @JsonValue(14)
  NetDown,

  /// No network buffers are available. This is for internal SDK use only, and is not returned to the app through any method or callback.
  @JsonValue(15)
  NoBufs,

  /// The request to join the channel is rejected.
  /// Possible reasons are:
  /// - The user is already in the channel, and still calls the API method to join the channel, for example, `joinChannel`.
  /// See [RtcEngine.joinChannel]
  /// - The user tries joining the channel during the echo test. Please join the channel after the echo test ends.
  @JsonValue(17)
  JoinChannelRejected,

  /// The request to leave the channel is rejected.
  /// Possible reasons are:
  /// - The user left the channel and still calls the API method to leave the channel, for example, `leaveChannel`.
  /// See [RtcEngine.leaveChannel]
  /// - The user has not joined the channel and calls the API method to leave the channel.
  @JsonValue(18)
  LeaveChannelRejected,

  /// The resources are occupied and cannot be used.
  @JsonValue(19)
  AlreadyInUse,

  /// The SDK gave up the request due to too many requests.
  @JsonValue(20)
  Abort,

  /// In Windows, specific firewall settings cause the SDK to fail to initialize and crash.
  @JsonValue(21)
  InitNetEngine,

  /// The app uses too much of the system resources and the SDK fails to allocate the resources.
  @JsonValue(22)
  ResourceLimited,

  /// The specified App ID is invalid. Please try to rejoin the channel with a valid App ID.
  @JsonValue(101)
  InvalidAppId,

  /// The specified channel name is invalid. Please try to rejoin the channel with a valid channel name.
  @JsonValue(102)
  InvalidChannelId,

  /// The token expired. Agora recommends that you use `TokenExpired`(9) in the reason parameter of `connectionStateChanged` instead.
  /// See [ConnectionChangedReason.TokenExpired]
  /// See [RtcEngineEventHandler.connectionStateChanged]
  /// Possible reasons are:
  /// - Authorized Timestamp expired: The timestamp is represented by the number of seconds elapsed since 1/1/1970. The user can use the token to access the Agora service within five minutes after the token is generated. If the user does not access the Agora service after five minutes, this token is no longer valid.
  /// - Call Expiration Timestamp expired: The timestamp is the exact time when a user can no longer use the Agora service (for example, when a user is forced to leave an ongoing call). When a value is set for the Call Expiration Timestamp, it does not mean that the token will expire, but that the user will be banned from the channel.
  @deprecated
  @JsonValue(109)
  TokenExpired,

  /// The token is invalid. Agora recommends that you use `InvalidToken`(8) in the reason parameter of `connectionStateChanged` instead.
  /// See [ConnectionChangedReason.InvalidToken]
  /// See [RtcEngineEventHandler.connectionStateChanged]
  /// Possible reasons are:
  /// - The App Certificate for the project is enabled in Console, but the user is using the App ID. Once the App Certificate is enabled, the user must use a token.
  /// - The uid is mandatory, and users must set the same uid as the one set in the `joinChannel` method.
  /// See [RtcEngine.joinChannel]
  @deprecated
  @JsonValue(110)
  InvalidToken,

  /// The Internet connection is interrupted. This applies to the Agora Web SDK only.
  @JsonValue(111)
  ConnectionInterrupted,

  /// The Internet connection is lost. This applies to the Agora Web SDK only.
  @JsonValue(112)
  ConnectionLost,

  /// The user is not in the channel when calling the `sendStreamMessage` or `getUserInfoByUserAccount` method.
  /// See [RtcEngine.sendStreamMessage]
  /// See [RtcEngine.getUserInfoByUserAccount]
  @JsonValue(113)
  NotInChannel,

  /// The size of the sent data is over 1024 bytes when the user calls the `sendStreamMessage` method.
  /// See [RtcEngine.sendStreamMessage]
  @JsonValue(114)
  SizeTooLarge,

  /// The bitrate of the sent data exceeds the limit of 6 Kbps when the user calls the `sendStreamMessage` method.
  /// See [RtcEngine.sendStreamMessage]
  @JsonValue(115)
  BitrateLimit,

  /// Too many data streams (over five streams) are created when the user calls the `createDataStream` method.
  /// See [RtcEngine.createDataStream]
  @JsonValue(116)
  TooManyDataStreams,

  /// Decryption fails. The user may have used a different encryption password to join the channel. Check your settings or try rejoining the channel.
  @JsonValue(120)
  DecryptionFailed,

  /// The client is banned by the server.
  @JsonValue(123)
  ClientIsBannedByServer,

  /// Incorrect watermark file parameter.
  @JsonValue(124)
  WatermarkParam,

  /// Incorrect watermark file path.
  @JsonValue(125)
  WatermarkPath,

  /// Incorrect watermark file format.
  @JsonValue(126)
  WatermarkPng,

  /// Incorrect watermark file information.
  @JsonValue(127)
  WatermarkInfo,

  /// Incorrect watermark file data format.
  @JsonValue(128)
  WatermarkAGRB,

  /// An error occurs in reading the watermark file.
  @JsonValue(129)
  WatermarkRead,

  /// The encrypted stream is not allowed to publish.
  @JsonValue(130)
  EncryptedStreamNotAllowedPublish,

  /// The user account is invalid.
  @JsonValue(134)
  InvalidUserAccount,

  /// CDN related errors. Remove the original URL address and add a new one by calling the `removePublishStreamUrl` and `addPublishStreamUrl` methods.
  /// See [RtcEngine.removePublishStreamUrl]
  /// See [RtcEngine.addPublishStreamUrl]
  @JsonValue(151)
  PublishStreamCDNError,

  /// The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones.
  @JsonValue(152)
  PublishStreamNumReachLimit,

  /// The host manipulates other hosts' URLs. Check your app logic.
  @JsonValue(153)
  PublishStreamNotAuthorized,

  /// An error occurs in Agora’s streaming server. Call the `addPublishStreamUrl` method to publish the stream again.
  /// See [RtcEngine.addPublishStreamUrl]
  @JsonValue(154)
  PublishStreamInternalServerError,

  /// The server fails to find the stream.
  @JsonValue(155)
  PublishStreamNotFound,

  /// The format of the RTMP stream URL is not supported. Check whether the URL format is correct.
  @JsonValue(156)
  PublishStreamFormatNotSuppported,

  /// Fails to load the media engine.
  @JsonValue(1001)
  LoadMediaEngine,

  /// Fails to start the call after enabling the media engine.
  @JsonValue(1002)
  StartCall,

  /// Fails to start the camera. Agora recommends that you use `CaptureFailure`(4) in the error parameter of `localVideoStateChanged` instead.
  /// See [LocalVideoStreamError.CaptureFailure]
  /// See [RtcEngineEventHandler.localVideoStateChanged]
  @deprecated
  @JsonValue(1003)
  StartCamera,

  /// Fails to start the video rendering module.
  @JsonValue(1004)
  StartVideoRender,

  /// Audio Device Module: A general error occurs in the Audio Device Module (the reason is not classified specifically). Check if the audio device is used by another app, or try rejoining the channel.
  @JsonValue(1005)
  AdmGeneralError,

  /// Audio Device Module: An error occurs in using the Java resources.
  @JsonValue(1006)
  AdmJavaResource,

  /// Audio Device Module: An error occurs in setting the sampling frequency.
  @JsonValue(1007)
  AdmSampleRate,

  /// Audio Device Module: An error occurs in initializing the playback device.
  @JsonValue(1008)
  AdmInitPlayout,

  /// Audio Device Module: An error occurs in starting the playback device.
  @JsonValue(1009)
  AdmStartPlayout,

  /// Audio Device Module: An error occurs in stopping the playback device.
  @JsonValue(1010)
  AdmStopPlayout,

  /// Audio Device Module: An error occurs in initializing the recording device.
  @JsonValue(1011)
  AdmInitRecording,

  /// Audio Device Module: An error occurs in starting the recording device.
  @JsonValue(1012)
  AdmStartRecording,

  /// Audio Device Module: An error occurs in stopping the recording device.
  @JsonValue(1013)
  AdmStopRecording,

  /// Audio Device Module: A playback error occurs. Check your playback device, or try rejoining the channel.
  @JsonValue(1015)
  AdmRuntimePlayoutError,

  /// Audio Device Module: A recording error occurs.
  @JsonValue(1017)
  AdmRuntimeRecordingError,

  /// Audio Device Module: Fails to record.
  @JsonValue(1018)
  AdmRecordAudioFailed,

  /// Audio Device Module: Abnormal audio playback frequency.
  @JsonValue(1020)
  AdmPlayAbnormalFrequency,

  /// Audio Device Module: Abnormal audio recording frequency.
  @JsonValue(1021)
  AdmRecordAbnormalFrequency,

  /// Audio Device Module: An error occurs in initializing the loopback device.
  @JsonValue(1022)
  AdmInitLoopback,

  /// Audio Device Module: An error occurs in starting the loopback device.
  @JsonValue(1023)
  AdmStartLoopback,

  /// Audio Device Module: An error occurs in no recording Permission.
  @JsonValue(1027)
  AdmNoPermission,

  /// Audio Routing: Fails to route the audio to the connected Bluetooth device. The default route is used.
  @JsonValue(1030)
  AudioBtScoFailed,

  /// Audio Device Module: No recording device exists.
  @JsonValue(1359)
  AdmNoRecordingDevice,

  /// No playback device exists.
  @JsonValue(1360)
  AdmNoPlayoutDevice,

  /// Video Device Module: The camera is unauthorized.
  @JsonValue(1501)
  VdmCameraNotAuthorized,

  /// Video Device Module: An unknown error occurs.
  @JsonValue(1600)
  VcmUnknownError,

  /// Video Device Module: An error occurs in initializing the video encoder.
  @JsonValue(1601)
  VcmEncoderInitError,

  /// Video Device Module: An error occurs in video encoding.
  @JsonValue(1602)
  VcmEncoderEncodeError,

  /// Video Device Module: An error occurs in setting the video encoder.
  @deprecated
  @JsonValue(1603)
  VcmEncoderSetError,
}

/// State of importing an external video stream in a live broadcast.
/// @enum {number}
enum InjectStreamStatus {
  /// The external video stream imported successfully.
  @JsonValue(0)
  StartSuccess,

  /// The external video stream already exists.
  @JsonValue(1)
  StartAlreadyExists,

  /// The external video stream import is unauthorized.
  @JsonValue(2)
  StartUnauthorized,

  /// Import external video stream timeout.
  @JsonValue(3)
  StartTimedout,

  /// The external video stream failed to import.
  @JsonValue(4)
  StartFailed,

  /// The external video stream imports successfully.
  @JsonValue(5)
  StopSuccess,

  /// No external video stream is found.
  @JsonValue(6)
  StopNotFound,

  /// The external video stream is stopped from being unauthorized.
  @JsonValue(7)
  StopUnauthorized,

  /// Importing the external video stream timeout.
  @JsonValue(8)
  StopTimedout,

  /// Importing the external video stream failed.
  @JsonValue(9)
  StopFailed,

  /// The external video stream import is interrupted.
  @JsonValue(10)
  Broken,
}

/// The state of the probe test result.
/// @enum {number}
enum LastmileProbeResultState {
  /// The last-mile network probe test is complete.
  @JsonValue(1)
  Complete,

  /// The last-mile network probe test is incomplete and the bandwidth estimation is not available, probably due to limited test resources.
  @JsonValue(2)
  IncompleteNoBwe,

  /// The last-mile network probe test is not carried out, probably due to poor network conditions.
  @JsonValue(3)
  Unavailable,
}

/// The lightening contrast level.
/// @enum {number}
enum LighteningContrastLevel {
  /// Low contrast level.
  @JsonValue(0)
  Low,

  /// (Default) Normal contrast level.
  @JsonValue(1)
  Normal,

  /// High contrast level.
  @JsonValue(2)
  High,
}

/// The detailed error information of the local video.
/// @enum {number}
enum LocalVideoStreamError {
  /// The local video is normal.
  @JsonValue(0)
  OK,

  /// No specified reason for the local video failure.
  @JsonValue(1)
  Failure,

  /// No permission to use the local video device.
  @JsonValue(2)
  DeviceNoPermission,

  /// The local video capturer is in use.
  @JsonValue(3)
  DeviceBusy,

  /// The local video capture fails. Check whether the capturer is working properly.
  @JsonValue(4)
  CaptureFailure,

  /// The local video encoding fails.
  @JsonValue(5)
  EncodeFailure,
}

/// The state of the local video stream.
/// @enum {number}
enum LocalVideoStreamState {
  /// The local video is in the initial state.
  @JsonValue(0)
  Stopped,

  /// The local video capturer starts successfully.
  @JsonValue(1)
  Capturing,

  /// The first local video frame encodes successfully.
  @JsonValue(2)
  Encoding,

  /// The local video fails to start.
  @JsonValue(3)
  Failed,
}

/// Output log filter level.
/// @enum {number}
enum LogFilter {
  /// Do not output any log information.
  @JsonValue(0)
  Off,

  /// Output all log information. Set your log filter as debug if you want to get the most complete log file.
  @JsonValue(0x080f)
  Debug,

  /// Output CRITICAL, ERROR, WARNING, and INFO level log information. We recommend setting your log filter as this level.
  @JsonValue(0x000f)
  Info,

  /// Outputs CRITICAL, ERROR, and WARNING level log information.
  @JsonValue(0x000e)
  Warning,

  /// Outputs CRITICAL and ERROR level log information.
  @JsonValue(0x000c)
  Error,

  /// Outputs CRITICAL level log information.
  @JsonValue(0x0008)
  Critical,
}

/// (iOS only) Media device type.
/// @enum {number}
/// TODO @nodoc MacOS AgoraMediaDeviceType
enum MediaDeviceType {
  /// Unknown device.
  @JsonValue(-1)
  AudioUnknown,

  /// Audio playback device.
  @JsonValue(0)
  AudioPlayout,

  /// Audio recording device.
  @JsonValue(1)
  AudioRecording,

  /// Video render device.
  @JsonValue(2)
  VideoRender,

  /// Video capture device.
  @JsonValue(3)
  VideoCapture,
}

/// Media type.
/// @enum {number}
/// TODO @nodoc LiveEngine
enum MediaType {
  /// No audio and video.
  @JsonValue(0)
  None,

  /// Audio only.
  @JsonValue(1)
  AudioOnly,

  /// Video only.
  @JsonValue(2)
  VideoOnly,

  /// Audio and video.
  @JsonValue(3)
  AudioAndVideo,
}

/// (Android only) The metadata type.
/// @enum {number}
/// TODO @nodoc registerMediaMetadataObserver
enum MetadataType {
  /// The metadata type is unknown.
  @JsonValue(-1)
  Unknown,

  /// The metadata type is video.
  @JsonValue(0)
  Video,
}

/// Network quality.
/// @enum {number}
enum NetworkQuality {
  /// The network quality is unknown.
  @JsonValue(0)
  Unknown,

  /// The network quality is excellent.
  @JsonValue(1)
  Excellent,

  /// The network quality is quite good, but the bitrate may be slightly lower than excellent.
  @JsonValue(2)
  Good,

  /// Users can feel the communication slightly impaired.
  @JsonValue(3)
  Poor,

  /// Users can communicate only not very smoothly.
  @JsonValue(4)
  Bad,

  /// The network quality is so bad that users can hardly communicate.
  @JsonValue(5)
  VBad,

  /// The network is disconnected and users cannot communicate at all.
  @JsonValue(6)
  Down,

  /// Users cannot detect the network quality. (Not in use.)
  @JsonValue(7)
  Unsupported,

  /// Detecting the network quality.
  @JsonValue(8)
  Detecting,
}

/// Network type.
/// @enum {number}
enum NetworkType {
  /// The network type is unknown.
  @JsonValue(-1)
  Unknown,

  /// The SDK disconnects from the network.
  @JsonValue(0)
  Disconnected,

  /// The network type is LAN.
  @JsonValue(1)
  LAN,

  /// The network type is Wi-Fi (including hotspots).
  @JsonValue(2)
  WIFI,

  /// The network type is mobile 2G.
  @JsonValue(3)
  Mobile2G,

  /// The network type is mobile 3G.
  @JsonValue(4)
  Mobile3G,

  /// The network type is mobile 4G.
  @JsonValue(5)
  Mobile4G,
}

/// (Android only) Default camera position
/// @enum {number}
/// TODO @nodoc AgoraRtcDefaultCamera
enum RtcDefaultCameraPosition {
  /// Front camera
  @JsonValue(0)
  Front,

  /// Rear camera
  @JsonValue(1)
  Back
}

/// Lifecycle of the CDN live video stream.
/// @enum {number}
/// TODO @nodoc AgoraPublisherConfiguration
enum RtmpStreamLifeCycle {
  /// Bound to the channel lifecycle. If all hosts leave the channel, the CDN live streaming stops after 30 seconds.
  @JsonValue(1)
  BindToChannel,

  /// Bound to the owner of the RTMP stream. If the owner leaves the channel, the CDN live streaming stops immediately.
  @JsonValue(2)
  BindToOwnner,
}

/// The detailed error information for streaming.
/// @enum {number}
enum RtmpStreamingErrorCode {
  /// The RTMP streaming publishes successfully.
  @JsonValue(0)
  OK,

  /// Invalid argument used. If, for example, you do not call the `setLiveTranscoding` method to configure the LiveTranscoding parameters before calling the `addPublishStreamUrl` method, the SDK returns this error. Check whether you set the parameters in the `setLiveTranscoding` method properly.
  /// See [RtcEngine.setLiveTranscoding]
  /// See [RtcEngine.addPublishStreamUrl]
  @JsonValue(1)
  InvalidParameters,

  /// The RTMP streaming is encrypted and cannot be published.
  @JsonValue(2)
  EncryptedStreamNotAllowed,

  /// Timeout for the RTMP streaming. Call the `addPublishStreamUrl` method to publish the streaming again.
  /// See [RtcEngine.addPublishStreamUrl]
  @JsonValue(3)
  ConnectionTimeout,

  /// An error occurs in Agora’s streaming server. Call the `addPublishStreamUrl` method to publish the streaming again.
  /// See [RtcEngine.addPublishStreamUrl]
  @JsonValue(4)
  InternalServerError,

  /// An error occurs in the RTMP server.
  @JsonValue(5)
  RtmpServerError,

  /// The RTMP streaming publishes too frequently.
  @JsonValue(6)
  TooOften,

  /// The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones.
  @JsonValue(7)
  ReachLimit,

  /// The host manipulates other hosts' URLs. Check your app logic.
  @JsonValue(8)
  NotAuthorized,

  /// Agora’s server fails to find the RTMP streaming.
  @JsonValue(9)
  StreamNotFound,

  /// The format of the RTMP streaming URL is not supported. Check whether the URL format is correct.
  @JsonValue(10)
  FormatNotSupported,
}

/// The RTMP streaming state.
/// @enum {number}
enum RtmpStreamingState {
  /// The RTMP streaming has not started or has ended. This state is also triggered after you remove an RTMP address from the CDN by calling `removePublishStreamUrl`.
  /// See [RtcEngine.removePublishStreamUrl]
  @JsonValue(0)
  Idle,

  /// The SDK is connecting to Agora’s streaming server and the RTMP server. This state is triggered after you call the `addPublishStreamUrl` method.
  /// See [RtcEngine.addPublishStreamUrl]
  @JsonValue(1)
  Connecting,

  /// The RTMP streaming is being published. The SDK successfully publishes the RTMP streaming and returns this state.
  @JsonValue(2)
  Running,

  /// The RTMP streaming is recovering. When exceptions occur to the CDN, or the streaming is interrupted, the SDK attempts to resume RTMP streaming and returns this state.
  /// - If the SDK successfully resumes the streaming, `Running`(2) returns.
  /// See [RtmpStreamingState.Running]
  /// - If the streaming does not resume within 60 seconds or server errors occur, `Failure`(4) returns. You can also reconnect to the server by calling the `removePublishStreamUrl` and `addPublishStreamUrl` methods.
  /// See [RtmpStreamingState.Failure]
  /// See [RtcEngine.removePublishStreamUrl]
  /// See [RtcEngine.addPublishStreamUrl]
  @JsonValue(3)
  Recovering,

  /// The RTMP streaming fails. See the `errorCode` parameter for the detailed error information. You can also call the `addPublishStreamUrl` method to publish the RTMP streaming again.
  /// See [RtcEngine.addPublishStreamUrl]
  @JsonValue(4)
  Failure,
}

/// Stream fallback option.
/// @enum {number}
enum StreamFallbackOptions {
  /// No fallback behavior for the local/remote video stream when the uplink/downlink network condition is unreliable. The quality of the stream is not guaranteed.
  @JsonValue(0)
  Disabled,

  /// Under unreliable downlink network conditions, the remote video stream falls back to the low-stream (low resolution and low bitrate) video. You can only set this option in the `setRemoteSubscribeFallbackOption` method. Nothing happens when you set this in the `setLocalPublishFallbackOption` method.
  /// See [RtcEngine.setRemoteSubscribeFallbackOption]
  /// See [RtcEngine.setLocalPublishFallbackOption]
  @JsonValue(1)
  VideoStreamLow,

  /// Under unreliable uplink network conditions, the published video stream falls back to audio only. Under unreliable downlink network conditions, the remote video stream first falls back to the low-stream (low resolution and low bitrate) video; and then to an audio-only stream if the network condition deteriorates.
  @JsonValue(2)
  AudioOnly,
}

/// Reason for the user being offline.
/// @enum {number}
enum UserOfflineReason {
  /// The user left the current channel.
  @JsonValue(0)
  Quit,

  /// The SDK timed out and the user dropped offline because no data packet is received within a certain period of time. If a user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the user dropped offline.
  @JsonValue(1)
  Dropped,

  /// (LiveBroadcasting only) The client role switched from the host to the audience.
  @JsonValue(2)
  BecomeAudience,
}

/// The priority of the remote user.
/// @enum {number}
enum UserPriority {
  /// The user’s priority is high.
  @JsonValue(50)
  High,

  /// (Default) The user’s priority is normal.
  @JsonValue(100)
  Normal,
}

/// (iOS only) Video buffer type.
/// @enum {number}
/// TODO @nodoc iOS AgoraVideoSourceProtocol AgoraVideoSinkProtocol
enum VideoBufferType {
  /// Use a pixel buffer to transmit the video data.
  @JsonValue(1)
  PixelBuffer,

  /// Use raw data to transmit the video data.
  @JsonValue(2)
  RawData,
}

/// Self-defined video codec profile.
/// @enum {number}
enum VideoCodecProfileType {
  /// Baseline video codec profile. Generally used in video calls on mobile phones.
  @JsonValue(66)
  BaseLine,

  /// Main video codec profile. Generally used in mainstream electronics, such as MP4 players, portable video players, PSP, and iPads.
  @JsonValue(77)
  Main,

  /// (Default) High video codec profile. Generally used in high-resolution broadcasts or television.
  @JsonValue(100)
  High,
}

/// (iOS only) The content hint for screen sharing.
/// @enum {number}
/// TODO @nodoc MacOS setScreenCaptureContentHint
enum VideoContentHint {
  /// (Default) No content hint.
  @JsonValue(0)
  None,

  /// Motion-intensive content. Choose this option if you prefer smoothness or when you are sharing a video clip, movie, or video game.
  @JsonValue(1)
  Motion,

  /// Motionless content. Choose this option if you prefer sharpness or when you are sharing a picture, PowerPoint slide, or text.
  @JsonValue(2)
  Details,
}

/// Video frame rate.
/// @enum {number}
enum VideoFrameRate {
  /// Min
  @JsonValue(-1)
  Min,

  /// 1 fps.
  @JsonValue(1)
  Fps1,

  /// 7 fps.
  @JsonValue(7)
  Fps7,

  /// 10 fps.
  @JsonValue(10)
  Fps10,

  /// 15 fps.
  @JsonValue(15)
  Fps15,

  /// 24 fps.
  @JsonValue(24)
  Fps24,

  /// 30 fps.
  @JsonValue(30)
  Fps30,

  /// 60 fps (macOS only).
  @JsonValue(60)
  Fps60,
}

/// Sets the video bitrate (Kbps). Refer to the table below and set your bitrate. If you set a bitrate beyond the proper range, the SDK automatically adjusts it to a value within the range. You can also choose from the following options:
/// @enum {number}
enum BitRate {
  /// (Recommended) The standard bitrate mode. In this mode, the bitrates differ between the LiveBroadcasting and Communication profiles:
  /// - Communication profile: the video bitrate is the same as the base bitrate.
  /// - LiveBroadcasting profile: the video bitrate is twice the base bitrate.
  @JsonValue(0)
  Standard,

  /// The compatible bitrate mode. In this mode, the bitrate stays the same regardless of the profile. In the LiveBroadcasting profile, if you choose this mode, the video frame rate may be lower than the set value.
  @JsonValue(-1)
  Compatible,
}

/// Video mirror mode.
/// @enum {number}
enum VideoMirrorMode {
  /// (Default) The SDK determines the mirror mode.
  @JsonValue(0)
  Auto,

  /// Enables mirror mode.
  @JsonValue(1)
  Enabled,

  /// Disables mirror mode.
  @JsonValue(2)
  Disabled,
}

/// Video output orientation mode.
/// @enum {number}
enum VideoOutputOrientationMode {
  /// Adaptive mode (Default).
  /// The video encoder adapts to the orientation mode of the video input device. When you use a custom video source, the output video from the encoder inherits the orientation of the original video.
  /// - If the width of the captured video from the SDK is greater than the height, the encoder sends the video in landscape mode. The encoder also sends the rotational information of the video, and the receiver uses the rotational information to rotate the received video.
  /// - If the original video is in portrait mode, the output video from the encoder is also in portrait mode. The encoder also sends the rotational information of the video to the receiver.
  @JsonValue(0)
  Adaptative,

  /// Landscape mode.
  /// The video encoder always sends the video in landscape mode. The video encoder rotates the original video before sending it and the rotational information is 0. This mode applies to scenarios involving CDN live streaming.
  @JsonValue(1)
  FixedLandscape,

  /// Portrait mode.
  /// The video encoder always sends the video in portrait mode. The video encoder rotates the original video before sending it and the rotational information is 0. This mode applies to scenarios involving CDN live streaming.
  @JsonValue(2)
  FixedPortrait,
}

/// (iOS only) Video pixel format.
/// @enum {number}
/// TODO @nodoc iOS AgoraVideoSinkProtocol
enum VideoPixelFormat {
  /// The video pixel format is I420.
  @JsonValue(1)
  I420,

  /// The video pixel format is BGRA.
  @JsonValue(2)
  BGRA,

  /// The video pixel format is NV21.
  @JsonValue(8)
  NV12,
}

/// Quality change of the local video in terms of target frame rate and target bit rate since last count.
/// @enum {number}
enum VideoQualityAdaptIndication {
  /// The quality of the local video stays the same.
  @JsonValue(0)
  AdaptNone,

  /// The quality improves because the network bandwidth increases.
  @JsonValue(1)
  AdaptUpBandwidth,

  /// The quality worsens because the network bandwidth decreases.
  @JsonValue(2)
  AdaptDownBandwidth,
}

/// The state of the remote video.
/// @enum {number}
enum VideoRemoteState {
  /// The remote video is in the default state, probably due to:
  /// See [VideoRemoteStateReason.LocalMuted]
  /// See [VideoRemoteStateReason.RemoteMuted]
  /// See [VideoRemoteStateReason.RemoteOffline]
  @JsonValue(0)
  Stopped,

  /// The first remote video packet is received.
  @JsonValue(1)
  Starting,

  /// The remote video stream is decoded and plays normally, probably due to:
  /// - [VideoRemoteStateReason.NetworkRecovery]
  /// - [VideoRemoteStateReason.LocalUnmuted]
  /// - [VideoRemoteStateReason.RemoteUnmuted]
  /// - [VideoRemoteStateReason.AudioFallbackRecovery]
  @JsonValue(2)
  Decoding,

  /// The remote video is frozen, probably due to:
  /// - [VideoRemoteStateReason.NetworkCongestion]
  /// - [VideoRemoteStateReason.AudioFallback]
  @JsonValue(3)
  Frozen,

  /// The remote video fails to start, probably due to [VideoRemoteStateReason.Internal].
  @JsonValue(4)
  Failed,
}

/// The reason of the remote video state change.
/// @enum {number}
enum VideoRemoteStateReason {
  /// Internal reasons.
  @JsonValue(0)
  Internal,

  /// Network congestion.
  @JsonValue(1)
  NetworkCongestion,

  /// Network recovery.
  @JsonValue(2)
  NetworkRecovery,

  /// The local user stops receiving the remote video stream or disables the video module.
  @JsonValue(3)
  LocalMuted,

  /// The local user stops receiving the remote video stream or disables the video module.
  @JsonValue(4)
  LocalUnmuted,

  /// The remote user stops sending the video stream or disables the video module.
  @JsonValue(5)
  RemoteMuted,

  /// The remote user resumes sending the video stream or enables the video module.
  @JsonValue(6)
  RemoteUnmuted,

  /// The remote user leaves the channel.
  @JsonValue(7)
  RemoteOffline,

  /// The remote media stream falls back to the audio-only stream due to poor network conditions.
  @JsonValue(8)
  AudioFallback,

  /// The remote media stream switches back to the video stream after the network conditions improve.
  @JsonValue(9)
  AudioFallbackRecovery,
}

/// Video display mode.
/// @enum {number}
enum VideoRenderMode {
  /// Uniformly scale the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents.
  @JsonValue(1)
  Hidden,

  /// Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio are filled with black.
  @JsonValue(2)
  Fit,

  /// This mode is deprecated.
  @deprecated
  @JsonValue(3)
  Adaptive,

  /// The fill mode. In this mode, the SDK stretches or zooms the video to fill the display window.
  @JsonValue(4)
  FILL,
}

/// (iOS only) Video rotation.
/// @enum {number}
/// TODO @nodoc iOS AgoraVideoSourceProtocol AgoraVideoSinkProtocol
enum VideoRotation {
  /// No rotation
  @JsonValue(0)
  RotationNone,

  /// 90 degrees
  @JsonValue(1)
  Rotation90,

  /// 180 degrees
  @JsonValue(2)
  Rotation180,

  /// 270 degrees
  @JsonValue(3)
  Rotation270,
}

/// Video stream type.
/// @enum {number}
enum VideoStreamType {
  /// High-bitrate, high-resolution video stream.
  @JsonValue(0)
  High,

  /// Low-bitrate, low-resolution video stream.
  @JsonValue(1)
  Low,
}

/// Warning codes occur when the SDK encounters an error that may be recovered automatically. These are only notifications, and can generally be ignored. For example, when the SDK loses connection to the server, the SDK reports the `OpenChannelTimeout`(106) warning and tries to reconnect automatically.
/// See [WarningCode.OpenChannelTimeout]
/// @enum {number}
enum WarningCode {
  /// The specified view is invalid. Specify a view when using the video call function.
  @JsonValue(8)
  InvalidView,

  /// Failed to initialize the video function, possibly caused by a lack of resources. The users cannot see the video while the voice communication is not affected.
  @JsonValue(16)
  InitVideo,

  /// The request is pending, usually due to some module not being ready, and the SDK postpones processing the request.
  @JsonValue(20)
  Pending,

  /// No channel resources are available. Maybe because the server cannot allocate any channel resource.
  @JsonValue(103)
  NoAvailableChannel,

  /// A timeout occurs when looking up the channel. When joining a channel, the SDK looks up the specified channel. The warning usually occurs when the network condition is too poor for the SDK to connect to the server.
  @JsonValue(104)
  LookupChannelTimeout,

  /// The server rejects the request to look up the channel. The server cannot process this request or the request is illegal. Agora recommends that you use `RejectedByServer`(10) in the reason parameter of `connectionStateChanged` instead.
  /// See [ConnectionChangedReason.RejectedByServer]
  /// See [RtcEngineEventHandler.connectionStateChanged]
  @deprecated
  @JsonValue(105)
  LookupChannelRejected,

  /// The server rejects the request to look up the channel. The server cannot process this request or the request is illegal.
  @JsonValue(106)
  OpenChannelTimeout,

  /// The server rejects the request to open the channel. The server cannot process this request or the request is illegal.
  @JsonValue(107)
  OpenChannelRejected,

  /// A timeout occurs when switching to the live video.
  @JsonValue(111)
  SwitchLiveVideoTimeout,

  /// A timeout occurs when setting the client role in the LiveBroadcasting profile.
  @JsonValue(118)
  SetClientRoleTimeout,

  /// The client role is unauthorized.
  @JsonValue(119)
  SetClientRoleNotAuthorized,

  /// The ticket to open the channel is invalid.
  @JsonValue(121)
  OpenChannelInvalidTicket,

  /// Try connecting to another server.
  @JsonValue(122)
  OpenChannelTryNextVos,

  /// An error occurs in opening the audio mixing file.
  @JsonValue(701)
  AudioMixingOpenError,

  /// Audio Device Module: a warning occurs in the playback device.
  @JsonValue(1014)
  AdmRuntimePlayoutWarning,

  /// Audio Device Module: a warning occurs in the recording device.
  @JsonValue(1016)
  AdmRuntimeRecordingWarning,

  /// Audio Device Module: no valid audio data is collected.
  @JsonValue(1019)
  AdmRecordAudioSilence,

  /// Audio Device Module: a playback device fails.
  @JsonValue(1020)
  AdmPlaybackMalfunction,

  /// Audio Device Module: a recording device fails.
  @JsonValue(1021)
  AdmRecordMalfunction,

  /// Audio Device Module: call is interrupted by system events such as phone call or siri etc.
  @JsonValue(1025)
  AdmInterruption,

  /// Audio Device Module: the recorded audio is too low.
  @JsonValue(1031)
  AdmRecordAudioLowlevel,

  /// Audio Device Module: the playback audio is too low.
  @JsonValue(1032)
  AdmPlayoutAudioLowlevel,

  /// Audio Device Module: The recording device is busy.
  @JsonValue(1033)
  AdmRecordIsOccupied,

  /// Audio Device Module: howling is detected.
  @JsonValue(1051)
  ApmHowling,

  /// Audio Device Module: the device is in the glitch state.
  @JsonValue(1052)
  AdmGlitchState,

  /// Audio Device Module: the underlying audio settings have changed.
  @JsonValue(1053)
  AdmImproperSettings,
}

/// The audio channel of the sound.
/// @enum {number}
enum AudioChannel {
  /// (Default) Supports dual channels. Depends on the upstream of the broadcaster.
  @JsonValue(0)
  Channel0,

  /// The audio stream of the broadcaster uses the FL audio channel. If the upstream of the broadcaster uses multiple audio channels, these channels will be mixed into mono first.
  @JsonValue(1)
  Channel1,

  /// The audio stream of the broadcaster uses the FC audio channel. If the upstream of the broadcaster uses multiple audio channels, these channels will be mixed into mono first.
  @JsonValue(2)
  Channel2,

  /// The audio stream of the broadcaster uses the FR audio channel. If the upstream of the broadcaster uses multiple audio channels, these channels will be mixed into mono first.
  @JsonValue(3)
  Channel3,

  /// The audio stream of the broadcaster uses the BL audio channel. If the upstream of the broadcaster uses multiple audio channels, these channels will be mixed into mono first.
  @JsonValue(4)
  Channel4,

  /// The audio stream of the broadcaster uses the BR audio channel. If the upstream of the broadcaster uses multiple audio channels, these channels will be mixed into mono first.
  @JsonValue(5)
  Channel5,
}

/// Video codec types.
/// @enum {number}
enum VideoCodecType {
  /// Standard VP8.
  @JsonValue(1)
  VP8,

  /// Standard H264.
  @JsonValue(2)
  H264,

  /// Enhanced VP8.
  @JsonValue(3)
  EVP,

  /// Enhanced H264.
  @JsonValue(4)
  E264,
}
