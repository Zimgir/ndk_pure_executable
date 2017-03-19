TOP_LOCAL_PATH:= $(call my-dir)/..

include $(CLEAR_VARS)

#include $(TOP_LOCAL_PATH)/lib/Android.mk

include $(TOP_LOCAL_PATH)/src/sub/Android.mk

include $(TOP_LOCAL_PATH)/src/main/Android.mk