# Aves Framework

### Content

- [Feature](#feature)
- [Getting Started](#getting-started)
- [CLI](#cli)
- [Init Project](#init-project)
- [Project Structure](#project-structure)

## Feature

Aves เป็นเฟรมเวิร์คสำหรับสร้าง Flutter Application

- BLoC and MVVM Pattern
- Networking
- UI and Theming
- Localization (ระบบหลายภาษา)
- Environment
- Page-based State Management

### Getting Started

การติดตั้ง [https://pub.dev/packages/aves/install](https://pub.dev/packages/aves/install)

เพิ่ม package ในโปรเจค

```
dependencies:
  aves: {{version}}
```

จากนั้นให้รันคำสั่ง `aves init` เพื่อสร้างไฟล์สำคัญสำหรับโปรเจค (ดูหัวข้อ [CLI](#cli))

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

การสร้างไฟล์

```
fvm flutter pub run aves make:page
fvm flutter pub run aves make:logic
fvm flutter pub run aves make:view
fvm flutter pub run aves make:model
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

- **app**: ไฟล์พื้นฐานของโปรเจค สามารถแก้ไขได้ (custom) สำหรับโปรเจคตัวเอง
- **common**: ฟังก์ชันและคำสั่งทั่วไป เช่น helper function
- **config**: การตั้งค่าสำหรับโปรเจค เช่นการกำหนดหน้าแรก หรือตั้งค่า environment
- **data**: เลเยอร์สำหรับจัดการ Data
    - **network**: endpoint สำหรับเรียกข้อมูลจาก API
    - **db**: Local Database
    - **preference**: Shared Preference
- **model**: โมเดลสำหรับเก็บข้อมูล
- **ui**:
    - **main**:
    - **pages**:
    - **widgets**:

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

สำหรับ Aves ใช้ lib `injectable` ในการสร้างไฟล์สำหรับการทำ Dependency Injection ซึ่งสามารถสั่งสร้าง
generated file ได้จาก cli:build

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
      builder: (bloc) =>
          MyPageView(
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
class MyPageView extends View<MyPageLogic> {
  MyPageView(MyPageLogic logic, {
    Key? key,
  }) : super(logic, key: key);

  @override
  Widget build(BuildContext context) {
    return SomeWidget(
      child: $watch(logic.$counter, (_, int counter) {
        return Text('count is $count');
      }),
    );
  }
}

```

## Routing

```dart
class MyPageLogic extends ComponentLogic {
  _navigateNextPage() {
    nav.push(context!, NextPage.build());
  }
}
```

```dart
class MyPageView extends View<MyPageLogic> {
  _navigateNextPage() {
    nav.push(context!, NextPage.build());
  }
}
```

### Routing with Result

การส่งข้อมูลระหว่างหน้า สามารถทำได้โดยเพิ่ม parameter ในฟังก์ชัน `build` และ constructor ได้เลย

```dart
class APage extends ComponentLogic {
  _navigateToB() async {
    NavigatorResult result = await nav.push(context!, BPage.build(
      label: 'Test Label',
    ));
    
    if(result.code == 123) {
      appLog.d('x is ${result['x']}');
    }
  }
}
```

ส่วนการส่งข้อมูลมาหน้าต้นทาง สามารถส่งผ่านคำสั่ง `pop` โดยสร้าง `NavigatorResult` ขึ้นมา

```dart
class BPage extends ComponentLogic {
  
  final String label;
  
  BPage({
    Key? key,
    required this.label,
    required Widget Function(ComponentLogic) builder,
  }) : super(key: key, builder: builder);

  factory BPage.build(String label) {
    return BPage(
      label: label,
      // other fields ...
    );
  }
  
  _navigateBackToA() {
    nav.pop(context!, result: NavigatorResult(
      code: 123,
      data: {
        'x': 1,
      },
    ));
  }
}
```

## Networking

```dart
@injectable
class MyNetworkApi {

  Request<T> request<T>() {
    return Request<T>.http()
      ..method = 'GET'
      ..baseUrl = 'https://api.myapi.co/'
      ..url = ''
      ..requestInterceptor = useAuthorizationBearerToken() + useMockData(fileName: 'test')
      ..responseInterceptor = useUnpackJSend() + useReAuth()
      ..body = RequestBodyJson({});
  }

  Request<List<MyModel>> getTestItems() {
    return request<List<MyModel>>()
      ..method = 'GET'
      ..url = 'items'
      ..mappingResponse = (dynamic body) {
        return <MyModel>[
          ...(jsonDecodeToIterable(body)).map((item) => MyModel.fromJson(jsonDecodeToMap(item))),
        ];
      };
  }
}
```

```dart
@injectable
class MyService {

  final MyNetworkApi api;

  MyService(this.api);

  Future<Result<List<MyModel>, Failure>> getTestItems() async {
    network.Response<List<MyModel>> response = await api.getTestItems().fetch();
    return response.toResult();
  }
}
```

## Localization

```dart
class MyPageLogic extends ComponentLogic {

  _changeLanguage() {
    if (translator.isUsingEnglish) {
      translator.useThai();
    }

    if (translator.isUsingThai) {
      translator.useEnglish();
    }
  }

}
```

```json
{
  "my_page": {
    "title": "This is my page"
  }
}
```

```dart
build(BuildContext context) {
  return Text(tt.my_page.title);
}
```

## UI and Theming

```dart
class MyPageLogic extends ComponentLogic {

  _changeTheme() {
    if (ui.isUsingTheme1) {
      ui.useTheme2();
    }

    if (ui.isUsingTheme2) {
      ui.useTheme1();
    }
  }

}
```

## Auth and User

```dart
class MyPageLogic extends ComponentLogic {

  _f() {
    if (auth.isLogin) {
      User user = auth.user!;
    }
  }

}
```

## AppProvider

- auth
- translate
- ui

```dart
class MyPageLogic extends ComponentLogic {

  _f() {
    app().override(
      context: AppContext()
        ..auth = AppAuth.mock(user: User()),
      action: (prev, cur) {
        // TODO  
      },
    );
  }

}
```