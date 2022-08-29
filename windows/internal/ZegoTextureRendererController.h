#pragma once

#include <unordered_map>
#include <flutter/event_channel.h>

#include "ZegoTextureRenderer.h"

class ZegoTextureRendererControllerEventChannel;

class ZegoTextureRendererController : public ZEGO::EXPRESS::IZegoCustomVideoRenderHandler, 
    public ZEGO::EXPRESS::IZegoMediaPlayerVideoHandler
{
public:
    ZegoTextureRendererController(/* args */);
    ZegoTextureRendererController(const ZegoTextureRendererController &old) = default;
    virtual ~ZegoTextureRendererController();

    static std::shared_ptr<ZegoTextureRendererController> getInstance()
    {
        static std::shared_ptr<ZegoTextureRendererController> instance_ = std::make_shared<ZegoTextureRendererController>();
        return instance_;
    }

    inline void setEventSink(std::unique_ptr<flutter::EventSink<flutter::EncodableValue>> &&eventSink) {
        eventSink_ = std::move(eventSink);
    }
    inline void clearEventSink() {
        eventSink_.reset();
    }

    void init(flutter::BinaryMessenger *message);
    void uninit();

    int64_t createTextureRenderer(flutter::TextureRegistrar* texture_registrar, uint32_t width, uint32_t height);

    bool destroyTextureRenderer(int64_t textureID);

    /// Called when dart invoke `startPreview`
    bool addCapturedRenderer(int64_t textureID, ZEGO::EXPRESS::ZegoPublishChannel channel, ZEGO::EXPRESS::ZegoViewMode viewMode);

    /// Called when dart invoke `stopPreview`
    void removeCapturedRenderer(ZEGO::EXPRESS::ZegoPublishChannel channel);

    /// Called when dart invoke `startPlayingStream`
    bool addRemoteRenderer(int64_t textureID, std::string streamID, ZEGO::EXPRESS::ZegoViewMode viewMode);

    /// Called when dart invoke `stopPlayingStream`
    void removeRemoteRenderer(std::string streamID);

    /// Called when dart invoke `mediaPlayer.setPlayerCanvas`
    bool addMediaPlayerRenderer(int64_t textureID, ZEGO::EXPRESS::IZegoMediaPlayer *mediaPlayer, ZEGO::EXPRESS::ZegoViewMode viewMode);

    /// Called when dart invoke `destroyMediaPlayer`
    void removeMediaPlayerRenderer(ZEGO::EXPRESS::IZegoMediaPlayer *mediaPlayer);

    /// For video preview/play
    void startRendering();

    /// For video preview/play
    void stopRendering();

protected:
    // When custom video rendering is enabled, the original video frame data collected by the local preview is called back.
    virtual void onCapturedVideoFrameRawData(unsigned char ** data,
                                             unsigned int * dataLength,
                                             ZEGO::EXPRESS::ZegoVideoFrameParam param,
                                             ZEGO::EXPRESS::ZegoVideoFlipMode flipMode,
                                             ZEGO::EXPRESS::ZegoPublishChannel channel) override;

    // When custom video rendering is enabled, the remote end pulls the original video frame data to call back, and distinguishes different streams by streamID.
    virtual void onRemoteVideoFrameRawData(unsigned char ** data, unsigned int * dataLength,
                                           ZEGO::EXPRESS::ZegoVideoFrameParam param,
                                           const std::string & streamID) override;

    // The callback triggered when the media player throws out video frame data.
    virtual void onVideoFrame(ZEGO::EXPRESS::IZegoMediaPlayer * mediaPlayer, const unsigned char ** data,
                              unsigned int * dataLength, ZEGO::EXPRESS::ZegoVideoFrameParam param) override;
private:
    std::unordered_map<int64_t , std::shared_ptr<ZegoTextureRenderer> > renderers_;
    std::unordered_map<ZEGO::EXPRESS::ZegoPublishChannel , std::shared_ptr<ZegoTextureRenderer> > capturedRenderers_;
    std::unordered_map<std::string , std::shared_ptr<ZegoTextureRenderer> > remoteRenderers_;
    std::unordered_map<ZEGO::EXPRESS::IZegoMediaPlayer * , std::shared_ptr<ZegoTextureRenderer> > mediaPlayerRenderers_;

    std::atomic_bool isInit = false;

    std::unique_ptr<flutter::EventSink<flutter::EncodableValue>> eventSink_;
};

class ZegoTextureRendererControllerEventChannel : public flutter::StreamHandler<flutter::EncodableValue> {
public:
    ZegoTextureRendererControllerEventChannel() {}
    virtual ~ZegoTextureRendererControllerEventChannel() {}

protected:
    virtual std::unique_ptr<flutter::StreamHandlerError<flutter::EncodableValue>> OnListenInternal(
        const flutter::EncodableValue* arguments,
        std::unique_ptr<flutter::EventSink<flutter::EncodableValue>>&& events) override {
            ZegoTextureRendererController::getInstance()->setEventSink(std::move(events));
            std::cout << "ZegoTextureRendererController on listen event" << std::endl;
            return nullptr;
        }

    // Implementation of the public interface, to be provided by subclasses.
    virtual std::unique_ptr<flutter::StreamHandlerError<flutter::EncodableValue>> OnCancelInternal(
        const flutter::EncodableValue* arguments) override {
            ZegoTextureRendererController::getInstance()->clearEventSink();
            std::cout << "ZegoTextureRendererController on cancel listen event" << std::endl;
            return nullptr;
        }
};

