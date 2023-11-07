# CORP device management app 

# Intro
This repository contains two apps for managing devices in Applifting. The app is divided into 
a) Service app
b) Client app

### 📚 Libraries
- [Riverpod](https://riverpod.dev/docs/getting_started) (state management)
- [Freezed](https://pub.dev/packages/freezed) & [json_serializable](https://pub.dev/packages/json_serializable) (data models, union types, JSON)
- [Dio](https://pub.dev/packages/dio) (HTTP)
- [Hive](https://pub.dev/packages/hive) (local DB)
- [go_router](https://pub.dev/packages/go_router) (routing)

### 🌍 Localization
- Localization is done by shared Sheet document and build by [flutter_localization_sheet](https://github.com/aloisdeniel/flutter_sheet_localization)
- [Localization sheet](https://docs.google.com/spreadsheets/d/sheet/edit#gid=0)

### 🌆 Assets, Fonts
- Use [FlutterGen](https://github.com/FlutterGen/flutter_gen/)

# ℹ️ Getting Started
The app has two flavours:
1. STAGE 
2. PROD

This config is given in runtime by ``--dart-define=environment=STAGE`` when running build command. Read section below how to run the right flavour app without any hassle by simple predefined commands.  

## Setup
- This project is build with Flutter 3.3.x (for Android there is need to use 3.0.x because of internal changes in platform views)
- There is [Makefile](https://git.applifting.cz/stepan.zalis/corp-devices/-/blob/dev/Makefile) that shortcuts all common flutter commands 

```shell script
$ make dependencies
$ make build-runner
```

### How to add assets (images, icons, ...)
1. Add assets
2. Run [FlutterGen](https://github.com/fluttergen) -> run ``make build-runner``

### Make .apk and .ipa file
Android
```shell script
$ make build-android-dev
$ make build-android-prod
```

iOS
```shell script
$ make build-ios-dev
$ make build-ios-prod
```

### Run app
```shell script
$ make run-dev
$ make run-prod
```

