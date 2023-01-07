Aves Framework

## Getting started

การติดตั้ง [https://pub.dev/packages/aves/install](https://pub.dev/packages/aves/install)

## CLI

```
fvm flutter pub run aves
```

```
fvm flutter pub run aves init
```

```
fvm flutter pub run aves build
fvm flutter pub run aves build:model
fvm flutter pub run aves build:injectable
```

```
fvm flutter pub run aves make:page
```

## Project Structure
```
|-- lib
|   |-- app
|   |   |-- app_auth.dart
|   |   |-- app_component.dart
|   |   |-- app_navigator.dart
|   |   |-- app_provider.dart
|   |   |-- app_translator.dart
|   |   '-- environment.dart
|   |-- common
|   |   '-- helpers.dart
|   |-- config
|   |-- data
|   |-- model
|   |-- ui
|   |   |-- main
|   |   |-- pages
|   |   '-- widgets
|   '-- main.dart
|
|-- build.yaml
'-- .aves
    '-- aves_config.json
```

## Dependency Injection

## Page

Aves ใช้การสร้าง Widget ด้วย `mvvm_bloc` ซึ่งประกอบด้วย `flutter_live_data` และ `bloc_builder`

## Routing

## Networking

## Localization

## UI and Theming