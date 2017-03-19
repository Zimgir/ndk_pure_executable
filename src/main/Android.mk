LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE:= test_main

LOCAL_SRC_FILES:= test_main.cpp

LOCAL_SHARED_LIBRARIES:= add

LOCAL_STATIC_LIBRARIES:= mul

LOCAL_C_INCLUDES := $(LOCAL_PATH)

#LOCAL_CPPFLAGS += -v

LOCAL_LDFLAGS := -fuse-ld=gold -g #-v

include $(BUILD_EXECUTABLE)