
import 'package:flutter/material.dart';
import 'zego_express_impl.dart';

/// Application scenario
enum ZegoScenario {
  /// General scenario
  General,
  /// Communication scenario
  Communication,
  /// Live scenario
  Live
}

/// Language
enum ZegoLanguage {
  /// English
  English,
  /// Chinese
  Chinese
}

/// Room state
enum ZegoRoomState {
  /// Unconnected state, enter this state before logging in and after exiting the room. If there is a steady state abnormality in the process of logging in to the room, such as AppID and AppSign are incorrect, or if the same user name is logged in elsewhere and the local end is KickOut, it will enter this state.
  Disconnected,
  /// The state that the connection is being requested. It will enter this state after successful execution login room function. The display of the application interface is usually performed using this state. If the connection is interrupted due to poor network quality, the SDK will perform an internal retry and will return to the requesting connection status.
  Connecting,
  /// The status that is successfully connected. Entering this status indicates that the login to the room has been successful. The user can receive the callback notification of the user and the stream information in the room.
  Connected
}

/// Publish channel
enum ZegoPublishChannel {
  /// Main publish channel
  Main,
  /// Auxiliary publish channel
  Aux
}

/// Video rendering mode
enum ZegoViewMode {
  /// The proportional scaling up, there may be black borders
  AspectFit,
  /// The proportional zoom fills the entire View and may be partially cut
  AspectFill,
  /// Fill the entire view, the image may be stretched
  ScaleToFill
}

/// Mirror mode for previewing or playing the  of the stream
enum ZegoVideoMirrorMode {
  /// The mirror image only for previewing locally. This mode is used by default.
  OnlyPreviewMirror,
  /// Both the video previewed locally and the far end playing the stream will see mirror image.
  BothMirror,
  /// Both the video previewed locally and the far end playing the stream will not see mirror image.
  NoMirror,
  /// The mirror image only for far end playing the stream.
  OnlyPublishMirror
}

/// Publish stream status
enum ZegoPublisherState {
  /// The state is not published, and it is in this state before publishing the stream. If a steady-state exception occurs in the publish process, such as AppID and AppSign are incorrect, or if other users are already publishing the stream, there will be a failure and enter this state.
  NoPublish,
  /// The state that it is requesting to publish the stream. After the publish stream interface is successfully called, and the application interface is usually displayed using the state. If the connection is interrupted due to poor network quality, the SDK will perform an internal retry and will return to the requesting state.
  PublishRequesting,
  /// The state that the stream is being published, entering the state indicates that the stream has been successfully published, and the user can communicate normally.
  Publishing
}

/// Video configuration resolution and bitrate preset enumeration. The preset resolutions are adapted for mobile and desktop. On mobile, height is longer than width, and desktop is the opposite. For example, 1080p is actually 1080(w) x 1920(h) on mobile and 1920(w) x 1080(h) on desktop.
enum ZegoVideoConfigPreset {
  /// Set the resolution to 320x180, the default is 15 fps, the code rate is 300 kbps
  Preset180P,
  /// Set the resolution to 480x270, the default is 15 fps, the code rate is 400 kbps
  Preset270P,
  /// Set the resolution to 640x360, the default is 15 fps, the code rate is 600 kbps
  Preset360P,
  /// Set the resolution to 960x540, the default is 15 fps, the code rate is 1200 kbps
  Preset540P,
  /// Set the resolution to 1280x720, the default is 15 fps, the code rate is 1500 kbps
  Preset720P,
  /// Set the resolution to 1920x1080, the default is 15 fps, the code rate is 3000 kbps
  Preset1080P
}

/// Stream quality level
enum ZegoStreamQualityLevel {
  /// Excellent
  Excellent,
  /// Good
  Good,
  /// Normal
  Medium,
  /// Bad
  Bad,
  /// Failed
  Die
}

/// Audio channel type
enum ZegoAudioChannel {
  /// MONO
  Mono,
  /// STEREO
  Stereo
}

/// Audio Codec ID
enum ZegoAudioCodecID {
  /// default
  Default,
  /// Normal
  Normal,
  /// Normal2
  Normal2,
  /// Normal3
  Normal3,
  /// Low
  Low,
  /// Low2
  Low2,
  /// Low3
  Low3
}

/// Video Codec ID
enum ZegoVideoCodecID {
  /// default
  Default,
  /// SVC
  Svc,
  /// VP8
  Vp8
}

/// Player video layer
enum ZegoPlayerVideoLayer {
  /// The layer to be played depends on the network status
  Auto,
  /// Play the base layer (small resolution)
  Base,
  /// Play the extend layer (big resolution)
  BaseExtend
}

/// Audio echo cancellation mode
enum ZegoAECMode {
  /// Aggressive echo cancellation may affect the sound quality slightly, but the echo will be very clean
  Aggressive,
  /// Moderate echo cancellation, which may slightly affect a little bit of sound, but the residual echo will be less
  Medium,
  /// Comfortable echo cancellation, that is, echo cancellation does not affect the sound quality of the sound, and sometimes there may be a little echo, but it will not affect the normal listening.
  Soft
}

/// Traffic control property (bitmask enumeration)
class ZegoTrafficControlProperty {
  /// Basic
  static const int Basic = 0;
  /// Adaptive FPS
  static const int AdaptiveFPS = 1;
  /// Adaptive resolution
  static const int AdaptiveResolution = 1 << 1;
  /// Adaptive Audio bitrate
  static const int AdaptiveAudioBitrate = 1 << 2;
}

/// Video transmission mode when current bitrate is lower than the set minimum bitrate
enum ZegoTrafficControlMinVideoBitrateMode {
  /// Stop video transmission when current bitrate is lower than the set minimum bitrate
  NoVideo,
  /// Video is sent at a very low frequency (no more than 2fps) which is lower than the set minimum bitrate
  UltraLowFPS
}

/// Playing stream status
enum ZegoPlayerState {
  /// The state of the flow is not played, and it is in this state before the stream is played. If the steady flow anomaly occurs during the playing process, such as AppID and AppSign are incorrect, it will enter this state.
  NoPlay,
  /// The state that the stream is being requested for playing. After the stream playing interface is successfully called, it will enter the state, and the application interface is usually displayed using this state. If the connection is interrupted due to poor network quality, the SDK will perform an internal retry and will return to the requesting state.
  PlayRequesting,
  /// The state that the stream is being playing, entering the state indicates that the stream has been successfully played, and the user can communicate normally.
  Playing
}

/// Media event when playing
enum ZegoPlayerMediaEvent {
  /// Audio stuck event when playing
  AudioBreakOccur,
  /// Audio stuck event recovery when playing
  AudioBreakResume,
  /// Video stuck event when playing
  VideoBreakOccur,
  /// Video stuck event recovery when playing
  VideoBreakResume
}

/// Update type
enum ZegoUpdateType {
  /// Add
  Add,
  /// Delete
  Delete
}

/// State of CDN relay
enum ZegoStreamRelayCDNState {
  /// The state indicates that there is no CDN relay
  NoRelay,
  /// The CDN relay is being requested
  RelayRequesting,
  /// Entering this status indicates that the CDN relay has been successful
  Relaying
}

/// Reason for state of CDN relay changed
enum ZegoStreamRelayCDNUpdateReason {
  /// No error
  None,
  /// Server error
  ServerError,
  /// Handshake error
  HandshakeFailed,
  /// Access point error
  AccessPointError,
  /// Stream create failure
  CreateStreamFailed,
  /// Bad name
  BadName,
  /// CDN server actively disconnected
  CDNServerDisconnected,
  /// Active disconnect
  Disconnected
}

/// Beauty feature (bitmask enumeration)
class ZegoBeautifyFeature {
  /// No beautifying
  static const int None = 0;
  /// Polish
  static const int Polish = 1 << 0;
  /// Sharpen
  static const int Whiten = 1 << 1;
  /// Skin whiten
  static const int SkinWhiten = 1 << 2;
  /// Whiten
  static const int Sharpen = 1 << 3;
}

/// Remote device status
enum ZegoRemoteDeviceState {
  /// Device on
  Open,
  /// General device error
  GenericError,
  /// Invalid device ID
  InvalidID,
  /// No permission
  NoAuthorization,
  /// Captured frame rate is 0
  ZeroFPS,
  /// The device is occupied
  InUseByOther,
  /// The device is not plugged in or unplugged
  Unplugged,
  /// The system needs to be restarted
  RebootRequired,
  /// System media services stop, such as under the iOS platform, when the system detects that the current pressure is huge (such as playing a lot of animation), it is possible to disable all media related services.
  SystemMediaServicesLost,
  /// Capturing disabled
  Disable,
  /// The remote device is muted
  Mute,
  /// The device is interrupted, such as a phone call interruption, etc.
  Interruption,
  /// There are multiple apps at the same time in the foreground, such as the iPad app split screen, the system will prohibit all apps from using the camera.
  InBackground,
  /// CDN server actively disconnected
  MultiForegroundApp,
  /// The system is under high load pressure and may cause abnormal equipment.
  BySystemPressure
}

/// Audio device type
enum ZegoAudioDeviceType {
  /// Audio input type
  Input,
  /// Audio output type
  Output
}

/// Mix stream content type
enum ZegoMixerInputContentType {
  /// Mix stream for audio only
  Audio,
  /// Mix stream for both audio and video
  Video
}

/// Capture pipeline scale mode
enum ZegoCapturePipelineScaleMode {
  /// Zoom immediately after acquisition, default
  Pre,
  /// Scaling while encoding
  Post
}

/// Video frame format
enum ZegoVideoFrameFormat {
  /// Unknown format, will take platform default
  Unknown,
  /// I420 (YUV420Planar) format
  I420,
  /// NV12 (YUV420SemiPlanar) format
  NV12,
  /// NV21 (YUV420SemiPlanar) format
  NV21,
  /// BGRA32 format
  BGRA32,
  /// RGBA32 format
  RGBA32,
  /// ARGB32 format
  ARGB32,
  /// ABGR32 format
  ABGR32,
  /// I422 (YUV422Planar) format
  I422
}

/// Video frame buffer type
enum ZegoVideoBufferType {
  /// Raw data type video frame
  Unknown,
  /// Raw data type video frame
  RawData,
  /// Encoded data type video frame
  EncodedData,
  /// Texture 2D type video frame
  GLTexture2D,
  /// CVPixelBuffer type video frame
  CVPixelBuffer,
  /// Surface Texture type video frame
  SurfaceTexture
}

/// Video frame format series
enum ZegoVideoFrameFormatSeries {
  /// RGB series
  RGB,
  /// YUV series
  YUV
}

/// Video frame flip mode
enum ZegoVideoFlipMode {
  /// No flip
  None,
  /// X-axis flip
  X
}

/// Audio Config Preset
enum ZegoAudioConfigPreset {
  /// basic-quality
  BasicQuality,
  /// standard-quality
  StandardQuality,
  /// standard-quality-stereo
  StandardQualityStereo,
  /// high-quality
  HighQuality,
  /// high-quality-stereo
  HighQualityStereo
}

/// Player state
enum ZegoMediaPlayerState {
  /// Not playing
  NoPlay,
  /// Playing
  Playing,
  /// Pausing
  Pausing,
  /// End of play
  PlayEnded
}

/// Player network event
enum ZegoMediaPlayerNetworkEvent {
  /// Network resources are not playing well, and start trying to cache data
  BufferBegin,
  /// Network resources can be played smoothly
  BufferEnded
}

/// Advanced room configuration
///
/// Configure maximum number of users in the room and authentication token, etc.
class ZegoRoomConfig {

  /// The maximum number of users in the room, Passing 0 means unlimited, the default is unlimited.
  int maxMemberCount;

  /// Whether to enable the user in and out of the room callback notification [onRoomUserUpdate], the default is off. If developers need to use ZEGO Room user notifications, make sure that each user who login sets this flag to true
  bool isUserStatusNotify;

  /// The token issued by the developer's business server is used to ensure security. The generation rules are detailed in [https://doc.zego.im/CN/565.html](https://doc.zego.im/CN/565.html). Default is empty string, that is, no authentication
  String token;

  ZegoRoomConfig(this.maxMemberCount, this.isUserStatusNotify, this.token): assert(maxMemberCount != null), assert(isUserStatusNotify != null), assert(token != null);

  /// Create a default room configuration
  ZegoRoomConfig.defaultConfig() {
    maxMemberCount = 0;
    isUserStatusNotify = false;
    token = "";
  }

  Map<String, dynamic> toMap() {
    return {
      'maxMemberCount': this.maxMemberCount,
      'isUserStatusNotify': this.isUserStatusNotify,
      'token': this.token
    };
  }

}

/// Video config
///
/// Configure parameters used for publishing stream, such as bitrate, frame rate, and resolution.
/// Developers should note that the width and height resolution of the mobile and desktop are opposite. For example, 360p, the resolution of the mobile is 360x640, and the desktop is 640x360.
class ZegoVideoConfig {

  /// Capture resolution width
  int captureWidth;

  /// Capture resolution height
  int captureHeight;

  /// Encode resolution width
  int encodeWidth;

  /// Encode resolution height
  int encodeHeight;

  /// frame rate
  int fps;

  /// Bit rate in kbps
  int bitrate;

  /// codec ID
  ZegoVideoCodecID codecID;

  ZegoVideoConfig(this.captureWidth, this.captureHeight, this.encodeWidth, this.encodeHeight, this.fps, this.bitrate, this.codecID): assert(captureWidth != null), assert(captureHeight != null), assert(encodeWidth != null), assert(encodeHeight != null), assert(fps != null), assert(bitrate != null), assert(codecID != null);

  /// Create video configuration with preset enumeration values
  ZegoVideoConfig.preset(ZegoVideoConfigPreset preset): assert(preset != null) {
    codecID = ZegoVideoCodecID.Default;
    switch (preset) {
      case ZegoVideoConfigPreset.Preset180P:
        captureWidth = 180;
        captureHeight = 320;
        encodeWidth = 180;
        encodeHeight = 320;
        bitrate = 300;
        fps = 15;
        break;
      case ZegoVideoConfigPreset.Preset270P:
        captureWidth = 270;
        captureHeight = 480;
        encodeWidth = 270;
        encodeHeight = 480;
        bitrate = 400;
        fps = 15;
        break;
      case ZegoVideoConfigPreset.Preset360P:
        captureWidth = 360;
        captureHeight = 640;
        encodeWidth = 360;
        encodeHeight = 640;
        bitrate = 600;
        fps = 15;
        break;
      case ZegoVideoConfigPreset.Preset540P:
        captureWidth = 540;
        captureHeight = 960;
        encodeWidth = 540;
        encodeHeight = 960;
        bitrate = 1200;
        fps = 15;
        break;
      case ZegoVideoConfigPreset.Preset720P:
        captureWidth = 720;
        captureHeight = 1280;
        encodeWidth = 720;
        encodeHeight = 1480;
        bitrate = 1500;
        fps = 15;
        break;
      case ZegoVideoConfigPreset.Preset1080P:
        captureWidth = 1080;
        captureHeight = 1920;
        encodeWidth = 1080;
        encodeHeight = 1920;
        bitrate = 3000;
        fps = 15;
        break;
    }
  }

  ZegoVideoConfig.fromMap(Map<dynamic, dynamic> map) {
    captureWidth = map['captureWidth'];
    captureHeight = map['captureHeight'];
    encodeWidth = map['encodeWidth'];
    encodeHeight = map['encodeHeight'];
    fps = map['fps'];
    bitrate = map['bitrate'];
    codecID = ZegoVideoCodecID.values[map['codecID']];
  }

  Map<String, dynamic> toMap() {
    return {
      'captureWidth': this.captureWidth,
      'captureHeight': this.captureHeight,
      'encodeWidth': this.encodeWidth,
      'encodeHeight': this.encodeHeight,
      'fps': this.fps,
      'bitrate': this.bitrate,
      'codecID': this.codecID.index
    };
  }

}

/// User object
///
/// Configure user ID and username to identify users in the room.
/// Note that the userID must be unique under the same appID, otherwise mutual kicks out will occur.
/// It is strongly recommended that userID corresponds to the user ID of the business APP, that is, a userID and a real user are fixed and unique, and should not be passed to the SDK in a random userID. Because the unique and fixed userID allows ZEGO technicians to quickly locate online problems.
class ZegoUser {

  /// User ID, a string with a maximum length of 64 bytes or less. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
  String userID;

  /// User Name, a string with a maximum length of 256 bytes or less
  String userName;

  ZegoUser(this.userID, this.userName): assert(userID != null), assert(userName != null);

  /// Create a ZegoUser object
  ///
  /// userName and userID are set to match
  ZegoUser.id(String userID): assert(userID != null) {
    this.userID = userID;
    this.userName = userID;
  }

  ZegoUser.fromMap(Map<dynamic, dynamic> map):
    userID = map['userID'],
    userName = map['userName'];

  Map<String, dynamic> toMap() {
    return {
      'userID': this.userID,
      'userName': this.userName
    };
  }

}

/// Stream object
///
/// Identify an stream object
class ZegoStream {

  /// User object instance
  ZegoUser user;

  /// Stream ID, a string of up to 256 characters. You cannot include URL keywords, otherwise publishing stream and playing stream will fails. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
  String streamID;

  /// Stream extra info
  String extraInfo;

  ZegoStream(this.user, this.streamID, this.extraInfo): assert(user != null), assert(streamID != null), assert(extraInfo != null);

  ZegoStream.fromMap(Map<dynamic, dynamic> map):
    user = ZegoUser.fromMap(map['user']),
    streamID = map['streamID'],
    extraInfo = map['extraInfo'];

}

/// View object
///
/// Configure view object, view Mode, background color
class ZegoCanvas {

  /// ViewID, if [enablePlatformView] is set to [true] in [createEngine], this parameter is the PlatformViewID returned by calling [createPlatformView], otherwise it is the TextureID returned by calling [createTextureRenderer]
  int view;

  /// View mode, default is ZegoViewModeAspectFit
  ZegoViewMode viewMode;

  /// Background color, the format is 0xRRGGBB, default is black, which is 0x000000
  int backgroundColor;

  ZegoCanvas(this.view, this.viewMode, this.backgroundColor): assert(view != null), assert(viewMode != null), assert(backgroundColor != null);

  /// Create a ZegoCanvas, default viewMode is AspectFit, default background color is black
  ZegoCanvas.view(int view): assert(view != null) {
    this.view = view;
    this.viewMode = ZegoViewMode.AspectFit;
    this.backgroundColor = 0x000000;
  }

  Map<String, dynamic> toMap() {
    return {
      'view': this.view,
      'viewMode': this.viewMode.index,
      'backgroundColor': this.backgroundColor
    };
  }

}

/// Published stream quality information
///
/// Audio and video parameters and network quality, etc.
class ZegoPublishStreamQuality {

  /// Video capture frame rate. The unit of frame rate is f/s
  double videoCaptureFPS;

  /// Video encoding frame rate. The unit of frame rate is f/s
  double videoEncodeFPS;

  /// Video transmission frame rate. The unit of frame rate is f/s
  double videoSendFPS;

  /// Video bit rate in kbps
  double videoKBPS;

  /// Audio capture frame rate. The unit of frame rate is f/s
  double audioCaptureFPS;

  /// Audio transmission frame rate. The unit of frame rate is f/s
  double audioSendFPS;

  /// Audio bit rate in kbps
  double audioKBPS;

  /// Local to server delay, in milliseconds
  int rtt;

  /// Packet loss rate, in percentage, 0.0 ~ 1.0
  double packetLostRate;

  /// Published stream quality level
  ZegoStreamQualityLevel level;

  /// Whether to enable hardware encoding
  bool isHardwareEncode;

  /// Total number of bytes sent, including audio, video, SEI
  double totalSendBytes;

  /// Number of audio bytes sent
  double audioSendBytes;

  /// Number of video bytes sent
  double videoSendBytes;

  ZegoPublishStreamQuality(this.videoCaptureFPS, this.videoEncodeFPS, this.videoSendFPS, this.videoKBPS, this.audioCaptureFPS, this.audioSendFPS, this.audioKBPS, this.rtt, this.packetLostRate, this.level, this.isHardwareEncode, this.totalSendBytes, this.audioSendBytes, this.videoSendBytes): assert(videoCaptureFPS != null), assert(videoEncodeFPS != null), assert(videoSendFPS != null), assert(videoKBPS != null), assert(audioCaptureFPS != null), assert(audioSendFPS != null), assert(audioKBPS != null), assert(rtt != null), assert(packetLostRate != null), assert(level != null), assert(isHardwareEncode != null), assert(totalSendBytes != null), assert(audioSendBytes != null), assert(videoSendBytes != null);

  ZegoPublishStreamQuality.fromMap(Map<dynamic, dynamic> map) {
    videoCaptureFPS = map['videoCaptureFPS'];
    videoEncodeFPS = map['videoEncodeFPS'];
    videoSendFPS = map['videoSendFPS'];
    videoKBPS = map['videoKBPS'];
    audioCaptureFPS = map['audioCaptureFPS'];
    audioSendFPS = map['audioSendFPS'];
    audioKBPS = map['audioKBPS'];
    rtt = map['rtt'];
    packetLostRate = map['packetLostRate'];
    level = ZegoStreamQualityLevel.values[map['level']];
    isHardwareEncode = map['isHardwareEncode'];
    totalSendBytes = map['totalSendBytes'];
    audioSendBytes = map['audioSendBytes'];
    videoSendBytes = map['videoSendBytes'];
  }

}

/// CDN config object
///
/// Includes CDN URL and authentication parameter string
class ZegoCDNConfig {

  /// CDN URL
  String url;

  /// Auth param of URL
  String authParam;

  ZegoCDNConfig(this.url, this.authParam): assert(url != null), assert(authParam != null);

  ZegoCDNConfig.fromMap(Map<dynamic, dynamic> map):
    url = map['url'],
    authParam = map['authParam'];

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'authParam': this.authParam
    };
  }

}

/// Relay to CDN info
///
/// Including the URL of the relaying CDN, relaying state, etc.
class ZegoStreamRelayCDNInfo {

  /// URL of publishing stream to CDN
  String url;

  /// State of relaying to CDN
  ZegoStreamRelayCDNState state;

  /// Reason for relay state changed
  ZegoStreamRelayCDNUpdateReason updateReason;

  /// The timestamp when the state changed, in milliseconds
  int stateTime;

  ZegoStreamRelayCDNInfo(this.url, this.state, this.updateReason, this.stateTime): assert(url != null), assert(state != null), assert(updateReason != null), assert(stateTime != null);

  ZegoStreamRelayCDNInfo.fromMap(Map<dynamic, dynamic> map):
    url = map['url'],
    state = map['state'],
    updateReason = map['updateReason'],
    stateTime = map['stateTime'];

}

/// Advanced player configuration
///
/// Configure playing stream CDN configuration, video layer
class ZegoPlayerConfig {

  /// The CDN configuration for playing stream. If set, the stream is play according to the URL instead of the streamID. After that, the streamID is only used as the ID of SDK internal callback.
  ZegoCDNConfig cdnConfig;

  /// Set the video layer for playing the stream
  ZegoPlayerVideoLayer videoLayer;

  ZegoPlayerConfig(this.cdnConfig, this.videoLayer): assert(cdnConfig != null), assert(videoLayer != null);

  ZegoPlayerConfig.fromMap(Map<dynamic, dynamic> map):
    cdnConfig = ZegoCDNConfig.fromMap(map['cdnConfig']),
    videoLayer = map['videoLayer'];

  Map<String, dynamic> toMap() {
    return {
      'cdnConfig': this.cdnConfig.toMap(),
      'videoLayer': this.videoLayer.index
    };
  }

}

/// Played stream quality information
///
/// Audio and video parameters and network quality, etc.
class ZegoPlayStreamQuality {

  /// Video reception frame rate. The unit of frame rate is f/s
  double videoRecvFPS;

  /// Video decoding frame rate. The unit of frame rate is f/s
  double videoDecodeFPS;

  /// Video rendering frame rate. The unit of frame rate is f/s
  double videoRenderFPS;

  /// Video bit rate in kbps
  double videoKBPS;

  /// Audio reception frame rate. The unit of frame rate is f/s
  double audioRecvFPS;

  /// Audio decoding frame rate. The unit of frame rate is f/s
  double audioDecodeFPS;

  /// Audio rendering frame rate. The unit of frame rate is f/s
  double audioRenderFPS;

  /// Audio bit rate in kbps
  double audioKBPS;

  /// Server to local delay, in milliseconds
  int rtt;

  /// Packet loss rate, in percentage, 0.0 ~ 1.0
  double packetLostRate;

  /// Delay from peer to peer, in milliseconds
  int peerToPeerDelay;

  /// Packet loss rate from peer to peer, in percentage, 0.0 ~ 1.0
  double peerToPeerPacketLostRate;

  /// Published stream quality level
  ZegoStreamQualityLevel level;

  /// Delay after the data is received by the local end, in milliseconds
  int delay;

  /// Whether to enable hardware decoding
  bool isHardwareDecode;

  /// Total number of bytes received, including audio, video, SEI
  double totalRecvBytes;

  /// Number of audio bytes received
  double audioRecvBytes;

  /// Number of video bytes received
  double videoRecvBytes;

  ZegoPlayStreamQuality(this.videoRecvFPS, this.videoDecodeFPS, this.videoRenderFPS, this.videoKBPS, this.audioRecvFPS, this.audioDecodeFPS, this.audioRenderFPS, this.audioKBPS, this.rtt, this.packetLostRate, this.peerToPeerDelay, this.peerToPeerPacketLostRate, this.level, this.delay, this.isHardwareDecode, this.totalRecvBytes, this.audioRecvBytes, this.videoRecvBytes): assert(videoRecvFPS != null), assert(videoDecodeFPS != null), assert(videoRenderFPS != null), assert(videoKBPS != null), assert(audioRecvFPS != null), assert(audioDecodeFPS != null), assert(audioRenderFPS != null), assert(audioKBPS != null), assert(rtt != null), assert(packetLostRate != null), assert(peerToPeerDelay != null), assert(peerToPeerPacketLostRate != null), assert(level != null), assert(delay != null), assert(isHardwareDecode != null), assert(totalRecvBytes != null), assert(audioRecvBytes != null), assert(videoRecvBytes != null);

  ZegoPlayStreamQuality.fromMap(Map<dynamic, dynamic> map) {
    videoRecvFPS = map['videoRecvFPS'];
    videoDecodeFPS = map['videoDecodeFPS'];
    videoRenderFPS = map['videoRenderFPS'];
    videoKBPS = map['videoKBPS'];
    audioRecvFPS = map['audioRecvFPS'];
    audioDecodeFPS = map['audioDecodeFPS'];
    audioRenderFPS = map['audioRenderFPS'];
    audioKBPS = map['audioKBPS'];
    rtt = map['rtt'];
    packetLostRate = map['packetLostRate'];
    peerToPeerDelay = map['peerToPeerDelay'];
    peerToPeerPacketLostRate = map['peerToPeerPacketLostRate'];
    level = ZegoStreamQualityLevel.values[map['level']];
    delay = map['delay'];
    isHardwareDecode = map['isHardwareDecode'];
    totalRecvBytes = map['totalRecvBytes'];
    audioRecvBytes = map['audioRecvBytes'];
    videoRecvBytes = map['videoRecvBytes'];
  }

}

/// Device Info
///
/// Including device ID and name
class ZegoDeviceInfo {

  /// Device ID
  String deviceID;

  /// Device name
  String deviceName;

  ZegoDeviceInfo(this.deviceID, this.deviceName): assert(deviceID != null), assert(deviceName != null);

  ZegoDeviceInfo.fromMap(Map<dynamic, dynamic> map):
    deviceID = map['deviceID'],
    deviceName = map['deviceName'];

}

/// Beauty configuration options
///
/// Configure the parameters of skin peeling, whitening and sharpening
class ZegoBeautifyOption {

  /// The sample step size of beauty peeling, the value range is [0,1], default 0.2
  double polishStep;

  /// Brightness parameter for beauty and whitening, the larger the value, the brighter the brightness, ranging from [0,1], default 0.5
  double whitenFactor;

  /// Beauty sharpening parameter, the larger the value, the stronger the sharpening, value range [0,1], default 0.1
  double sharpenFactor;

  ZegoBeautifyOption(this.polishStep, this.whitenFactor, this.sharpenFactor): assert(polishStep != null), assert(whitenFactor != null), assert(sharpenFactor != null);

  /// Create a default beauty parameter object
  ZegoBeautifyOption.defaultConfig() {
    polishStep = 0.2;
    whitenFactor = 0.5;
    sharpenFactor = 0.1;
  }

  Map<String, dynamic> toMap() {
    return {
      'polishStep': this.polishStep,
      'whitenFactor': this.whitenFactor,
      'sharpenFactor': this.sharpenFactor
    };
  }

}

/// Mix stream audio configuration
///
/// Configure video frame rate, bitrate, and resolution for mixer task
class ZegoMixerAudioConfig {

  /// Audio bitrate in kbps, default is 48 kbps, cannot be modified after starting a mixer task
  int bitrate;

  /// Audio channel, default is Mono
  ZegoAudioChannel channel;

  /// codec ID, default is ZegoAudioCodecIDDefault
  ZegoAudioCodecID codecID;

  ZegoMixerAudioConfig(this.bitrate, this.channel, this.codecID): assert(bitrate != null), assert(channel != null), assert(codecID != null);

  /// Create a default mix stream audio configuration
  ZegoMixerAudioConfig.defaultConfig() {
    bitrate = 48;
    channel = ZegoAudioChannel.Mono;
    codecID = ZegoAudioCodecID.Normal;
  }

  Map<String, dynamic> toMap() {
    return {
      'bitrate': this.bitrate,
      'channel': this.channel.index,
      'codecID': this.codecID.index
    };
  }

}

/// Mix stream video config object
///
/// Configure video frame rate, bitrate, and resolution for mixer task
class ZegoMixerVideoConfig {

  /// Video resolution width
  int width;

  /// Video resolution height
  int height;

  /// Video FPS, cannot be modified after starting a mixer task
  int fps;

  /// Video bitrate in kbps
  int bitrate;

  ZegoMixerVideoConfig(this.width, this.height, this.fps, this.bitrate): assert(width != null), assert(height != null), assert(fps != null), assert(bitrate != null);

  /// Create a default mixer video configuration
  ZegoMixerVideoConfig.defaultConfig() {
    width = 360;
    height = 640;
    fps = 15;
    bitrate = 600;
  }

  Map<String, dynamic> toMap() {
    return {
      'width': this.width,
      'height': this.height,
      'fps': this.fps,
      'bitrate': this.bitrate
    };
  }

}

/// Mixer input
///
/// Configure the mix stream input stream ID, type, and the layout
class ZegoMixerInput {

  /// Stream ID, a string of up to 256 characters. You cannot include URL keywords, otherwise publishing stream and playing stream will fails. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
  String streamID;

  /// Mix stream content type
  ZegoMixerInputContentType contentType;

  /// Stream layout
  Rect layout;

  /// If enable soundLevel in mix stream task, an unique soundLevelID is need for every stream
  int soundLevelID;

  ZegoMixerInput(this.streamID, this.contentType, this.layout, this.soundLevelID): assert(streamID != null), assert(contentType != null), assert(layout != null), assert(soundLevelID != null);

  Map<String, dynamic> toMap() {
    return {
      'streamID': this.streamID,
      'contentType': this.contentType.index,
      'layout': this.layout,
      'soundLevelID': this.soundLevelID
    };
  }

}

/// Mixer output object
///
/// Configure mix stream output target URL or stream ID
class ZegoMixerOutput {

  /// Mix stream output target, URL or stream ID
  String target;

  ZegoMixerOutput(this.target): assert(target != null);

  Map<String, dynamic> toMap() {
    return {
      'target': this.target
    };
  }

}

/// Watermark object
///
/// Configure a watermark image URL and the layout of the watermark in the screen
class ZegoWatermark {

  /// Watermark image URL
  String imageURL;

  /// Watermark image layout
  Rect layout;

  ZegoWatermark(this.imageURL, this.layout): assert(imageURL != null), assert(layout != null);

  Map<String, dynamic> toMap() {
    return {
      'imageURL': this.imageURL,
      'layout': this.layout
    };
  }

}

/// Mix stream task object
///
/// This class is the configuration class of the mixing stream task. When a mixing stream task is requested to the ZEGO audio and video cloud, the configuration of the mixing task is required.
/// This class describes the detailed configuration information of this mixed task.
class ZegoMixerTask {

  /// The task ID of the task
  String taskID;

  /// The audio config of the task
  ZegoMixerAudioConfig audioConfig;

  /// The audio config of the task
  ZegoMixerVideoConfig videoConfig;

  /// The input list of the task
  List<ZegoMixerInput> inputList;

  /// The output list of the task
  List<ZegoMixerOutput> outputList;

  /// The watermark of the task
  ZegoWatermark watermark;

  /// The background image URL of the task
  String backgroundImageURL;

  /// Enable or disable sound level callback for the task. If enabled, then the remote player can get the soundLevel of every stream in the inputlist by [onMixerSoundLevelUpdate] callback.
  bool enableSoundLevel;

  /// Create a mix stream task object with TaskID
  ZegoMixerTask(String taskID) {
    this.taskID = taskID;
    inputList = List<ZegoMixerInput>();
    outputList = List<ZegoMixerOutput>();
    audioConfig = ZegoMixerAudioConfig.defaultConfig();
    videoConfig = ZegoMixerVideoConfig.defaultConfig();
    watermark = ZegoWatermark('', Rect.fromLTRB(0, 0, 0, 0));
    backgroundImageURL = "";
    enableSoundLevel = false;
  }

  Map<String, dynamic> toMap() {
    return {
      'taskID': this.taskID,
      'audioConfig': this.audioConfig.toMap(),
      'videoConfig': this.videoConfig.toMap(),
      'inputList': this.inputList,
      'outputList': this.outputList,
      'watermark': this.watermark.toMap(),
      'backgroundImageURL': this.backgroundImageURL,
      'enableSoundLevel': this.enableSoundLevel
    };
  }

}

/// Broadcast message info
///
/// The received object of the room broadcast message, including the message content, message ID, sender, sending time
class ZegoBroadcastMessageInfo {

  /// message content
  String message;

  /// message id
  int messageID;

  /// Message send time
  int sendTime;

  /// Message sender
  ZegoUser fromUser;

  ZegoBroadcastMessageInfo(this.message, this.messageID, this.sendTime, this.fromUser): assert(message != null), assert(messageID != null), assert(sendTime != null), assert(fromUser != null);

  ZegoBroadcastMessageInfo.fromMap(Map<dynamic, dynamic> map):
    message = map['message'],
    messageID = map['messageID'],
    sendTime = map['sendTime'],
    fromUser = ZegoUser.fromMap(map['fromUser']);

}

/// Barrage message info
///
/// The received object of the room barrage message, including the message content, message ID, sender, sending time
class ZegoBarrageMessageInfo {

  /// message content
  String message;

  /// message id
  String messageID;

  /// Message send time
  int sendTime;

  /// Message sender
  ZegoUser fromUser;

  ZegoBarrageMessageInfo(this.message, this.messageID, this.sendTime, this.fromUser): assert(message != null), assert(messageID != null), assert(sendTime != null), assert(fromUser != null);

  ZegoBarrageMessageInfo.fromMap(Map<dynamic, dynamic> map):
    message = map['message'],
    messageID = map['messageID'],
    sendTime = map['sendTime'],
    fromUser = ZegoUser.fromMap(map['fromUser']);

}

/// Audio configuration
///
/// Configure audio bitrate, audio channel, audio encoding for publishing stream
class ZegoAudioConfig {

  /// Audio bitrate in kbps, default is 48 kbps
  int bitrate;

  /// Audio channel, default is Mono
  ZegoAudioChannel channel;

  /// codec ID, default is ZegoAudioCodecIDDefault
  ZegoAudioCodecID codecID;

  ZegoAudioConfig(this.bitrate, this.channel, this.codecID): assert(bitrate != null), assert(channel != null), assert(codecID != null);

  /// Create a audio configuration with preset enumeration values
  ZegoAudioConfig.preset(ZegoAudioConfigPreset preset): assert(preset != null) {
    codecID = ZegoAudioCodecID.Default;
    switch (preset) {
      case ZegoAudioConfigPreset.BasicQuality:
        bitrate = 16;
        channel = ZegoAudioChannel.Mono;
        break;
      case ZegoAudioConfigPreset.StandardQuality:
        bitrate = 48;
        channel = ZegoAudioChannel.Mono;
        break;
      case ZegoAudioConfigPreset.StandardQualityStereo:
        bitrate = 56;
        channel = ZegoAudioChannel.Stereo;
        break;
      case ZegoAudioConfigPreset.HighQuality:
        bitrate = 128;
        channel = ZegoAudioChannel.Mono;
        break;
      case ZegoAudioConfigPreset.HighQualityStereo:
        bitrate = 192;
        channel = ZegoAudioChannel.Stereo;
        break;
    }
  }

  ZegoAudioConfig.fromMap(Map<dynamic, dynamic> map) {
    bitrate = map['bitrate'];
    channel = ZegoAudioChannel.values[map['channel']];
    codecID = ZegoAudioCodecID.values[map['codecID']];
  }

  Map<String, dynamic> toMap() {
    return {
      'bitrate': this.bitrate,
      'channel': this.channel.index,
      'codecID': this.codecID.index
    };
  }

}

/// Zego MediaPlayer
///
/// Yon can use ZegoMediaPlayer to play media resource files on the local or remote server, and can mix the sound of the media resource files that are played into the publish stream to achieve the effect of background music.
abstract class ZegoMediaPlayer {

  /// Load media resource
  ///
  /// Yon can pass the absolute path of the local resource or the URL of the network resource
  ///
  /// - [path] the absolute path of the local resource or the URL of the network resource
  /// - Returns Notification of resource loading results
  Future<ZegoMediaPlayerLoadResourceResult> loadResource(String path);

  /// Start playing
  ///
  /// You need to load resources before playing
  Future<void> start();

  /// Stop playing
  Future<void> stop();

  /// Pause playing
  Future<void> pause();

  /// resume playing
  Future<void> resume();

  /// Set the specified playback progress
  ///
  /// Unit is millisecond
  ///
  /// - [millisecond] Point in time of specified playback progress
  /// - Returns the result notification of set the specified playback progress
  Future<ZegoMediaPlayerSeekToResult> seekTo(int millisecond);

  /// Whether to repeat playback
  ///
  /// - [enable] repeat playback flag. The default is false.
  Future<void> enableRepeat(bool enable);

  /// Whether to mix the player's sound into the stream being published
  ///
  /// - [enable] Aux audio flag. The default is false.
  Future<void> enableAux(bool enable);

  /// Whether to play locally silently
  ///
  /// If [enableAux] switch is turned on, there is still sound in the publishing stream. The default is false.
  ///
  /// - [mute] Mute local audio flag, The default is false.
  Future<void> muteLocal(bool mute);

  /// Set player volume
  ///
  /// - [volume] The range is 0 ~ 100. The default is 50.
  Future<void> setVolume(int volume);

  /// Set playback progress callback interval
  ///
  /// This interface can control the callback frequency of [onMediaPlayerPlayingProgress]. When the callback interval is set to 0, the callback is stopped. The default callback interval is 1s
  /// This callback are not returned exactly at the set callback interval, but rather at the frequency at which the audio or video frames are processed to determine whether the callback is needed to call
  ///
  /// - [millisecond] Interval of playback progress callback in milliseconds
  Future<void> setProgressInterval(int millisecond);

  /// Get the current volume
  ///
  /// The range is 0 ~ 100. The default is 50
  Future<int> getVolume();

  /// Get the total progress of your media resources
  ///
  /// You should load resource before invoking this API, otherwise the return value is 0
  ///
  /// - Returns Unit is millisecond
  Future<int> getTotalDuration();

  /// Get current playing progress
  ///
  /// You should load resource before invoking this API, otherwise the return value is 0
  Future<int> getCurrentProgress();

  /// Get the current playback status
  Future<ZegoMediaPlayerState> getCurrentState();

  /// Get media player index
  int getIndex();

}

/// Callback for updating stream extra information
///
/// - [errorCode] Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
class ZegoPublisherSetStreamExtraInfoResult {

  /// Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
  int errorCode;

  ZegoPublisherSetStreamExtraInfoResult(this.errorCode): assert(errorCode != null);

  ZegoPublisherSetStreamExtraInfoResult.fromMap(Map<dynamic, dynamic> map):
    errorCode = map['errorCode'];

}

/// Callback for add/remove CDN URL
///
/// - [errorCode] Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
class ZegoPublisherUpdateCdnUrlResult {

  /// Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
  int errorCode;

  ZegoPublisherUpdateCdnUrlResult(this.errorCode): assert(errorCode != null);

  ZegoPublisherUpdateCdnUrlResult.fromMap(Map<dynamic, dynamic> map):
    errorCode = map['errorCode'];

}

/// Results of starting a mixer task
///
/// - [errorCode] Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
/// - [extendedData] Extended Information
class ZegoMixerStartResult {

  /// Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
  int errorCode;

  /// Extended Information
  Map<String, dynamic> extendedData;

  ZegoMixerStartResult(this.errorCode, this.extendedData): assert(errorCode != null), assert(extendedData != null);

  ZegoMixerStartResult.fromMap(Map<dynamic, dynamic> map):
    errorCode = map['errorCode'],
    extendedData = map['extendedData'];

}

/// Results of stoping a mixer task
///
/// - [errorCode] Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
class ZegoMixerStopResult {

  /// Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
  int errorCode;

  ZegoMixerStopResult(this.errorCode): assert(errorCode != null);

  ZegoMixerStopResult.fromMap(Map<dynamic, dynamic> map):
    errorCode = map['errorCode'];

}

/// Callback for sending broadcast messages
///
/// - [errorCode] Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
/// - [messageID] ID of this message
class ZegoIMSendBroadcastMessageResult {

  /// Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
  int errorCode;

  /// ID of this message
  int messageID;

  ZegoIMSendBroadcastMessageResult(this.errorCode, this.messageID): assert(errorCode != null), assert(messageID != null);

  ZegoIMSendBroadcastMessageResult.fromMap(Map<dynamic, dynamic> map):
    errorCode = map['errorCode'],
    messageID = map['messageID'];

}

/// Callback for sending barrage message
///
/// - [errorCode] Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
/// - [messageID] ID of this message
class ZegoIMSendBarrageMessageResult {

  /// Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
  int errorCode;

  /// ID of this message
  String messageID;

  ZegoIMSendBarrageMessageResult(this.errorCode, this.messageID): assert(errorCode != null), assert(messageID != null);

  ZegoIMSendBarrageMessageResult.fromMap(Map<dynamic, dynamic> map):
    errorCode = map['errorCode'],
    messageID = map['messageID'];

}

/// Callback for sending custom command
///
/// - [errorCode] Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
class ZegoIMSendCustomCommandResult {

  /// Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
  int errorCode;

  ZegoIMSendCustomCommandResult(this.errorCode): assert(errorCode != null);

  ZegoIMSendCustomCommandResult.fromMap(Map<dynamic, dynamic> map):
    errorCode = map['errorCode'];

}

/// Callback for media player loads resources
///
/// - [errorCode] Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
class ZegoMediaPlayerLoadResourceResult {

  /// Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
  int errorCode;

  ZegoMediaPlayerLoadResourceResult(this.errorCode): assert(errorCode != null);

  ZegoMediaPlayerLoadResourceResult.fromMap(Map<dynamic, dynamic> map):
    errorCode = map['errorCode'];

}

/// Callback for media player seek to playback progress
///
/// - [errorCode] Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
class ZegoMediaPlayerSeekToResult {

  /// Error code, please refer to the common error code document [https://doc-en.zego.im/en/308.html] for details
  int errorCode;

  ZegoMediaPlayerSeekToResult(this.errorCode): assert(errorCode != null);

  ZegoMediaPlayerSeekToResult.fromMap(Map<dynamic, dynamic> map):
    errorCode = map['errorCode'];

}

