TARGET := iphone:clang:latest:5.0
ARCHS := armv7

THEOS_PACKAGE_FORMAT = ipa

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME := RetroChat
# Убираем main.m и AppDelegate.m — Theos сгенерирует их сам автоматически!
RetroChat_FILES := AuthViewController.m ChatsListViewController.m ChatViewController.m
RetroChat_FRAMEWORKS := UIKit CoreGraphics Foundation

include $(THEOS)/makefiles/application.mk




