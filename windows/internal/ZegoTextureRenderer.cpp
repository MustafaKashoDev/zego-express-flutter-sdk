#include "ZegoTextureRenderer.h"

#include <cassert>
#include <iostream>

ZegoTextureRenderer::ZegoTextureRenderer(flutter::TextureRegistrar* texture_registrar, uint32_t width, uint32_t height)
    : textureRegistrar_(texture_registrar), width_(width), height_(height) {

    // Create flutter desktop pixelbuffer texture;
    texture_ =
        std::make_unique<flutter::TextureVariant>(flutter::PixelBufferTexture(
            [this](size_t width, size_t height) -> const FlutterDesktopPixelBuffer* {
                return this->ConvertPixelBufferForFlutter(width, height);
        }));

    textureID_ = textureRegistrar_->RegisterTexture(texture_.get());
}

ZegoTextureRenderer::~ZegoTextureRenderer() {
  // Texture might still be processed while destructor is called.
  // Lock mutex for safe destruction
  const std::lock_guard<std::mutex> lock(bufferMutex_);
  if (textureRegistrar_ && textureID_ > 0) {
    textureRegistrar_->UnregisterTexture(textureID_);
  }
  textureID_ = -1;
  texture_ = nullptr;
  textureRegistrar_ = nullptr;
}

bool ZegoTextureRenderer::updateSrcFrameBuffer(uint8_t *data, uint32_t data_length,
                                               ZEGO::EXPRESS::ZegoVideoFrameParam frameParam) {
  // Scoped lock guard.
  {
    const std::lock_guard<std::mutex> lock(bufferMutex_);
    if (!TextureRegistered()) {
      return false;
    }

    if (srcBuffer_.size() != data_length) {
      // Update source buffer size.
      srcBuffer_.resize(data_length);
    }

    updateRenderSize(frameParam.width, frameParam.height);

    srcVideoFrameFormat_ = frameParam.format;

    std::copy(data, data + data_length, srcBuffer_.data());
  }
  OnBufferUpdated();
  return true;
};

// Marks texture frame available after buffer is updated.
void ZegoTextureRenderer::OnBufferUpdated() {
  if (TextureRegistered()) {
    textureRegistrar_->MarkTextureFrameAvailable(textureID_);
  }
}

const FlutterDesktopPixelBuffer* ZegoTextureRenderer::ConvertPixelBufferForFlutter(
    size_t target_width, size_t target_height) {
  // TODO: optimize image processing size by adjusting capture size
  // dynamically to match target_width and target_height.
  // If target size changes, create new media type for preview and set new
  // target framesize to MF_MT_FRAME_SIZE attribute.
  // Size should be kept inside requested resolution preset.
  // Update output media type with IMFCaptureSink2::SetOutputMediaType method
  // call and implement IMFCaptureEngineOnSampleCallback2::OnSynchronizedEvent
  // to detect size changes.

  // Lock buffer mutex to protect texture processing
  std::unique_lock<std::mutex> buffer_lock(bufferMutex_);
  if (!TextureRegistered()) {
    return nullptr;
  }

  const uint32_t bytes_per_pixel = 4;
  const uint32_t pixels_total = width_ * height_;
  const uint32_t data_size = pixels_total * bytes_per_pixel;
  if (/*data_size > 0 &&*/ srcBuffer_.size() > 0 /*== data_size*/) {
      if (destBuffer_.size() != srcBuffer_.size() /*data_size*/) {
          destBuffer_.resize(srcBuffer_.size() /*data_size*/);
    }

    // Map buffers to structs for easier conversion.
    switch (srcVideoFrameFormat_)
    {
    case ZEGO::EXPRESS::ZEGO_VIDEO_FRAME_FORMAT_BGRA32:
        srcFrameFormatToFlutterFormat<VideoFormatBGRAPixel>();
        break;
    case ZEGO::EXPRESS::ZEGO_VIDEO_FRAME_FORMAT_RGBA32:
        srcFrameFormatToFlutterFormat<VideoFormatRGBAPixel>();
        break;
    case ZEGO::EXPRESS::ZEGO_VIDEO_FRAME_FORMAT_ARGB32:
        srcFrameFormatToFlutterFormat<VideoFormatARGBPixel>();
        break;
    case ZEGO::EXPRESS::ZEGO_VIDEO_FRAME_FORMAT_ABGR32:
        srcFrameFormatToFlutterFormat<VideoFormatABGRPixel>();
        break;   
    default:
        break;
    }


    // MFVideoFormatRGB32Pixel* src =
    //     reinterpret_cast<MFVideoFormatRGB32Pixel*>(srcBuffer_.data());
    // FlutterDesktopPixel* dst =
    //     reinterpret_cast<FlutterDesktopPixel*>(destBuffer_.data());

    // for (uint32_t y = 0; y < height_; y++) {
    //   for (uint32_t x = 0; x < width_; x++) {
    //     uint32_t sp = (y * width_) + x;
    //     if (isUseMirror_) {
    //       // Software mirror mode.
    //       // IMFCapturePreviewSink also has the SetMirrorState setting,
    //       // but if enabled, samples will not be processed.

    //       // Calculates mirrored pixel position.
    //       uint32_t tp =
    //           (y * width_) + ((width_ - 1) - x);
    //       dst[tp].r = src[sp].r;
    //       dst[tp].g = src[sp].g;
    //       dst[tp].b = src[sp].b;
    //       dst[tp].a = 255;
    //     } else {
    //       dst[sp].r = src[sp].r;
    //       dst[sp].g = src[sp].g;
    //       dst[sp].b = src[sp].b;
    //       dst[sp].a = 255;
    //     }
    //   }
    // }

    if (!flutterDesktopPixelBuffer_) {
      flutterDesktopPixelBuffer_ =
          std::make_unique<FlutterDesktopPixelBuffer>();

      // Unlocks mutex after texture is processed.
      flutterDesktopPixelBuffer_->release_callback =
          [](void* release_context) {
            auto mutex = reinterpret_cast<std::mutex*>(release_context);
            mutex->unlock();
          };
    }

    flutterDesktopPixelBuffer_->buffer = destBuffer_.data();
    // double aspectRatio = width_/height_;
    // switch (viewMode_)
    // {
    // case ZEGO::EXPRESS::ZegoViewMode::ZEGO_VIEW_MODE_ASPECT_FILL:
    //   if (target_width <=  target_height) {
    //     height_ = target_height;
    //     width_ = height_ /aspectRatio;
    //   } else {
    //     width_ = target_width;
    //     height_ = width_*aspectRatio;
    //   }
    //   /* code */
    //   break;
    // case ZEGO::EXPRESS::ZegoViewMode::ZEGO_VIEW_MODE_ASPECT_FIT:
    //   if (target_width >=  target_height) {
    //     height_ = target_height;
    //     width_ = height_ /aspectRatio;
    //   } else {
    //     width_ = target_width;
    //     height_ = width_*aspectRatio;
    //   }
    //   break;
    // case ZEGO::EXPRESS::ZegoViewMode::ZEGO_VIEW_MODE_SCALE_TO_FILL:
    //   break;
    // default:
    //   break;
    // }
    flutterDesktopPixelBuffer_->width = width_;
    flutterDesktopPixelBuffer_->height = height_;

    // Releases unique_lock and set mutex pointer for release context.
    flutterDesktopPixelBuffer_->release_context = buffer_lock.release();

    return flutterDesktopPixelBuffer_.get();
  }
  return nullptr;
}

template<typename T>
void ZegoTextureRenderer::srcFrameFormatToFlutterFormat() 
{
    T* src =
        reinterpret_cast<T*>(srcBuffer_.data());
    FlutterDesktopPixel* dst =
        reinterpret_cast<FlutterDesktopPixel*>(destBuffer_.data());

    for (uint32_t y = 0; y < height_; y++) {
      for (uint32_t x = 0; x < width_; x++) {
        uint32_t sp = (y * width_) + x;
        if (isUseMirror_) {
          // Software mirror mode.
          // IMFCapturePreviewSink also has the SetMirrorState setting,
          // but if enabled, samples will not be processed.

          // Calculates mirrored pixel position.
          uint32_t tp =
              (y * width_) + ((width_ - 1) - x);
          dst[tp].r = src[sp].r;
          dst[tp].g = src[sp].g;
          dst[tp].b = src[sp].b;
          dst[tp].a = 255;
        } else {
          dst[sp].r = src[sp].r;
          dst[sp].g = src[sp].g;
          dst[sp].b = src[sp].b;
          dst[sp].a = 255;
        }
      }
    }
}