# Networking & API

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


## Request Option
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



## Response Option
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





## Interceptor

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


### Custom Interceptor
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


## User Defined Network Class

```dart
@injectable
class MyApi {

  Request<T> _request<T>() {
    return Request<T>.http()
      ..method = 'GET'
      ..baseUrl = 'https://my.api/'
      ..requestInterceptor = useAuthorizationBearerToken()
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