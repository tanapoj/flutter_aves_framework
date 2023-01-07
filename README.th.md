Aves Framework

- [CLI](#cli)
- [Init Project](#init-project)
- [Project Structure](#project-structure)

## Getting started

การติดตั้ง [https://pub.dev/packages/aves/install](https://pub.dev/packages/aves/install)

## CLI

คำสั่งเพื่อแสดง cli ทั้งหมด
```
fvm flutter pub run aves
```

### Init Project

ใช้คำสั่ง `init` เพื่อสร้างไฟล์ project 
```
fvm flutter pub run aves init
```

คำสั่งเพื่อรัน build_runner (ไฟล์ที่ต้องใช้การ generate)
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

```
+-- Page --+
|          |
|   Logic <----> Service <-+-> NetworkApi
|    |     |               |-> Database
|   View   |               |-> Preference
|          |
+----------+
```

## Dependency Injection

สำหรับ Aves ใช้ lib `injectable` ในการสร้างไฟล์สำหรับการทำ Dependency Injection ซึ่งสามารถสั่งสร้าง generated file ได้จาก cli:build

## Page

Aves ใช้การสร้าง Widget ด้วย `mvvm_bloc` ซึ่งประกอบด้วย `flutter_live_data` และ `bloc_builder`

```dart
class MyPageLogic extends ComponentLogic {
    @override
    String get name => 'my_page';

    MyPageLogic({
        Key? key,
        required Widget Function(ComponentLogic) builder,
    }) : super(key: key, builder: builder);

    factory MyPageLogic.build(String label) {
        return MyPageLogic(
                builder: (bloc) => MyPageView(
                logic: bloc as MyPageLogic,
                label: label,
            ),
        );
    }

    /// LiveData

    late final LiveData<int> $counter = LiveData(0).owner(this);

    /// LiveCycle Listener

    @override
    onCreate() {
        super.onCreate();
        // TODO เมื่อหน้าเพจถูกสร้าง (constructor)
    }

    @override
    onInit() {
        super.onInit();
        // TODO เมื่อหน้าเพจเริ่มทำงานครั้งแรก
    }

    @override
    onResume() {
        super.onResume();
        // TODO เมื่อหน้าเพจโดนเรียกหลังจาก pause ไป
    }

    @override
    onPause() {
        // TODO เมื่อหน้าเพจโดยซ่อนหรือย่อหน้าแอพลงไป
        super.onPause();
    }

    @override
    onDispose() {
        // TODO เมื่อหน้าเพจโดนทำลาย
        super.onDispose();
    }

    /// Method

    increment() {
        $counter.value++;
    }
}
```


```dart
class MyPageView extends app.View<MyPageLogic> {
  MyPageView(
      MyPageLogic logic, {
    Key? key,
  }) : super(logic, key: key);

  @override
  Widget build(BuildContext context) {
    return $watch(logic.$counter, (_, int counter){
      return Text('count is $count');
    });
  }
}

```

## Routing

## Networking

## Localization

## UI and Theming