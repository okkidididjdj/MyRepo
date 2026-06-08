# Заставляем Theos собирать строго под iOS 5.0 и использовать legacy-компилятор
TARGET := iphone:clang:latest:5.0
ARCHS := armv7

# Прописываем минимальную версию для линковщика вручную
RetroChat_CFLAGS += -miphoneos-version-min=5.0
RetroChat_LDFLAGS += -miphoneos-version-min=5.0

# ВОТ ЭТА СТРОЧКА ОБЯЗАТЕЛЬНА ДЛЯ IPA:
THEOS_PACKAGE_FORMAT = ipa

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME := RetroChat
RetroChat_FILES := main.m AppDelegate.m AuthViewController.m ChatsListViewController.m ChatViewController.m
RetroChat_FRAMEWORKS := UIKit CoreGraphics Foundation

include $(THEOS)/makefiles/application.mk


