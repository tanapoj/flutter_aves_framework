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
- Page-based State Management
- Networking
- Localization (ระบบหลายภาษา)
- Environment
- Logging
- UI and Theming

## Getting Started

การติดตั้ง [https://pub.dev/packages/aves/install](https://pub.dev/packages/aves/install)

เพิ่ม package ในโปรเจค

```
dependencies:
  aves: {{version}}
```

จากนั้นให้รันคำสั่ง `aves init` เพื่อสร้างไฟล์สำคัญสำหรับโปรเจค (ดูหัวข้อ [CLI](#cli))

### Flutter Version Management
ถ้าใช้ **fvm** ([https://fvm.app](https://fvm.app)) สามารถตั้งค่า config ให้ Aves รันคำสั่ง `flutter` ด้วย `fvm` ได้โดยใช้คำสั่ง
```
fvm flutter pub run aves init:config --use-fvm
```

## CLI

คำสั่งเพื่อแสดง cli ทั้งหมด (help)

```
fvm flutter pub run aves
```

### Init Project

ใช้คำสั่ง `init` เพื่อสร้างไฟล์ project

```
fvm flutter pub run aves init
```
flag
- `--dir`: กำหนดว่าจะสร้างโปรเจคที่ directory ไหน (default: `lib`)
- `--overwrite`: ถ้าต้องการให้เขียนไฟล์ทับไฟล์เดิม
- `--dry`: ถ้าต้องการทดสอบรัน ว่า cli จะสร้างไฟล์อะไรบ้างโดนไม่ต้องการให้สร้างไฟล์จริง

คำสั่งเพื่อรัน build_runner (ไฟล์ที่ต้องใช้การ generate)

```
fvm flutter pub run aves build
fvm flutter pub run aves build:model
fvm flutter pub run aves build:injectable
```
flag
- `--overwrite`: ถ้าต้องการให้เขียนไฟล์ทับไฟล์เดิม

การสร้างไฟล์

```
fvm flutter pub run aves make:page  ชื่อเพจ
fvm flutter pub run aves make:logic ชื่อโลจิค
fvm flutter pub run aves make:view  ชื่อวิว
fvm flutter pub run aves make:model ชื่อโมเดล
```
flag
- `--dir`: กำหนดว่าจะสร้างโปรเจคที่ directory ไหน (default: `lib/ui/pages` ยกเว้น model จะอยู่ที่ `lib/model`)
- `--overwrite`: ถ้าต้องการให้เขียนไฟล์ทับไฟล์เดิม
- `--dry`: ถ้าต้องการทดสอบรัน ว่า cli 
- `--blank`: สร้างไฟล์ด้วย template ที่ใช้โค้ดดขั้นต่ำที่สุด (ไม่มีตัวอย่างโค้ด)
- `--no-suffix`: ใช้สำหรับโมเดล ไม่ต้องการเติม suffix คำว่า `Model` ต่อท้าย



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

  factory MyPageLogic.build() {
    return MyPageLogic(
      builder: (bloc) => MyPageView(logic: bloc as MyPageLogic),
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

สามารถใช้ build-in helper `router` ในการสั่งเปลี่ยนหน้าเพจได้

เปลี่ยนหน้าเพจจาก MyPage ไป NextPage
```dart
class MyPageLogic extends ComponentLogic {
  _navigateNextPage() {
    router.push(NextPageLogic.build());
  }
}
```

กดกลับจากหน้า NextPage กลับมายัง MyPage
```dart
class NextPageLogic extends ComponentLogic {
  _navigateBack() {
    router.pop();
  }
}
```

## Routing with Result

หากต้องการส่งข้อมูลกลับไปหน้าก่อน สามารถสร้างได้ผ่านการใช้ NavigatorResult ซึ่งจะประกอบด้วย
- `resultRefKey`: ref สำหรับเช็กว่า result เป็นตัวที่ตรงกันหรือไม่ (เช่นหน้าเพจอาจจะส่งข้อมูลกลับได้หลายรูปแบบ หรือโดนเรียกจากหลายหน้า)
- `data`:  ข้อมูลที่ต้องการส่งกลับ (เป็น dynamic ดังนั้นหลังจากได้รับข้อมูลแล้วจะต้องทำการ type casing เอง)

```dart
class MyPageLogic extends ComponentLogic {
  _navigateNextPage() async {
    NavigatorResult result = await router.push(
        NextPageLogic.build(),
    );

    if (result.resultRefCode == ValueKey('res-1')) {
        int ans = result.data as int;
    }
  }
}

class NextPageLogic extends ComponentLogic {
  _navigateBack() {
    int ans = 123;
    router.pop(
        result: NavigatorResult(
            resultRefCode: ValueKey('res-1'),
            data: ans,
        ),
    );
  }
}
```


## Routing pop until

สามารถใช้ `until` เวลา pop สำหรับเลือกว่าจะทำการ pop กลับไปถึงหน้าไหน

ซึ่งสามารถกำหนด name หรือ `routeRefKey` ในหน้าต้นทางได้

เช่น ในกรณีนี้ ต้องการกดจากหน้าเพจ A -> B -> C และในหน้า C ต้องการส่งข้อมูลกลับไปยังหน้า A เลย (pop ข้ามหน้า B ไปเลย)

ขั้นต้องแรกจะต้องประกาศ routeRefKey ในหน้า A ตอนที่สั่ง `push` แล้วในหน้า C ที่ต้องการ pop กลับไปยังหน้า A (อาจจะแนบ result กลับไปด้วยก็ได้) ก็จะใช้ until

```dart
class A extends ComponentLogic {
  _navigateB() async {
    NavigatorResult result = await router.push(
        NextPageLogic.build(),
        routeRefKey: ValueKey('page-a'),
    );

    if (result.resultRefCode == ValueKey('res-1')) {
        int ans = result.data as int;
    }
  }
}

class B extends ComponentLogic {
    ...
}

class C extends ComponentLogic {
  _navigateBackToA() {
    int ans = 123;
    router.pop(
        result: NavigatorResult(
            resultRefCode: ValueKey('res-1'),
            data: ans,
        ),
        until: UntilPredecate.routeRefKey(ValueKey('page-a')),
    );
  }
}
```

> ถ้ามีการสั่ง push แต่ไม่ได้ตั้งค่า `routeRefKey` router จะใช้ `name` ของ Logic เป็นค่าแทน

การใช้ until สามารถเลือกได้ว่าจะ pop จนถึง root เลยหรือว่า routeRefKey ที่ตรงกับที่กำหนด (ถ้าไม่เจอเลย จะหยุดแค่ root)
```dart
UntilPredecate.root()
UntilPredecate.routeRefKey(key)
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