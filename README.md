# Aves Framework

> English Documentation at [https://github.com/tanapoj/aves/blob/main/README.en.md](https://github.com/tanapoj/aves/blob/main/README.en.md)

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
- Environment (ระบบแยกค่าตาม env)
- Logging
- UI and Theming

## Getting Started

การติดตั้ง [https://pub.dev/packages/aves/install](https://pub.dev/packages/aves/install)

เพิ่ม package ในโปรเจค

```yaml
dependencies:
  aves: {{version}}

dev_dependencies:
  build_runner: any
  json_serializable: ^6.5.4
  slang_build_runner: any
  injectable_generator:
```
package เสริมสำหรับ framework หากต้องการใช้สามารถติดตั้งเพิ่มได้
```yaml
dependencies:
  ...
  flutter_live_data: ^2.2.5
  bloc_builder: ^2.2.2
  mvvm_bloc: ^2.2.0

  dio: ^4.0.6
  get_it: ^7.2.0
  injectable: ^1.5.4
  logger: ^1.1.0
  shared_preferences: 2.0.15
  slang: 2.7.0
  slang_flutter: 2.7.0

dev_dependencies:
  ...
  build_runner: any
  json_serializable: ^6.5.4
  slang_build_runner: any
  injectable_generator:
```

จากนั้นให้รันคำสั่ง `aves init` เพื่อสร้างไฟล์สำคัญสำหรับโปรเจค (ดูหัวข้อ [CLI](#cli))

### Flutter Version Management
ถ้าใช้ **fvm** ([https://fvm.app](https://fvm.app)) สามารถตั้งค่า config ให้ Aves รันคำสั่ง `flutter` ด้วย `fvm` ได้โดยใช้คำสั่ง (ให้รันคำสั่งนี้ก่อนจะสั่ง `aves init`)
```
fvm flutter pub run aves init:config --use-fvm
```
ระบบจะสร้าง aves config file (`{{project-root}}/.aves/aves_config.yaml`) ทำให้การรันคำสั่ง CLI ทั้งหมดจะรันผ่าน FVM

## CLI

> หากใช้ FVM ให้เติม `fvm` นำหน้าคำสั่งทั้งหมดต่อไปนี้

คำสั่งเพื่อแสดง cli ทั้งหมด (help)

```
flutter pub run aves
```

### Init Project

ใช้คำสั่ง `init` เพื่อสร้างไฟล์ project

```
flutter pub run aves init
```
flag
- `--dir`: กำหนดว่าจะสร้างโปรเจคที่ directory ไหน (default: `lib`)
- `--overwrite`: ถ้าต้องการให้เขียนไฟล์ทับไฟล์เดิม
- `--dry`: ถ้าต้องการทดสอบรัน ว่า cli จะสร้างไฟล์อะไรบ้างโดนไม่ต้องการให้สร้างไฟล์จริง

คำสั่งเพื่อรัน build_runner (ไฟล์ที่ต้องใช้การ generate)

```
flutter pub run aves generate
flutter pub run aves generate:model
flutter pub run aves generate:injectable
```
flag
- `--overwrite`: ถ้าต้องการให้เขียนไฟล์ทับไฟล์เดิม

การสร้างไฟล์

```
flutter pub run aves make:page  ชื่อเพจ
flutter pub run aves make:logic ชื่อโลจิค
flutter pub run aves make:view  ชื่อวิว
flutter pub run aves make:model ชื่อโมเดล
```
flag
- `--dir`: กำหนดว่าจะสร้างโปรเจคที่ directory ไหน (default: `lib/ui/pages` ยกเว้น model จะอยู่ที่ `lib/model`)
- `--overwrite`: ถ้าต้องการให้เขียนไฟล์ทับไฟล์เดิม
- `--dry`: ถ้าต้องการทดสอบรัน ว่า cli 
- `--blank`: สร้างไฟล์ด้วย template ที่ใช้โค้ดดขั้นต่ำที่สุด (ไม่มีตัวอย่างโค้ด)
- `--no-suffix`: ใช้สำหรับโมเดล ไม่ต้องการเติม suffix คำว่า `Model` ต่อท้าย

> การสร้าง directory, filename จะใช้ snake_case เสมอ และชื่อคลาสจะใช้ camelCase เสมอ (ถ้าใส่ case อื่นมา CLI จะทำการ convert เป็น snake, camel ให้ทันที)


## Project Structure

```
|-- lib
|   |-- app
|   |   |-- app_auth.dart
|   |   |-- app_component.dart
|   |   |-- app_navigator.dart
|   |   |-- app_provider.dart
|   |   |-- app_translator.dart
|   |   |-- app_ui.dart
|   |   |-- global_var.dart
|   |   '-- environment.dart
|   |-- common
|   |   |-- extension/
|   |   '-- helpers.dart
|   |-- config
|   |   |-- env/
|   |   |-- lang/
|   |   |-- theme/
|   |   |-- assets.dart
|   |   |-- di.dart
|   |   '-- startup.dart
|   |-- data
|   |   |-- db/
|   |   |-- network/
|   |   |-- preference/
|   |   '-- service/
|   |-- model
|   |   |-- api/
|   |   |-- local/
|   |   '-- user.dart
|   |-- ui
|   |   |-- main/
|   |   |-- pages/
|   |   '-- widgets/
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
    - **service**: คลาสสำหรับเก็บ business logic หลัก
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
|   View   |               '-> Preference
|          |
+----------+
```

โครงสร้างของ page จะประกอบด้วยไฟล์ Logic ที่จะเป็นโลจิคหลักของหน้า และ View ที่จะเป็นส่วนแสดงผลของหน้า

ทั้งสองคลาสจะทำงานเชื่อมกัน และรับส่งข้อมูลผ่านกันตามแพทเทิร์น BLoC โดยใช้ไลบรารี่ flutter_live_data และ bloc_builder

## Dependency Injection

สำหรับ Aves ใช้ lib `injectable` ในการสร้างไฟล์สำหรับการทำ Dependency Injection ซึ่งสามารถสั่งสร้าง
generated file ได้จาก cli generate

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
    // มีการ push ไปยังหน้า C อีกที
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


## Networking & API

การเชื่อมต่อ API สำหรับเฟรมเวิร์ค Aves จะใช้คลาส `Request` และ `Response` ซึ่งเป็น Wrapper Class ครอบ `dio` อีกทีหนึ่ง

หลักการคือเราจะต้องสร้าง `Request` ขึ้นมาก่อนซึ่งประกอบด้วยรายละเอียดว่าจะส่งข้อมูลไปที่ไหน และสั่ง `fetch()` จากนั้นจะได้ผลลัพธ์เป็น `Response` กลับมา

ตัวอย่างเช่น

```dart
Request<String> req = Request<String>.http()
    ..method = 'GET'
    ..baseUrl = 'https://my.api/v1/'
    ..url = 'test';

Response<String> res = await req.fetch();
```

เนื่องจากใช้ Dio เป็นตัวสร้าง request ถ้าต้องการกำหนด Dio ลงไปเองก็ทำได้ดังนี้

```dart
var dio = Dio()
    ..options.connectTimeout = 400
    ..options.receiveTimeout = 3000;
var cancelToken = CancelToken();
Response<String> res = await req.fetch(
    dio: dio,
    cancelToken: cancelToken,
);
```


### Request Option
```dart
Request<String> req = Request<String>.http()
    ..method = 'GET'
    ..baseUrl = 'https://my.api/v1/'
    ..url = 'test'
    ..isIncludeBaseUrl = true
    ..contentType = RequestContentType.json
    ..body = RequestBodyJson({
        'id': 1,
        'name': 'test',
      })
    ..headers = {}
    ..queryParameter = {}
    ..queryParameters = [
        {'filter': 'name'},
        {'filter': 'score'},
    ]
    ..requestInterceptor = useMockData(fileName: 'test')
    ..responseInterceptor = useReAuth()
    ..mappingResponse = (body, response) => jsonDecode(body)
```

#### `method`
GET POST PUT DELETE และอื่นๆ

#### `baseUrl`
base url สำหรับการเรียก API

#### `url`
endpoint สำหรับการเรียก

#### `isIncludeBaseUrl`
*[default: `true`]* ให้เพิ่ม `baseUrl` เข้าไปใน url ตอนเรียกไปยัง API หรือไม่ (ถ้าเป็น `false` จะใช้แค่ `url` ในการเรียก)

#### `contentType`
*[default: `json`]* ชนิดของข้อมูล body ที่แนบไปใน request

#### `body`
ข้อมูล body ที่แนบไปใน request

#### `headers`
header ที่แนบไปใน request

#### `queryParameter`
query string parameter ที่แนบไปใน request

#### `queryParameters`
ในกรณีที่ต้องการส่ง `queryParameter` ที่มี key ซ้ำกันจะใช้ `queryParameters` แทน ซึ่งสามารถกำหนดเป็น list ได้ (ถ้ากำหนดมาทั้ง `queryParameter` และ `queryParameters` จะนำทั้งสองค่ามา merge รวมกัน)

#### `requestInterceptor`
interceptor ที่จะทำงานก่อนการส่ง request เช่นการกำหนด Authorization Bearer Token แนบไปใน header, การกำหนดให้ใช้ข้อมูล mockup data แทนการเรียก request จริง เป็นต้น

#### `responseInterceptor`
interceptor ที่จะทำงานหลังจากได้รับ response มาแล้ว เช่นการเช็กว่า status=401 (Authorization Fail) หรือไม่ ให้ไป Authorization มาใหม่ก่อนจะลอง request อีกครั้ง, หรือการ transform โครงสร้างข้อมูลที่ส่งกลับมา เป็นต้น

#### `mappingResponse`
การทำ mapping ข้อมูลที่อยู่ในรูป String หรือ Map ให้กลายเป็น Model ที่เราต้องการ



### Response Option
```dart
>>  message: ok  
>>  statusCode: 200  
>>  body:    {"id":1,"title":"iPhone 9","description":"An apple mobile which is nothing like apple","price":549} 
>>  data:    ProductModel{1,iPhone 9,An apple mobile which is nothing like apple,549}
>>  error:   null  
>>  headers: {connection: [keep-alive], content-type: [application/json], transfer-encoding: [chunked], date: [Wed, 01 Feb 2023 04:25:26 GMT], server: [nginx], content-range: [products 0-5/100]}  
>>  extra:   {pagination: {from: 0, to: 5, total: 100}}  
```

#### `message`
message สถานะของ response เช่น ok ในกรณีที่ API ตอบกลับมาได้สำเร็จ หรือ error message อื่นๆ ในกรณีที่มีข้อผิดพลาดเกิดขึ้น

#### `statusCode`
http statsu code ของ response

#### `body`
raw string ที่ได้รับจากการเรียก โดยที่ไม่ผ่านการโปรเซส

#### `data`
data ที่ transform มาจากข้อมูลใน body เป็น Map หรือ Model ต่างๆ ที่เรากำหนดใน mappingResponse ตอนสร้าง request

#### `error`
เหมือนกับ `data` แต่จะมีค่าในกรณีที่เกิด fail หรือ error แทน โดยไทป์จะเป็น dynamic เสมอ

#### `header`
header จะได้รับจาก response

#### `extra`
extra field สำหรับการแนบข้อมูลพิเศษ ไทป์เป็น dynamic





### Interceptor

ทำหน้าที่เป็นตัวขั้นกลางระหว่างก่อน request และหลังจากได้รับ response มา

โดยที่ interceptor บางตัวอาจจะสั่งให้ข้ามการ fetch ข้อมูลจริงๆ (เช่น useMockData ที่สั่งให้ใช้ข้อมูล mock แทนการ fetch จริงๆ) หรือสั่งให้โปรเซสทั้งหมดหยุดการทำงานเลยก็ได้ (เช่น useUnboxedJSend ที่ถ้าเจอว่า json ที่ได้รับผิดฟอร์แมทไปก็จะสั่งให้ตอบ Error ทันที)

```
      create request
         |
         v
+----> start
|        |
|        v
|    run request-interceptor 1, 2, 3 ...  ---+
|        |                                   |
|        v                                   |
|    fetch request         +-----------------+
|        |                 |                  
|        v                 v                  
+--- run response-interceptor 1, 2, 3 ...  --+
         |                                   |
         v                                   |
     mapping response                        |
         |                                   |
         v                                   |
       done <--------------------------------+
```


#### Custom Interceptor
เราสามารถสร้าง interceptor เองได้ ตัวอย่างเช่น

#### Use Case 1
ต้องการจะให้ request มีการเพิ่ม user token เข้าไปด้วยทุกครั้ง แต่ไม่อยากเขียนใน `headers` เองตลอด

```dart
RequestInterceptor useUserAuthorizationToken() {
  return RequestInterceptor(interceptor: (Request request) async {
    return RequestInterceptorFlow(
      request
        ..queryParameter['Authorization'] = user.token
        // or
        ..headers['Authorization'] = 'Bearer ${user.token}',
    );
  });
}
```


#### Use Case 2

ต้องการใช้ JSend API Structure  แต่ก็เจอปัญหาว่าต้องสร้าง Model หลายชั้น

ถ้าเป็นการเรียก request ธรรมดาแล้วได้รับ json รูปแบบนี้มา

```json
{
    "id":1,
    "title":"iPhone 9",
    "description":"An apple mobile which is nothing like apple",
    "price":549
}
```

การเขียน mapping ก็จะตรงไปตรงมา คือสามารถ parse json เป็น Model ได้เลย

```dart
_request<Product>()
    ..method = 'GET'
    ..url = 'products/$id'
    ..mappingResponse = (dynamic body) {
        return Product.fromJson(ensureJsonDecodeToMap(body));
    };
```

แต่สำหรับโครงสร้างแบบ JSend แล้ว จะมีโครงสร้างชั้น `data` เพิ่มเข้ามาอีก ดังนี้

```json
{
    "status": "success",
    "data": {
        "product": {
            "id":1,
            "title":"iPhone 9",
            "description":"An apple mobile which is nothing like apple",
            "price":549
        }
    }
}
```
ทำให้จะต้องสร้าง Model ขึ้นมาเพิ่ม
```dart
class JSendWrapper {
    @JsonKey(name: 'status') final String status;
    @JsonKey(name: 'data') final JSendDataWrapper data;
    ...
}

class JSendDataWrapper {
    @JsonKey(name: 'product') final Product product;
    ...
}
```
และผลสุดท้ายแทนที่จะสามารถ mapping เป็น `Product` ก็จะได้ผลลัพธ์เป็น `JSendWrapper` แทนอีก
```dart
_request<JSendWrapper>()
    ..method = 'GET'
    ..url = 'products/$id'
    ..mappingResponse = (dynamic body) {
        return JSendWrapper.fromJson(ensureJsonDecodeToMap(body));
    };

Product product = response.data.data.product;
```

ในเคสนี้ เราสามารถสร้าง interceptor มาเพื่อถอดโครงสร้างของ JSend ออกไปได้
```dart
ResponseInterceptor useUnboxedJSend() {
  return ResponseInterceptor(interceptor: (Response response) async {
    try {
      return ResponseInterceptorFlow(
        response..data = jsonDecode(response.data)['data'],
      );
    } catch (e) {
      var errorMessage = 'Interceptor: useUnpackJSend Error, cannot unwrap = ${response.data}');
      return ResponseInterceptorFlow(
        ResponseCustomError(
          error: null,
          body: response.body,
          statusCode: response.statusCode,
          headers: response.headers,
          message: errorMessage,
        ),
        terminate: true,
      );
    }
  });
}
```

ตอนที่จะเขียน mapping ก็จะเหลือแต่โครงสร้าง `data` เราก็แค่กำหนดต่อว่าต้องการฟิลด์ `product` เอาไปสร้างเป็น Model ต่อได้เลย
```dart
_request<Product>()
    ..method = 'GET'
    ..url = 'products/$id'
    ..responseInterceptor = useUnboxedJSend()
    ..mappingResponse = (dynamic body) {
        return Product.fromJson(ensureJsonDecodeToMap(body)['product']);
    };

Product product = response.data;
```

### Build-in Interceptor

interceptor ที่ Aves เตรียมไว้ให้ถ้าใช้ template ของโปรเจค 

ซึ่งสามารถแก้ไข interceptor แต่ละตัวให้เขากับความต้องการของแต่ละโปรเจคได้

location: `/lib/data/network/interceptor.dart`

#### useUserAuthorizationToken (Request)
code: `useUserAuthorizationToken()` เพิ่ม token เข้าไปใน request header

#### useMockData (Request)
code: `useMockData(fileName: 'test.json')` ถ้า environment เป็น mock-data จะดึงข้อมูลจากไฟล์ json ที่กำหนดแทนการ fetch request

#### useRetry (Response)
code: `useRetry(limit: 3)` ถ้าข้อมูลที่ได้มา statusCode ไม่ใช่ `2xx` จะทำการวนยิง request ใหม่อีก `limit` ครั้ง

#### useReAuth (Response)
code: `useReAuth()` จะทำการเช็กว่า response มี statusCode=`401` หรือไม่ ถ้าเป็น 401 จะทำการเรียกไปขอ user token ใหม่ก่อนจะยิง request แรกให้ซ้ำอีกที

#### useUnboxedJSend (Response)
code: `useUnboxedJSend()` แกะโครงสร้างข้อมูลออกจาก JSend

#### useContentRangePagination (Response)
code: `useContentRangePagination()` ดึงข้อมูล Content-Range ที่เป็น Pagination ออกมาแล้วใส่ลงใน extra เตรียมไว้ให้


### User Defined Network Class

```dart
@injectable
class MyApi {

  Request<T> _request<T>() {
    return Request<T>.http()
      ..method = 'GET'
      ..baseUrl = 'https://my.api/'
      ..requestInterceptor = useAuthorizationBearerToken() + useMockData(fileName: 'example.json')
      ..responseInterceptor = useRetry(limit: 3);
  }

  Request<List<Product>> getProducts() {
    return _request<List<Product>>()
      ..method = 'GET'
      ..url = 'products'
      ..mappingResponse = (dynamic body) {
        return <Product>[
          ...(jsonDecodeToIterable(body)).map((item) => Product.fromJson(ensureJsonDecodeToMap(item))),
        ];
      };
  }

  Request<Product> getProduct(int id) {
    return _request<Product>()
      ..method = 'GET'
      ..url = 'products/$id'
      ..mappingResponse = (dynamic body) {
        return Product.fromJson(ensureJsonDecodeToMap(body));
      };
  }
}
```

## Localization

สำหรับระบบหลายภาษา สามารถกำหนดไฟล์ภาษาได้ที่ `assets/lang` ใช้ได้ทั้งรูปแบบ yaml และ json

ตัวอย่างเช่น
```json
{
  "my_page": {
    "title": "This is my page"
  }
}
```
หรือ
```yaml
my_page:
  title: "This is my page"
```

ตัวแปรภาษาทั้งหมดจะเป็นการ generate ขึ้นมา ดังนั้นถ้ามีการแก้ไขไฟล์ภาษาจะต้องสั่งรัน `aves generate` ใหม่ทุกครั้ง

และสามารถเรียกใช้ตัวแปรภาษาได้จาก global variable ชื่อ `tt` (Text Translate) ตามด้วยชื่อที่กำหนดในไฟล์ yaml หรือ json

```dart
build(BuildContext context) {
  return Text(tt.my_page.title);
}
```

ส่วนการสั่งเปลี่ยนภาษาจะสั่งผ่าน build-in helper ชื่อ `translator` ซึ่งสามารถกำหนดได้ใน app_translator

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