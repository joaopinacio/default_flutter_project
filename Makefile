# Flutter Makefile for easier command execution
.PHONY: help clean get pod-install build test analyze format upgrade fresh

# Default target
help:
	@echo "Flutter Development Commands:"
	@echo ""
	@echo "Setup & Dependencies:"
	@echo "  make get          - Get dependencies (flutter pub get)"
	@echo "  make pod-install  - Install iOS CocoaPods dependencies"
	@echo "  make upgrade      - Upgrade Flutter and dependencies"
	@echo ""
	@echo "Code Quality:"
	@echo "  make test         - Run all tests"
	@echo "  make analyze      - Analyze code for issues"
	@echo "  make format       - Format code"
	@echo "  make lint         - Run analyzer and formatter"
	@echo ""
	@echo "Maintenance:"
	@echo "  make clean        - Clean build files"
	@echo "  make fresh        - Clean and get dependencies"
	@echo "  make reset        - Complete reset (clean + get + upgrade)"
	@echo ""
	@echo "Device Management:"
	@echo "  make devices      - List connected devices"
	@echo "  make emulators    - List available emulators"
	@echo ""

# Dependencies and Setup
get:
	@echo "📦 Getting dependencies..."
	flutter pub get

pod-install:
	@echo "🍎 Installing iOS pods..."
	@cd ios && rm -rf Podfile.lock && pod deintegrate && pod repo update && pod install

upgrade:
	@echo "⬆️ Upgrading Flutter and dependencies..."
	flutter upgrade
	flutter pub upgrade

# Building
build-apk:
	@echo "🏗️ Building APK..."
	flutter build apk --release

build-ios:
	@echo "🏗️ Building for iOS..."
	flutter build ios --release

build-all: build-apk build-ios

# Testing
test:
	@echo "🧪 Running all tests..."
	flutter test

test-coverage:
	@echo "🧪 Running tests with coverage..."
	flutter test --coverage

# Code Quality
analyze:
	@echo "🔍 Analyzing code..."
	flutter analyze

format:
	@echo "✨ Formatting code..."
	dart format .

lint: analyze format
	@echo "🧹 Code linting completed"

# Maintenance
clean:
	@echo "🧹 Cleaning build files..."
	flutter clean

fresh: clean get
	@echo "🔄 Fresh start completed"

reset: clean upgrade
	@echo "🔄 Complete reset completed"

# Device Management
devices:
	@echo "📱 Connected devices:"
	flutter devices

emulators:
	@echo "📱 Available emulators:"
	flutter emulators