[English](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/README.md) | [한국어](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ko_KR/README.md) | [简体中文](https://github.com/rrousselGit/freezed/blob/master/resources/translations/zh_CN/README.md) | [日本語](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ja_JP/README.md) | [Tiếng Việt](https://github.com/rrousselGit/freezed/blob/master/resources/translations/vi_VN/README.md)

![Build](https://github.com/rrousselGit/freezed/workflows/Build/badge.svg)
[![pub package](https://img.shields.io/pub/v/freezed.svg)](https://pub.dartlang.org/packages/freezed)
<a href="https://discord.gg/GSt793j6eT"><img src="https://img.shields.io/discord/765557403865186374.svg?logo=discord&color=blue" alt="Discord"></a>

[<img src="https://raw.githubusercontent.com/rrousselGit/provider/master/resources/flutter_favorite.png" width="200" />](https://flutter.dev/docs/development/packages-and-plugins/favorites)

Chào mừng bạn tới [Freezed], Freezed là một công cụ tạo mã cho các lớp dữ liệu, union và cloning.

> [!NOTE]
> Một phiên bản xem trước của Freezed sử dụng macro hiện đã có sẵn.
> Chi tiết vui lòng tham khảo tại <https://github.com/rrousselGit/freezed/tree/macros>.

# Động lực

Dart là một ngôn ngữ tuyệt vời, nhưng việc định nghĩa "model" khá phức tạp. Thông thường, bạn cần làm những việc sau:

- Định nghĩa constructor và các thuộc tính (properties)
- Ghi đè (override) `toString`, `operator ==`, `hashCode`
- Cài đặt (implement) `copyWith` để sao chép đối tượng
- Xử lý serialize và deserialize

Khi thực hiện tất cả những điều này, bạn sẽ cần hàng trăm dòng mã và dễ gặp lỗi, đồng thời làm giảm tính dễ đọc của model.

Freezed được thiết kế để tự động thực hiện hầu hết các công việc trên, giúp bạn chỉ cần tập trung vào việc định nghĩa model.

| Trước                                                                                       | Sau                                                                                         |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| ![before](https://raw.githubusercontent.com/rrousselGit/freezed/refs/heads/master/resources/before.png) | ![before](https://raw.githubusercontent.com/rrousselGit/freezed/master/resources/after.png) |

# Mục lục

- [Động lực](#động-lực)
- [Mục lục](#mục-lục)
- [Cách sử dụng](#cách-sử-dụng)
    - [Cài đặt](#cài-đặt)
        - [Vô hiệu hóa cảnh báo `invalid_annotation_target` và cảnh báo trong file đã tạo](#vô-hiệu-hóa-cảnh-báo-invalid_annotation_target-và-cảnh-báo-trong-file-đã-tạo)
    - [Chạy trình tạo mã](#chạy-trình-tạo-mã)
    - [Tạo mô hình với Freezed](#tạo-mô-hình-với-freezed)
        - [Định nghĩa lớp có thể thay đổi thay vì lớp bất biến](#định-nghĩa-lớp-có-thể-thay-đổi-thay-vì-lớp-bất-biến)
        - [Cho phép thay đổi Lists/Maps/Sets](#cho-phép-thay-đổi-listsmapssets)
        - [Cơ chế của `copyWith`](#cơ-chế-của-copywith)
        - [Phát triển: Deep copy](#phát-triển-deep-copy)
        - [Thêm getter và method vào models](#thêm-getter-và-method-vào-models)
        - [Assert](#assert)
        - [Giá trị mặc định](#giá-trị-mặc-định)
        - [Decoder và comment](#decoder-và-comment)
        - [Sử dụng Mixin và Interface để tạo kiểu tổng hợp cho từng lớp](#sử-dụng-mixin-và-interface-để-tạo-kiểu-tổng-hợp-cho-từng-lớp)
    - [FromJson và ToJson](#fromjson-và-tojson)
        - [fromJSON - Các lớp có nhiều constructor](#fromjson---các-lớp-có-nhiều-constructor)
        - [Deserialize lớp generic](#deserialize-lớp-generic)
    - [Kiểu Union](#kiểu-union)
        - [Thuộc tính chia sẻ](#thuộc-tính-chia-sẻ)
        - [Cách sử dụng pattern matching để đọc các thuộc tính không chia sẻ](#cách-sử-dụng-pattern-matching-để-đọc-các-thuộc-tính-không-chia-sẻ)
            - [(Legacy) Utility pattern matching](#legacy-utility-pattern-matching)
                - [When](#when)
                - [Map](#map)
    - [Cấu hình](#cấu-hình)
        - [Thay đổi hành vi cho một mô hình cụ thể](#thay-đổi-hành-vi-cho-một-mô-hình-cụ-thể)
        - [Thay đổi hành vi cho toàn bộ dự án](#thay-đổi-hành-vi-cho-toàn-bộ-dự-án)
- [Tiện ích](#tiện-ích)
    - [Extension IDE](#extension-ide)
        - [Extension Freezed cho VSCode](#extension-freezed-cho-vscode)
        - [Extension Freezed cho IntelliJ và Android Studio](#extension-freezed-cho-intellij-và-android-studio)
    - [Công cụ của bên thứ ba](#công-cụ-của-bên-thứ-ba)
        - [DartJ](#dartj)
    - [Nhà tài trợ](#nhà-tài-trợ)

# Cách sử dụng

## Cài đặt

Để sử dụng [Freezed], bạn cần thiết lập thông thường cho [build_runner]/code-generator.\
Đầu tiên, thêm [build_runner] và [Freezed] vào file `pubspec.yaml` theo các bước dưới đây.

Dành cho dự án Flutter:

```console
flutter pub add freezed_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
# Nếu muốn tạo fromJson/toJson với Freezed, thêm dòng sau:
flutter pub add json_annotation
flutter pub add dev:json_serializable
```

Dành cho dự án Dart:

```console
dart pub add freezed_annotation
dart pub add dev:build_runner
dart pub add dev:freezed
# Nếu muốn tạo fromJson/toJson với Freezed, thêm dòng sau:
dart pub add json_annotation
dart pub add dev:json_serializable
```

Điều này sẽ cài đặt ba gói sau:

- [build_runner](https://pub.dev/packages/build_runner): Công cụ chạy trình tạo mã
- [freezed]: Trình tạo mã
- [freezed_annotation](https://pub.dev/packages/freezed_annotation): Gói chứa annotation cho [freezed]

### Vô hiệu hóa cảnh báo `invalid_annotation_target` và cảnh báo trong file đã tạo

Khi sử dụng [Freezed] kết hợp với `json_serializable`, với phiên bản mới nhất của `json_serializable` và `meta`, có thể bạn sẽ cần phải vô hiệu hóa cảnh báo `invalid_annotation_target`.

Để làm điều này, hãy thêm đoạn mã sau vào file `analysis_options.yaml` tại thư mục gốc của dự án:

```yaml
analyzer:
  errors:
    invalid_annotation_target: ignore
```

## Chạy trình tạo mã

Để chạy trình tạo mã, hãy thực hiện lệnh sau:

```
dart run build_runner build
```

Giống như hầu hết các trình tạo mã khác, khi sử dụng [Freezed], bạn cần import annotation ([freezed_annotation]) và sử dụng từ khóa `part` ở đầu file.

Do đó, file muốn sử dụng [Freezed] sẽ bắt đầu như sau:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_file.freezed.dart';
```

**Lưu ý**: Cũng hãy import `package:flutter/foundation.dart`.
Lý do là vì khi import `foundation.dart`, các lớp giúp đọc đối tượng một cách dễ dàng hơn trong devtool của Flutter sẽ được import cùng.
Khi import `foundation.dart`, [Freezed] sẽ tự động thực hiện điều này cho bạn.

## Tạo mô hình với Freezed

Một ví dụ cụ thể sẽ dễ hiểu hơn là một mô tả trừu tượng, vì vậy dưới đây là một lớp Freezed điển hình:

```dart
// Đây là file "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// Bắt buộc: Liên kết file này với mã được tạo ra bởi Freezed
part 'main.freezed.dart';
// Tùy chọn: Lớp Person có thể serialize, vì vậy bạn cần thêm dòng này.
// Nếu Person không thể serialize, bạn có thể bỏ qua dòng này.
part 'main.g.dart';

@freezed
class Person with _$Person {
  const factory Person({
    required String firstName,
    required String lastName,
    required int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);
}
```

Đoạn mã sau định nghĩa một mô hình có tên là `Person`:

- `Person` có 3 thuộc tính: `firstName`, `lastName`, và `age`.
- Vì sử dụng `@freezed`, nên tất cả các thuộc tính của lớp này là bất biến.
- Vì có định nghĩa phương thức `fromJson`, lớp này có thể thực hiện deserialize và serialize.
  Freezed sẽ tự động thêm phương thức `toJson`.
- Freezed cũng tự động tạo ra các phương thức sau:
    - Phương thức `copyWith` giúp sao chép đối tượng với các thuộc tính khác nhau.
    - Phương thức `toString` ghi đè để liệt kê tất cả các thuộc tính của đối tượng.
    - Phương thức `operator ==` và `hashCode` ghi đè (vì `Person` là lớp bất biến).

Từ ví dụ này, có thể rút ra một số điều:

- Lớp mô hình cần có annotation `@freezed` (hoặc `@Freezed`, `@unfreezed` như sẽ đề cập sau).
  Annotation này chỉ dẫn cho Freezed tạo mã cho lớp đó.

- Cần áp dụng mixin với tên lớp có tiền tố `_$` trước tên lớp.
  Mixin này sẽ định nghĩa các thuộc tính và phương thức của đối tượng.

- Khi định nghĩa constructor cho lớp Freezed, cần sử dụng từ khóa `factory` (từ khóa `const` là tùy chọn).
  Các tham số constructor sẽ là danh sách tất cả các thuộc tính trong lớp.
  Tham số không nhất thiết phải là **tên** và có thể sử dụng tham số tùy chọn với chỉ định vị trí nếu cần.

### Định nghĩa lớp có thể thay đổi thay vì lớp bất biến

Cho đến nay, chúng ta đã thấy cách định nghĩa mô hình với tất cả các thuộc tính là `final`.
Tuy nhiên, đôi khi bạn cũng có thể muốn định nghĩa các thuộc tính có thể thay đổi trong mô hình.

Freezed hỗ trợ điều này bằng cách thay thế annotation `@freezed` bằng `@unfreezed`.

```dart
@unfreezed
class Person with _$Person {
  factory Person({
    required String firstName,
    required String lastName,
    required final int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);
}
```

Đoạn mã này định nghĩa mô hình gần như giống với trước, nhưng có những điểm khác:

- `firstName` và `lastName` đã trở thành các thuộc tính có thể thay đổi. Vì vậy, bạn có thể viết như sau:

  ```dart
  void main() {
    var person = Person(firstName: 'John', lastName: 'Smith', age: 42);

    person.firstName = 'Mona';
    person.lastName = 'Lisa';
  }
  ```

- `age` vẫn là bất biến vì thuộc tính này được khai báo là `final`.
- `Person` không còn triển khai `==` và `hashCode`.

  ```dart
  void main() {
    var john = Person(firstName: 'John', lastName: 'Smith', age: 42);
    var john2 = Person(firstName: 'John', lastName: 'Smith', age: 42);

    print(john == john2); // false
  }
  ```

- Dĩ nhiên, vì `Person` là lớp có thể thay đổi, bạn không thể sử dụng `const` để khởi tạo đối tượng.

### Cho phép thay đổi Lists/Maps/Sets

Mặc định, khi sử dụng `@freezed` (trừ `@unfreezed`), các thuộc tính kiểu `List`/`Map`/`Set` được coi là bất biến.

Do đó, khi thực thi đoạn mã sau, sẽ xảy ra ngoại lệ tại thời điểm chạy.

```dart
@freezed
class Example with _$Example {
  factory Example(List<int> list) = _Example;
}

void main() {
  var example = Example([]);
  example.list.add(42); // Sẽ xảy ra ngoại lệ vì đang cố gắng thay đổi collection
}
```

Hành vi này có thể bị vô hiệu hóa bằng cách viết như sau.

```dart
@Freezed(makeCollectionsUnmodifiable: false)
class Example with _$Example {
  factory Example(List<int> list) = _Example;
}

void main() {
  var example = Example([]);
  example.list.add(42); // OK
}
```

### Cơ chế của `copyWith`

Như đã đề cập trước đó, khi định nghĩa mô hình bằng Freezed, trình tạo mã tự động tạo ra phương thức `copyWith`.
Phương thức này được sử dụng để sao chép đối tượng với các giá trị khác.

Ví dụ, giả sử chúng ta định nghĩa một lớp như sau.

```dart
@freezed
class Person with _$Person {
  factory Person(String name, int? age) = _Person;
}
```

Khi đó, bạn có thể viết như sau.

```dart
void main() {
  var person = Person('Remi', 24);

  // Vì giá trị `age` không được truyền vào, nên giá trị của `age` không thay đổi
  print(person.copyWith(name: 'Dash')); // Person(name: Dash, age: 24)
  // `age` được đặt thành `null`
  print(person.copyWith(age: null)); // Person(name: Remi, age: null)
}
```

Lưu ý rằng Freezed hỗ trợ `person.copyWith(age: null)`.

### Phát triển: Deep copy

Mặc dù `copyWith` rất mạnh mẽ, nhưng khi xử lý các đối tượng phức tạp, nó có thể trở nên bất tiện.

Hãy xem xét một lớp như sau.

```dart
@freezed
class Company with _$Company {
  factory Company({String? name, required Director director}) = _Company;
}

@freezed
class Director with _$Director {
  factory Director({String? name, Assistant? assistant}) = _Director;
}

@freezed
class Assistant with _$Assistant {
  factory Assistant({String? name, int? age}) = _Assistant;
}
```

Giả sử bạn muốn thay đổi `Assistant` từ tham chiếu của `Company`.
Ví dụ, để thay đổi `name` của `Assistant`, bạn sẽ cần sử dụng `copyWith` như sau.

```dart
Company company;

Company newCompany = company.copyWith(
  director: company.director.copyWith(
    assistant: company.director.assistant.copyWith(
      name: 'John Smith',
    ),
  ),
);
```

Điều này _hoạt động_ nhưng có quá nhiều sự lặp lại và trở nên rườm rà.
Ở đây, bạn có thể sử dụng "deep copy" của [Freezed].

Khi mô hình Freezed chứa mô hình Freezed khác như một thuộc tính, trình tạo mã sẽ cung cấp cú pháp thay thế như sau cho ví dụ trên.

```dart
Company company;

Company newCompany = company.copyWith.director.assistant(name: 'John Smith');
```

Đoạn mã này tạo ra kết quả giống như đoạn mã trên (tạo một công ty mới với tên `John Smith` của trợ lý) nhưng không có sự lặp lại.

Nếu muốn thay đổi tên của giám đốc, bạn có thể viết như sau.

```dart
Company company;
Company newCompany = company.copyWith.director(name: 'John Doe');
```

Tổng thể, dựa trên định nghĩa của `Company`/`Director`/`Assistant` ở trên, tất cả các cú pháp "copy" sau sẽ hoạt động.

```dart
Company company;

company = company.copyWith(name: 'Google', director: Director(...));
company = company.copyWith.director(name: 'Larry', assistant: Assistant(...));
```

**Xử lý Null**

Một số đối tượng có thể có giá trị là `null`. Ví dụ, khi sử dụng lớp `Company`, thuộc tính `assistant` của `Director` có thể là `null`.

Vì vậy, việc viết như sau là vô nghĩa.

```dart
Company company = Company(name: 'Google', director: Director(assistant: null));
Company newCompany = company.copyWith.director.assistant(name: 'John');
```

Bạn không thể thay đổi tên của trợ lý khi trợ lý không tồn tại.

Trong trường hợp này, `company.copyWith.director.assistant` sẽ trả về `null` và mã sẽ không biên dịch.

Để sửa lỗi này, bạn có thể sử dụng toán tử `?.call` như sau.

```dart
Company? newCompany = company.copyWith.director.assistant?.call(name: 'John');
```

### Thêm getter và method vào models

Trong một số trường hợp, bạn có thể muốn định nghĩa phương thức hoặc thuộc tính thủ công trong lớp.
Tuy nhiên, nếu viết như sau, bạn sẽ ngay lập tức gặp lỗi.

```dart
@freezed
class Person with _$Person {
  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

Trong trường hợp này, bạn sẽ gặp lỗi `The non-abstract class _$_Person is missing implementations for these members:`.

Để làm cho nó hoạt động, bạn cần định nghĩa một constructor riêng tư rỗng. Điều này sẽ cho phép mã được tạo ra *kế thừa hoặc tạo lớp con* thay vì *triển khai* (mặc định chỉ kế thừa kiểu mà không kế thừa thuộc tính và phương thức).

```dart
@freezed
class Person with _$Person {
  // Thêm constructor. Không được có tham số.
  const Person._();

  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

### Assert

Trong Dart, bạn không thể thêm `assert(...)` vào constructor `factory`.
Vì vậy, để thêm assert vào lớp Freezed, bạn cần sử dụng decorator `@Assert`.

```dart
class Person with _$Person {
  @Assert('name.isNotEmpty', 'name cannot be empty')
  @Assert('age >= 0')
  factory Person({
    String? name,
    int? age,
  }) = _Person;
}
```

### Giá trị mặc định

Giống như assert, Dart không cho phép bạn chỉ định giá trị mặc định cho "redirecting factory constructors".

Vì vậy, để chỉ định giá trị mặc định cho thuộc tính, bạn cần sử dụng annotation `@Default` như sau.

```dart
class Example with _$Example {
  const factory Example([@Default(42) int value]) = _Example;
}
```

**Lưu ý**:\
Nếu bạn sử dụng serialize hoặc deserialize, `@JsonKey(defaultValue: <something>)` sẽ được thêm tự động.

### Decoder và Comment

[Freezed] hỗ trợ comment và decorate từng tham số hoặc định nghĩa constructor, hỗ trợ comment decorator/ document cho thuộc tính và lớp.

Hãy xem ví dụ dưới đây.

```dart
@freezed
class Person with _$Person {
  const factory Person({
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

Nếu bạn muốn thêm comment cho thuộc tính `name`, bạn có thể viết như sau.

```dart
@freezed
class Person with _$Person {
  const factory Person({
    /// Tên người dùng
    ///
    /// Không được null
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

Nếu bạn muốn gắn `@deprecated` cho thuộc tính `gender`, bạn có thể viết như sau.

```dart
@freezed
class Person with _$Person {
  const factory Person({
    String? name,
    int? age,
    @deprecated Gender? gender,
  }) = _Person;
}
```

Điều này sẽ làm cho tất cả những điều sau đây trở thành deprecated.

- Constructor:
  ```dart
  Person(gender: Gender.something); // gender is deprecated
  ```
- Constructor của lớp đã tạo:
  ```dart
  _Person(gender: Gender.something); // gender is deprecated
  ```
- Thuộc tính:
  ```dart
  Person person;
  print(person.gender); // gender is deprecated
  ```
- Tham số của `copyWith`:
  ```dart
  Person person;
  person.copyWith(gender: Gender.something); // gender is deprecated
  ```

Tương tự, nếu bạn muốn decorate lớp đã tạo, bạn có thể decorate factory constructor được định nghĩa.

Do đó, để đánh dấu `_Person` là không còn được sử dụng, bạn có thể viết như sau:

```dart
@freezed
class Person with _$Person {
  @deprecated
  const factory Person({
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

### Sử dụng Mixin và Interface để tạo kiểu tổng hợp cho từng lớp

Khi một lớp có nhiều kiểu dữ liệu, bạn có thể muốn áp dụng một interface cho một kiểu trong số đó, hoặc thêm mixin cho lớp. Để làm điều này, bạn cần sử dụng các decorator `@Implements` hoặc `@With`. Trong ví dụ sau, `City` triển khai `GeographicArea`.

```dart
abstract class GeographicArea {
  int get population;
  String get name;
}

@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;

  @Implements<GeographicArea>()
  const factory Example.city(String name, int population) = City;
}
```

Điều này cũng áp dụng tương tự khi triển khai hoặc thêm mixin cho các lớp tổng quát (ví dụ: `AdministrativeArea<House>`). Tuy nhiên, nếu lớp có tham số kiểu tổng quát (ví dụ: `AdministrativeArea<T>`), Freezed sẽ tạo mã đúng, nhưng Dart sẽ gặp lỗi khi biên dịch do lỗi tải các khai báo annotation. Để tránh điều này, bạn cần sử dụng `@Implements.fromString` và `@With.fromString` như sau:

```dart
abstract class GeographicArea {}
abstract class House {}
abstract class Shop {}
abstract class AdministrativeArea<T> {}

@freezed
sealed class Example<T> with _$Example<T> {
  const factory Example.person(String name, int age) = Person<T>;

  @With.fromString('AdministrativeArea<T>')
  const factory Example.street(String name) = Street<T>;

  @With<House>()
  @Implements<Shop>()
  @Implements<GeographicArea>()
  @Implements.fromString('AdministrativeArea<T>')
  const factory Example.city(String name, int population) = City<T>;
}
```

**Lưu ý 1**: Hãy triển khai tất cả các thành viên trừu tượng theo yêu cầu của interface. Nếu interface không có thành viên hay chỉ có các trường, bạn có thể thêm chúng vào các constructor kiểu union để đáp ứng hợp đồng của interface. Nếu interface có các phương thức hoặc getter mà bạn cần triển khai trong lớp, vui lòng tham khảo phần [Thêm getters và phương thức vào mô hình của chúng ta](#adding-getters-and-methods-to-our-models).

**Lưu ý 2**: Không thể sử dụng `@With` và `@Implements` trong các lớp Freezed. Lý do là lớp Freezed không thể được mở rộng hoặc triển khai.

## FromJson và ToJson

[Freezed] không tự động sinh ra `fromJson` và `toJson`, nhưng nó tương thích với [json_serializable].

Việc tạo ra lớp tương thích với [json_serializable] rất đơn giản.

Hãy xem đoạn mã sau:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

Để làm lớp tương thích với [json_serializable], bạn cần thực hiện 2 thay đổi sau:

- Thêm một `part` mới: `part 'model.g.dart';`
- Thêm constructor mới cho lớp mục tiêu: `factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);`

Mã sau khi thay đổi sẽ như sau:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
}
```

Đừng quên thêm `json_serializable` vào `pubspec.yaml` của bạn:

```yaml
dev_dependencies:
  json_serializable:
```

Vậy là xong! Những thay đổi này sẽ khiến [Freezed] tự động gọi [json_serializable] và sinh ra mã `fromJson` và `toJson` cần thiết.

**Lưu ý**:
Freezed chỉ sinh ra `fromJson` khi factory sử dụng `=>`.

### fromJSON - Các lớp có nhiều constructor

Đối với các lớp có nhiều constructor, [Freezed] sẽ kiểm tra phần tử `runtimeType` trong phản hồi JSON và chọn constructor sẽ sử dụng dựa trên giá trị của nó. Ví dụ, khi có các constructor như sau:

```dart
@freezed
sealed class MyResponse with _$MyResponse {
  const factory MyResponse(String a) = MyResponseData;
  const factory MyResponse.special(String a, int b) = MyResponseSpecial;
  const factory MyResponse.error(String message) = MyResponseError;

  factory MyResponse.fromJson(Map<String, dynamic> json) => _$MyResponseFromJson(json);
}
```

Khi đó, [Freezed] sẽ sử dụng `runtimeType` của từng đối tượng JSON để chọn constructor, ví dụ như sau:

```json
[
  {
    "runtimeType": "default",
    "a": "This JSON object will use constructor MyResponse()"
  },
  {
    "runtimeType": "special",
    "a": "This JSON object will use constructor MyResponse.special()",
    "b": 42
  },
  {
    "runtimeType": "error",
    "message": "This JSON object will use constructor MyResponse.error()"
  }
]
```

Khi sử dụng `@Freezed` và `@FreezedUnionValue`, bạn có thể tùy chỉnh khóa và giá trị theo cách khác.

```dart
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
sealed class MyResponse with _$MyResponse {
  const factory MyResponse(String a) = MyResponseData;

  @FreezedUnionValue('SpecialCase')
  const factory MyResponse.special(String a, int b) = MyResponseSpecial;

  const factory MyResponse.error(String message) = MyResponseError;

// ...
}
```

Với sự thay đổi này, JSON trước đó sẽ được cập nhật như sau:

```json
[
  {
    "type": "Default",
    "a": "This JSON object will use constructor MyResponse()"
  },
  {
    "type": "SpecialCase",
    "a": "This JSON object will use constructor MyResponse.special()",
    "b": 42
  },
  {
    "type": "Error",
    "message": "This JSON object will use constructor MyResponse.error()"
  }
]
```

Nếu bạn muốn tùy chỉnh khóa và giá trị của tất cả các lớp, bạn có thể chỉ định điều này trong tệp `build.yaml`, ví dụ như sau.

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          union_key: type
          union_value_case: pascal
```

Nếu bạn không thể kiểm soát phản hồi JSON, bạn cũng có thể triển khai bộ chuyển đổi tùy chỉnh. Bộ chuyển đổi tùy chỉnh cần phải triển khai logic riêng để quyết định constructor nào sẽ được sử dụng.

```dart
class MyResponseConverter implements JsonConverter<MyResponse, Map<String, dynamic>> {
  const MyResponseConverter();

  @override
  MyResponse fromJson(Map<String, dynamic> json) {
    // Nếu dữ liệu type đã được thiết lập (ví dụ: khi chúng ta tự serialize)
    if (json['runtimeType'] != null) {
      return MyResponse.fromJson(json);
    }
    // Cần kiểm tra điều kiện để xác định loại dữ liệu (ví dụ: kiểm tra sự tồn tại của trường trong json)
    if (isTypeData) {
      return MyResponseData.fromJson(json);
    } else if (isTypeSpecial) {
      return MyResponseSpecial.fromJson(json);
    } else if (isTypeError) {
      return MyResponseError.fromJson(json);
    } else {
      throw Exception('Could not determine the constructor for mapping from JSON');
    }
  }

  @override
  Map<String, dynamic> toJson(MyResponse data) => data.toJson();
}
```

Tiếp theo, để áp dụng bộ chuyển đổi tùy chỉnh này, bạn chỉ cần truyền decorator vào tham số constructor.

```dart
@freezed
class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() MyResponse myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

Điều này sẽ khiến `json serializable` sử dụng `MyResponseConverter.fromJson()` và `MyResponseConverter.toJson()` để chuyển đổi `MyResponse`.

Bạn cũng có thể sử dụng bộ chuyển đổi tùy chỉnh cho các tham số constructor trong `List`.

```dart
@freezed
class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() List<MyResponse> myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

**Lưu ý**
Để serialize các danh sách lồng nhau của đối tượng Freezed, bạn cần chỉ định `@JsonSerializable(explicitToJson: true)` hoặc thay đổi `explicit_to_json` trong tệp `build.yaml` của bạn ([xem tài liệu](https://github.com/google/json_serializable.dart/tree/master/json_serializable#build-configuration)).

### Deserialize lớp Generic

Để deserialize hoặc serialize đối tượng Freezed với kiểu generic, bạn cần kích hoạt `genericArgumentFactories`. Điều cần làm là thay đổi chữ ký của phương thức `fromJson` và thêm `genericArgumentFactories: true` vào cấu hình Freezed.

```dart
@Freezed(genericArgumentFactories: true)
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.data(T data) = ApiResponseData;
  const factory ApiResponse.error(String message) = ApiResponseError;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$ApiResponseFromJson(json, fromJsonT);
}
```

Ngoài ra, bạn cũng có thể thay đổi tệp `build.yaml` để kích hoạt `genericArgumentFactories` cho toàn bộ dự án.

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          generic_argument_factories: true
```

**Cách sử dụng `@JsonKey`?**

Tất cả các decorator được truyền vào tham số constructor sẽ được "copy & paste" vào các thuộc tính được tạo ra. Vì vậy, bạn có thể viết như sau.

```dart
@freezed
class Example with _$Example {
  factory Example(@JsonKey(name: 'my_property') String myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

**Cách sử dụng `@JsonSerializable`?**

Bạn có thể áp dụng `@JsonSerializable` bằng cách đặt annotation trên constructor. Dưới đây là ví dụ.

```dart
@freezed
class Example with _$Example {
  @JsonSerializable(explicitToJson: true)
  factory Example(@JsonKey(name: 'my_property') SomeOtherClass myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

Nếu bạn muốn định nghĩa cờ `json_serializable` tùy chỉnh cho tất cả các lớp (ví dụ `explicit_to_json` hoặc `any_map`), bạn có thể cấu hình trong tệp `build.yaml`. Chi tiết xem [ở đây](https://pub.dev/packages/json_serializable#build-configuration).

Ngoài ra, hãy tham khảo thêm phần [decorators](#decorators-and-comments).

## Kiểu Union

Khi chuyển từ các ngôn ngữ khác sang Dart, bạn có thể đã quen với các tính năng như "union types", "sealed classes", "pattern matching"...

Những tính năng này kết hợp với hệ thống kiểu có thể là những công cụ mạnh mẽ, nhưng chúng không được hỗ trợ trong Dart 2. Dart 3 đã hỗ trợ, nhưng nó không phải là dễ sử dụng.

Tuy nhiên, đừng lo lắng. [Freezed] hỗ trợ những tính năng này và sẽ tạo ra một số tiện ích hữu ích cho bạn!

Nói một cách đơn giản, trong lớp Freezed, bạn có thể viết nhiều constructor như sau:

```dart
@freezed
sealed class Union with _$Union {
  const factory Union.data(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = Error;
}
```

> [!Note]
> Ví dụ này sử dụng từ khóa `sealed` được giới thiệu trong Dart 3. Nếu bạn đang sử dụng Dart 3, hãy chắc chắn sử dụng từ khóa sealed khi định nghĩa Union trong Freezed. Nếu bạn đang sử dụng Dart 2, có thể bỏ qua điều này, nhưng khuyến khích nâng cấp lên Dart 3 để sử dụng tính năng kiểm tra mẫu.

Điều này cho phép mô hình của chúng ta có thể có các trạng thái khác nhau, loại trừ lẫn nhau.

Cụ thể, trong đoạn mã này, mô hình `Union` được định nghĩa với ba trạng thái sau:

- data
- loading
- error

Điều đáng chú ý là, các constructor đều có tên ý nghĩa ở bên phải, điều này sẽ hữu ích sau này.

Bạn cũng có thể nhận thấy rằng bạn không thể viết mã như sau:

```dart
void main() {
  Union union = Union.data(42);

  print(union.value); // Lỗi biên dịch: Không tồn tại thuộc tính value
}
```

Lý do sẽ được giải thích trong phần tiếp theo.

### Thuộc tính chia sẻ

Khi định nghĩa nhiều constructor, bạn sẽ không thể đọc các thuộc tính không chung giữa tất cả các constructor.

Ví dụ, nếu bạn viết như sau:

```dart
@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

Lúc này, bạn không thể trực tiếp đọc các thuộc tính `age` và `population`.

```dart
var example = Example.person('Remi', 24);
print(example.age); // Lỗi biên dịch!
```

Ngược lại, các thuộc tính chung giữa tất cả các constructor vẫn có thể đọc được. Ví dụ, `name` là thuộc tính chung giữa cả `Example.person` và `Example.city`.

Do đó, bạn có thể viết như sau:

```dart
var example = Example.person('Remi', 24);
print(example.name); // Remi
example = Example.city('London', 8900000);
print(example.name); // London
```

Bạn cũng có thể áp dụng logic tương tự vào `copyWith`. Đối với các thuộc tính chung giữa tất cả các constructor, bạn có thể sử dụng `copyWith` như sau:

```dart
var example = Example.person('Remi', 24);
print(example.copyWith(name: 'Dash')); // Example.person(name: Dash, age: 24)

example = Example.city('London', 8900000);
print(example.copyWith(name: 'Paris')); // Example.city(name: Paris, population: 8900000)
```

Ngược lại, đối với các thuộc tính riêng biệt của từng constructor, bạn không thể sử dụng `copyWith`:

```dart
var example = Example.person('Remi', 24);

example.copyWith(age: 42); // Lỗi biên dịch, tham số `age` không tồn tại
```

Để giải quyết vấn đề này, bạn cần sử dụng một phương pháp gọi là "kiểm tra mẫu" để kiểm tra trạng thái của đối tượng.

### Cách sử dụng pattern matching để đọc các thuộc tính không chia sẻ

Trong phần này, hãy xem xét một kiểu liên hiệp với ví dụ sau:

```dart
@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

Giờ chúng ta sẽ sử dụng kiểm tra mẫu để đọc các thuộc tính của đối tượng `Example`.

Bằng cách sử dụng kiểm tra mẫu tích hợp với từ khóa `switch` trong Dart 3, bạn có thể viết như sau:

```dart
switch (example) {
Person(:final name) => print('Person $name'),
City(:final population) => print('City ($population)'),
}
```

Nếu bạn đang sử dụng Dart 2, bạn có thể sử dụng các tiện ích kiểm tra mẫu cũ được tạo ra bởi Freezed để kiểm tra nội dung của đối tượng.

Ngoài ra, bạn có thể sử dụng `is` hoặc `as` để ép kiểu `Example` thành `Person` hoặc `City`, nhưng điều này không được khuyến khích. Hãy sử dụng một trong hai phương pháp còn lại.

#### (Legacy) Utility pattern matching

> [!WARNING]
> Từ Dart 3, Dart đã có hỗ trợ khớp mẫu (pattern matching) tích hợp sẵn bằng cách sử dụng các lớp sealed.
> Vì vậy, bạn không còn cần phải dựa vào các phương thức do Freezed tạo ra để thực hiện khớp mẫu.
> Thay vì sử dụng `when`/`map`, hãy sử dụng cú pháp chính thức của Dart.
>
> Các tham chiếu đến `when`/`map` được giữ lại cho những người dùng chưa nâng cấp lên Dart 3.
> Nhưng về lâu dài, bạn nên ngừng dựa vào chúng và chuyển sang sử dụng biểu thức `switch`.

##### When

Phương thức [when] tương đương với việc sử dụng pattern matching với destructuring.
Prototype của phương thức này thay đổi tùy theo constructor được định nghĩa.

Hãy xem xét ví dụ sau:

```dart
@freezed
sealed class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = ErrorDetails;
}
```

Lúc này, bạn có thể sử dụng [when] như sau:

```dart
var union = Union(42);

print(
union.when(
(int value) => 'Data $value',
loading: () => 'loading',
error: (String? message) => 'Error: $message',
),
); // Data 42
```

Lúc này, [when] sẽ như sau:

```dart
@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

Lúc này, [when] sẽ như sau:

```dart
var model = Model.first('42');

print(
model.when(
first: (String a) => 'first $a',
second: (int b, bool c) => 'second $b $c'
),
); // first 42
```

Lưu ý rằng mỗi callback phải khớp với tên constructor và prototype của nó.

##### Map

Phương thức [map] có chức năng tương tự như [when], nhưng **không thực hiện destructuring**.

Hãy xem xét lớp sau:

```dart
@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

Trong trường hợp này, [when] hoạt động như sau:

```dart
var model = Model.first('42');

print(
model.when(
first: (String a) => 'first $a',
second: (int b, bool c) => 'second $b $c'
),
); // first 42
```

Trong khi đó, [map] sẽ hoạt động như sau:

```dart
var model = Model.first('42');

print(
model.map(
first: (First value) => 'first ${value.a}',
second: (Second value) => 'second ${value.b} ${value.c}'
),
); // first 42
```

Phương thức này rất hữu ích khi bạn muốn thực hiện các thao tác phức tạp như [copyWith] hoặc `toString`.

```dart
var model = Model.second(42, false)
print(
model.map(
first: (value) => value,
second: (value) => value.copyWith(c: true),
)
); // Model.second(b: 42, c: true)
```

## Cấu hình

Freezed cung cấp nhiều tùy chọn để tùy chỉnh mã được tạo ra.
Ví dụ, nếu bạn muốn vô hiệu hóa việc tạo phương thức `when`.

Có hai cách để thực hiện điều này:

### Thay đổi hành vi cho một mô hình cụ thể

Nếu bạn muốn tùy chỉnh mã được tạo ra cho một lớp cụ thể, bạn có thể sử dụng một annotation khác.

```dart
@Freezed()
class Person with _$Person {
  factory Person(String name, int age) = _Person;
}
```

Bằng cách truyền các tham số khác nhau vào `@Freezed`, bạn có thể thay đổi nội dung của mã được tạo ra.

```dart
@Freezed(
  // Vô hiệu hóa việc tạo `copyWith` và `==`
  copyWith: false,
  equal: false,
)
class Person with _$Person {...}
```

Để biết thêm chi tiết về các tùy chọn có sẵn, bạn có thể tham khảo tài liệu `@Freezed` tại đây:
<https://pub.dev/documentation/freezed_annotation/latest/freezed_annotation/Freezed-class.html>

### Thay đổi hành vi cho toàn bộ dự án

Thay vì áp dụng thay đổi cho một lớp cụ thể, bạn cũng có thể áp dụng thay đổi cho tất cả các mô hình Freezed trong dự án.

Trong trường hợp này, bạn sẽ tùy chỉnh tệp `build.yaml`.
Đây là một tệp cấu hình tùy chọn, đặt bên cạnh tệp `pubspec.yaml`:

```
my_project_folder/
  pubspec.yaml
  build.yaml
  lib/
```

Ở đây, bạn có thể thiết lập các tùy chọn tương tự như những gì bạn truyền vào `@Freezed` (xem trên).
Ví dụ như sau:

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          # Vô hiệu hóa định dạng tệp .freezed.dart.
          # Điều này có thể giúp tăng tốc quá trình tạo mã.
          format: false
          # Vô hiệu hóa việc tạo `copyWith` và `==` cho toàn bộ dự án.
          copy_with: false
          equal: false
          # Cấu hình `true` hoặc `false` để bật hoặc tắt việc tạo phương thức `when` và `map`.
          map: false
          # Có thể bật hoặc tắt việc tạo các biến thể của `when` và `map`.
          when:
            when: true
            maybe_when: true
            when_or_null: false
```

# Tiện ích

## Extension IDE

### Extension Freezed cho VSCode

Extension [Freezed](https://marketplace.visualstudio.com/items?itemName=blaxou.freezed) sẽ giúp cải thiện hiệu quả công việc khi sử dụng Freezed. Ví dụ, có những tính năng sau:

- Sử dụng <kbd>Ctrl+Shift+B</kbd> (trên Mac là <kbd>Cmd+Shift+B</kbd>) để nhanh chóng xây dựng bằng `build_runner`.
- Sử dụng <kbd>Ctrl+Shift+P</kbd> (trên Mac là <kbd>Cmd+Shift+P</kbd>) để chọn `Generate Freezed class` và nhanh chóng tạo lớp Freezed.

### Extension Freezed cho IntelliJ và Android Studio

Bạn có thể tải Live Templates cho mã khởi tạo boiler plate [tại đây](https://github.com/Tinhorn/freezed_intellij_live_templates).
IntelliJ và Android Studio cung cấp các Live Templates cho mã khởi tạo, có thể tải về từ [đây](https://github.com/Tinhorn/freezed_intellij_live_templates).

Ví dụ:

- Gõ **freezedClass** và nhấn <kbd>Tab</kbd> để tạo lớp Freezed.
  ```dart
  @freezed
  class Demo with _$Demo {
  }
  ```
- Gõ **freezedFromJson** và nhấn <kbd>Tab</kbd> để tạo phương thức `fromJson` cho `json_serializable`.
  ```dart
  factory Demo.fromJson(Map<String, dynamic> json) => _$DemoFromJson(json);
  ```

## Công cụ của bên thứ ba

Dưới đây là các công cụ cộng đồng hỗ trợ Freezed.

### DartJ

[DartJ](https://dartj.web.app/#/) là một ứng dụng Flutter do [**@ttpho**](https://github.com/ttpho) tạo ra, giúp tạo các lớp Freezed từ payload JSON.

Ví dụ:

<https://github.com/ttpho/ttpho/assets/3994863/5d529258-c02c-4066-925e-ca2ffc68a804>

## Nhà tài trợ

<p align="center">
  <a href="https://raw.githubusercontent.com/rrousselGit/freezed/master/sponsorkit/sponsors.svg">
    <img src='https://raw.githubusercontent.com/rrousselGit/freezed/master/sponsorkit/sponsors.svg'/>
  </a>
</p>

[build_runner]: https://pub.dev/packages/build_runner
[freezed]: https://pub.dartlang.org/packages/freezed
[freezed_annotation]: https://pub.dartlang.org/packages/freezed_annotation
[copywith]: #how-copywith-works
[when]: #when
[map]: #map
[json_serializable]: https://pub.dev/packages/json_serializable
