LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := AndroidVTS
LOCAL_MODULE_TAGS := optional
LOCAL_PACKAGE_NAME := AndroidVTS

vts_root  := $(LOCAL_PATH)
vts_dir   := app
vts_out   := $(PWD)/$(OUT_DIR)/target/common/obj/APPS/$(LOCAL_MODULE)_intermediates
vts_build := $(vts_root)/$(vts_dir)/build
vts_apk   := build/outputs/apk/$(vts_dir)-release-unsigned.apk

$(vts_root)/$(vts_dir)/$(vts_apk):
	rm -Rf $(vts_build)
	mkdir -p $(vts_out)
	ln -sf $(vts_out) $(vts_build)
	cd $(vts_root) && \
	APP_PROJECT_PATH=${HOME}/packages/apps/AndroidVTS/app/src/main \
	NDK_PROJECT_PATH=${HOME}/packages/apps/AndroidVTS/app/src/main \
	APP_BUILD_SCRIPT=${HOME}/packages/apps/AndroidVTS/app/src/main/jni/Android.mk \
	./gradlew assembleRelease

LOCAL_CERTIFICATE := shared
LOCAL_SRC_FILES := $(vts_dir)/$(vts_apk)
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)

include $(BUILD_PREBUILT)

