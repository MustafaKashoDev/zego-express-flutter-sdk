#ifndef ZEGO_MEDIA_PLAYER_VIDEO_MANAGER_H_
#define ZEGO_MEDIA_PLAYER_VIDEO_MANAGER_H_

#include "ZegoCustomVideoDefine.h"
#include <ZegoExpressSDK.h>

class FLUTTER_PLUGIN_EXPORT IZegoFlutterMediaPlayerVideoHandler {
protected:
    virtual ~IZegoFlutterMediaPlayerVideoHandler() {}

public:
    /// The callback triggered when the media player throws out video frame data.
    ///
    /// Available since: 1.3.4
    /// Description: The callback triggered when the media player throws out video frame data.
    /// Trigger: The callback is generated when the media player starts playing.
    /// Caution: The callback does not actually take effect until call [setVideoHandler] to set.
    /// Restrictions: When playing copyrighted music, this callback will be disabled by default. If necessary, please contact ZEGO technical support.
    ///
    /// @param mediaPlayerIndex Callback player index.
    /// @param data Raw data of video frames (eg: RGBA only needs to consider data[0], I420 needs to consider data[0,1,2]).
    /// @param dataLength Data length (eg: RGBA only needs to consider dataLength[0], I420 needs to consider dataLength[0,1,2]).
    /// @param param video data frame param.
    virtual void onVideoFrame(int /*mediaPlayerIndex*/, const unsigned char ** /*data*/,
                              unsigned int * /*dataLength*/, ZGFlutterVideoFrameParam /*param*/) {}

    /// The callback triggered when the media player throws out video frame data.
    ///
    /// Available since: 2.16.0
    /// Description: The callback triggered when the media player throws out video frame data.
    /// Trigger: The callback is generated when the media player starts playing.
    /// Caution: The callback does not actually take effect until call [setVideoHandler] to set.
    /// Restrictions: When playing copyrighted music, this callback will be disabled by default. If necessary, please contact ZEGO technical support.
    ///
    /// @param mediaPlayerIndex Callback player index.
    /// @param data Raw data of video frames (eg: RGBA only needs to consider data[0], I420 needs to consider data[0,1,2]).
    /// @param dataLength Data length (eg: RGBA only needs to consider dataLength[0], I420 needs to consider dataLength[0,1,2]).
    /// @param param video data frame param.
    /// @param extraInfo Video frame extra info. json format data.
    virtual void onVideoFrame(int /*mediaPlayerIndex*/, const unsigned char ** /*data*/,
                              unsigned int * /*dataLength*/, ZGFlutterVideoFrameParam /*param*/,
                              const char * /*extraInfo*/) {}

    /// The callback triggered when the media player is about to throw the block data of the media resource.
    ///
    /// Available since: 3.4.0
    /// Description: The callback triggered when the media player is about to throw the block data of the media resource.
    /// Trigger: The callback is generated when the media player starts playing.
    /// Caution: The callback does not actually take effect until call [setBlockDataHandler] to set.
    /// Restrictions: When playing copyrighted music, this callback will be disabled by default. If necessary, please contact ZEGO technical support.
    ///
    /// @param mediaPlayerIndex Callback player index.
    /// @param path The path of the media resource.
    virtual void onBlockBegin(int mediaPlayerIndex, const std::string &path) {}

    /// The callback triggered when the media player throws the block data of the media resource.
    ///
    /// Available since: 3.4.0
    /// Description: The callback triggered when the media player throws the block data of the media resource.
    /// Trigger: This callback will be generated after receiving the [onBlockBegin] callback.
    /// Caution: The callback does not actually take effect until call [setBlockDataHandler] to set. The buffer size before and after decryption should be consistent.
    /// Restrictions: When playing copyrighted music, this callback will be disabled by default. If necessary, please contact ZEGO technical support.
    ///
    /// @param mediaPlayerIndex Callback player index.
    /// @param buffer The block data of the media resource.
    /// @param bufferSize Length of media resource block data.
    /// @return The size of the buffer, -1 is returned for failure.
    virtual unsigned int onBlockData(int mediaPlayerIndex, unsigned char *const buffer, unsigned int bufferSize) { return -1; }
};

class ZegoMediaPlayerVideoHandler;

class FLUTTER_PLUGIN_EXPORT ZegoMediaPlayerVideoManager
    : public ZEGO::EXPRESS::IZegoMediaPlayerVideoHandler,
      public ZEGO::EXPRESS::IZegoMediaPlayerBlockDataHandler {
  public:
    static std::shared_ptr<ZegoMediaPlayerVideoManager> getInstance();
    
    /// Set video data callback handler of the media player.
    ///
    /// Available since: 2.1.0
    /// Description: By setting this callback, the video data of the media resource file played by the media player can be called back.
    /// Restrictions: None.
    /// Caution: When you no longer need to get the video frame data, please call this function again to clear the handler to stop the video frame data callback.
    ///
    /// @param handler Video data callback handler
    void setVideoHandler(std::shared_ptr<IZegoFlutterMediaPlayerVideoHandler> handler);

private:
    friend class ZegoMediaPlayerVideoHandler;
    std::shared_ptr<IZegoFlutterMediaPlayerVideoHandler> handler_ = nullptr;

    void onVideoFrame(ZEGO::EXPRESS::IZegoMediaPlayer *mediaPlayer, const unsigned char **data,
                      unsigned int *dataLength, ZEGO::EXPRESS::ZegoVideoFrameParam param) override;

    void onVideoFrame(ZEGO::EXPRESS::IZegoMediaPlayer *mediaPlayer, const unsigned char **data,
                      unsigned int *dataLength, ZEGO::EXPRESS::ZegoVideoFrameParam param,
                      const char *extraInfo) override;

    void onBlockBegin(ZEGO::EXPRESS::IZegoMediaPlayer *mediaPlayer,
                      const std::string &path) override;

    unsigned int onBlockData(ZEGO::EXPRESS::IZegoMediaPlayer *mediaPlayer,
                             unsigned char *const buffer, unsigned int bufferSize) override;
};
#endif  // ZEGO_MEDIA_PLAYER_VIDEO_MANAGER_H_
