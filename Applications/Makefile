TARGET := iphone:clang:latest:5.0
ARCHS := armv7

# ВОТ ЭТА СТРОЧКА ОБЯЗАТЕЛЬНА ДЛЯ IPA:
THEOS_PACKAGE_FORMAT = ipa

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME := RetroChat
RetroChat_FILES := main.m AppDelegate.m AuthViewController.m ChatsListViewController.m ChatViewController.m
RetroChat_FRAMEWORKS := UIKit CoreGraphics

include $(THEOS)/makefiles/application.mk

