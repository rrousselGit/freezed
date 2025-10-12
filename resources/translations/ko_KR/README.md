[English](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/README.md) | [한국어](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ko_KR/README.md) | [简体中文](https://github.com/rrousselGit/freezed/blob/master/resources/translations/zh_CN/README.md) | [日本語](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ja_JP/README.md) | [Tiếng Việt](https://github.com/rrousselGit/freezed/blob/master/resources/translations/vi_VN/README.md)

![Build](https://github.com/rrousselGit/freezed/workflows/Build/badge.svg)
[![pub package](https://img.shields.io/pub/v/freezed.svg)](https://pub.dartlang.org/packages/freezed)
<a href="https://discord.gg/GSt793j6eT"><img src="https://img.shields.io/discord/765557403865186374.svg?logo=discord&color=blue" alt="Discord"></a>

[<img src="https://raw.githubusercontent.com/rrousselGit/provider/master/resources/flutter_favorite.png" width="200" />](https://flutter.dev/docs/development/packages-and-plugins/favorites)

[Freezed]에 오신 것을 환영합니다. 이 라이브러리는 데이터 클래스, 태그드 유니온(tagged unions), 중첩 클래스, 그리고 객체 복제(cloning)를 위한 또 하나의 코드 생성기입니다.

# 3.0.0으로 마이그레이션

2.0.0에서 3.0.0으로 마이그레이션하려면 [변경 로그](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/CHANGELOG.md#300---2025-02-25)와 [마이그레이션 가이드](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/migration_guide.md)를 참조하세요.

# 동기

Dart는 훌륭한 언어지만, '모델'을 정의하는 것은 지루한 작업이 될 수 있습니다. 다음과 같은 작업들이 필요합니다:

- 생성자(constructor)와 프로퍼티(properties) 정의
- `toString`, `operator ==`, `hashCode` 오버라이드
- 객체 복제를 위한 `copyWith` 메서드 구현
- 직렬화/역직렬화(de/serialization) 처리

이 모든 것을 구현하는 데에는 수백 줄의 코드가 필요할 수 있으며, 이는 오류가 발생하기 쉽고 모델의 가독성을 크게 해칩니다.

Freezed는 이 대부분의 작업을 대신 구현하여, 개발자가 모델의 정의에만 집중할 수 있도록 돕습니다.

| 이전                                                                                                    | 이후                                                                                         |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| ![before](https://raw.githubusercontent.com/rrousselGit/freezed/refs/heads/master/resources/before.png) | ![before](https://raw.githubusercontent.com/rrousselGit/freezed/master/resources/after.png) |

# 목차

- [3.0.0으로 마이그레이션](#300으로-마이그레이션)
- [동기](#동기)
- [목차](#목차)
- [사용 방법](#사용-방법)
  - [설치](#설치)
    - [invalid_annotation_target 경고 및 생성된 파일의 경고 비활성화](#invalid_annotation_target-경고-및-생성된-파일의-경고-비활성화)
  - [생성기 실행](#생성기-실행)
  - [Freezed를 사용하여 모델 만들기](#freezed를-사용하여-모델-만들기)
    - [기본 생성자](#기본-생성자)
      - [모델에 getter와 메서드 추가하기](#모델에-getter와-메서드-추가하기)
      - [Asserts](#asserts)
      - [기본값](#기본값)
      - [상수가 아닌 기본값](#상수가-아닌-기본값)
      - [클래스 확장하기](#클래스-확장하기)
      - [불변 클래스 대신 가변 클래스 정의하기](#불변-클래스-대신-가변-클래스-정의하기)
      - [List/Map/Set의 변경 허용하기](#listmapset의-변경-허용하기)
    - [일반 클래스](#일반-클래스)
  - [copyWith 동작 방식](#copywith-동작-방식)
    - [더 나아가기: 깊은 복사(Deep copy)](#더-나아가기-깊은-복사deep-copy)
  - [데코레이터와 주석](#데코레이터와-주석)
  - [FromJson/ToJson](#fromjsontojson)
    - [fromJSON - 여러 생성자를 가진 클래스](#fromjson---여러-생성자를-가진-클래스)
    - [제네릭 클래스 역직렬화](#제네릭-클래스-역직렬화)
  - [유니온 타입](#유니온-타입)
    - [공유 프로퍼티](#공유-프로퍼티)
    - [패턴 매칭을 사용하여 공유되지 않는 프로퍼티 읽기](#패턴-매칭을-사용하여-공유되지-않는-프로퍼티-읽기)
    - [유니온 타입의 개별 클래스를 위한 Mixin과 Interface](#유니온-타입의-개별-클래스를-위한-mixin과-interface)
    - [개별 유니온 케이스 분리하기](#개별-유니온-케이스-분리하기)
      - [(레거시) 패턴 매칭 유틸리티](#레거시-패턴-매칭-유틸리티)
        - [When](#when)
        - [Map](#map)
  - [설정](#설정)
    - [특정 모델의 동작 변경하기](#특정-모델의-동작-변경하기)
    - [전체 프로젝트의 동작 변경하기](#전체-프로젝트의-동작-변경하기)
- [유틸리티](#유틸리티)
  - [IDE 확장 프로그램](#ide-확장-프로그램)
    - [VSCode용 Freezed 확장 프로그램](#vscode용-freezed-확장-프로그램)
    - [IntelliJ/Android Studio용 Freezed 확장 프로그램](#intellijandroid-studio용-freezed-확장-프로그램)
  - [린팅(Linting)](#린팅linting)
  - [서드파티 도구](#서드파티-도구)
    - [DartJ](#dartj)
  - [스폰서](#스폰서)

# 사용 방법

## 설치

[Freezed]를 사용하려면 일반적인 [build_runner]/코드 생성기 설정이 필요합니다.\
먼저, `pubspec.yaml` 파일에 [build_runner]와 [Freezed]를 추가하여 설치합니다:

Flutter 프로젝트의 경우:

```console
flutter pub add \
  dev:build_runner \
  freezed_annotation \
  dev:freezed
# freezed로 fromJson/toJson을 생성한다면 다음도 추가하세요:
flutter pub add json_annotation dev:json_serializable
```

Dart 프로젝트의 경우:

```console
dart pub add \
  dev:build_runner \
  freezed_annotation \
  dev:freezed
# freezed로 fromJson/toJson을 생성한다면 다음도 추가하세요:
dart pub add json_annotation dev:json_serializable
```

이 명령어는 세 개의 패키지를 설치합니다:

- [build_runner](https://pub.dev/packages/build_runner): 코드 생성기를 실행하는 도구
- [freezed]: 코드 생성기
- [freezed_annotation](https://pub.dev/packages/freezed_annotation): [freezed]를 위한 어노테이션이 포함된 패키지

### invalid_annotation_target 경고 및 생성된 파일의 경고 비활성화

[Freezed]를 `json_serializable`과 함께 사용할 계획이라면, 최신 버전의 `json_serializable`과 `meta` 패키지 때문에 `invalid_annotation_target` 경고를 비활성화해야 할 수 있습니다.

이를 위해, 프로젝트의 루트에 있는 `analysis_options.yaml` 파일에 다음을 추가할 수 있습니다:

```yaml
analyzer:
  errors:
    invalid_annotation_target: ignore
```

## 생성기 실행

코드 생성기를 실행하려면 다음 명령어를 실행하세요:

```
dart run build_runner watch -d
```

대부분의 코드 생성기와 마찬가지로, [Freezed]는 어노테이션([freezed_annotation])을 import하고 파일 상단에 `part` 키워드를 사용해야 합니다.

따라서 [Freezed]를 사용하려는 파일은 다음과 같이 시작합니다:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_file.freezed.dart';

```

**고려사항:** `package:flutter/foundation.dart`를 import하는 것을 고려해보세요.\
`foundation.dart`를 import하면 Flutter 개발 도구에서 객체를 보기 좋게 만들어주는 클래스들도 함께 import됩니다.\
`foundation.dart`를 import하면 [Freezed]가 자동으로 이 작업을 수행합니다.

## Freezed를 사용하여 모델 만들기

Freezed는 데이터 클래스를 만드는 두 가지 방법을 제공합니다:

- [기본 생성자(Primary constructors)](#기본-생성자): 생성자를 정의하면 Freezed가 연관된 필드를 생성합니다. 이는 `factory`를 사용하여 [Primary Constructor](https://github.com/dart-lang/language/issues/2364)를 시뮬레이션하는 것입니다.
- [일반 클래스(Classic classes)](#일반-클래스): 일반적인 Dart 클래스를 작성하면 Freezed가 `toString/==/copyWith`만 처리합니다.

### 기본 생성자

Freezed는 `factory` 생성자를 사용하여 기본 생성자를 구현합니다.\
아이디어는, `factory`를 정의하면 Freezed가 나머지 모든 것을 생성하는 것입니다:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

// 필수: 'main.dart'와 Freezed가 생성한 코드를 연결합니다.
part 'main.freezed.dart';
// 선택: Person 클래스는 직렬화 가능하므로 이 줄을 추가해야 합니다.
// 하지만 Person이 직렬화 가능하지 않다면 생략할 수 있습니다.
part 'main.g.dart';

@freezed
abstract class Person with _$Person {
  const factory Person({
    required String firstName,
    required String lastName,
    required int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json) => _$PersonFromJson(json);
}
```

위의 스니펫은 `Person`이라는 이름의 모델을 정의합니다:

- `Person`은 `firstName`, `lastName`, `age` 3개의 프로퍼티를 가집니다.
- `@freezed`를 사용했기 때문에, 이 클래스의 모든 프로퍼티는 불변(immutable)입니다.
- `fromJson`을 정의했으므로, 이 클래스는 직렬화/역직렬화가 가능합니다. Freezed는 `toJson` 메서드를 추가해 줄 것입니다.
- Freezed는 또한 다음을 자동으로 생성합니다:
  - 다른 프로퍼티 값으로 객체를 복제하기 위한 `copyWith` 메서드
  - 객체의 모든 프로퍼티를 나열하는 `toString` 오버라이드
  - `operator ==` 및 `hashCode` 오버라이드 (`Person`이 불변이므로)

이 예제에서 몇 가지를 알 수 있습니다:

- 모델에 `@freezed` (또는 `@Freezed`/`@unfreezed`, 나중에 자세히 설명) 어노테이션을 붙여야 합니다. 이 어노테이션은 Freezed에게 해당 클래스에 대한 코드를 생성하도록 지시합니다.

- 클래스 이름에 `_$` 접두사를 붙인 mixin을 적용해야 합니다. 이 mixin은 객체의 다양한 프로퍼티/메서드를 정의합니다.

- Freezed 클래스에서 생성자를 정의할 때는, 예시처럼 `factory` 키워드를 사용해야 합니다 (`const`는 선택 사항). 이 생성자의 파라미터는 이 클래스가 포함하는 모든 프로퍼티의 목록이 됩니다. 파라미터는 **반드시** named이고 required일 필요는 없습니다. 원한다면 positional optional 파라미터를 자유롭게 사용하세요!

#### 모델에 getter와 메서드 추가하기

때로는 클래스에 수동으로 메서드/프로퍼티를 정의하고 싶을 수 있습니다.\
하지만 기본 생성자를 사용하려고 하면 다음과 같은 문제가 발생합니다:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

그러면 `The non-abstract class _$_Person is missing implementations for these members:` 오류와 함께 실패할 것입니다.

이것이 작동하게 하려면, 비어있는 private 생성자를 정의해야 합니다. 이렇게 하면 생성된 코드가 클래스를 *구현(implementing)*하는 대신 *확장(extending/subclassing)*할 수 있게 됩니다 (기본 동작은 구현이며, 타입만 상속하고 프로퍼티나 메서드는 상속하지 않습니다):

```dart
@freezed
abstract class Person with _$Person {
  // 생성자 추가. 파라미터가 없어야 함.
  const Person._();

  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

#### Asserts

Dart는 `factory` 생성자에 `assert(...)` 문을 추가하는 것을 허용하지 않습니다.\
따라서 Freezed 클래스에 assert를 추가하려면 `@Assert` 데코레이터를 사용해야 합니다:

```dart
@freezed
abstract class Person with _$Person {
  @Assert('name.isNotEmpty', 'name cannot be empty')
  const factory Person({required String name, int? age}) = _Person;
}
```

또는 `MyClass._()` 생성자를 명시할 수도 있습니다:

```dart
@freezed
abstract class Person with _$Person {
  Person._({required this.name})
    : assert(name.isNotEmpty, 'name cannot be empty');

  factory Person({required String name, int? age}) = _Person;

  @override
  final String name;
}
```

#### 기본값

assert와 유사하게, Dart는 "리다이렉팅 팩토리 생성자(redirecting factory constructors)"가 기본값을 지정하는 것을 허용하지 않습니다.

따라서 프로퍼티에 기본값을 지정하려면 `@Default` 어노테이션을 사용해야 합니다:

```dart
@freezed
abstract class Example with _$Example {
  const factory Example([@Default(42) int value]) = _Example;
}
```

**참고**:\
직렬화/역직렬화를 사용하는 경우, 이것은 자동으로 `@JsonKey(defaultValue: <something>)`을 추가해 줍니다.

#### 상수가 아닌 기본값

`@Default` 사용만으로 충분하지 않다면, 두 가지 옵션이 있습니다:

- 기본 생성자 사용을 중단합니다. [일반 클래스](#일반-클래스)를 참조하세요.
- 해당 값을 초기화하기 위해 `MyClass._()` 생성자를 추가합니다.

후자는 하나의 기본값 때문에 많은 코드를 작성할 필요가 없으므로 큰 모델을 작성할 때 특히 유용합니다.

한 가지 예는 다음과 같습니다:

```dart
@freezed
sealed class Response<T> with _$Response<T> {
  // "time" 파라미터에 상수가 아닌 기본값을 부여합니다.
  Response._({DateTime? time}) : time = time ?? DateTime.now();
  // 생성자들은 ._()에 파라미터를 전달할 수 있게 할 수 있습니다.
  factory Response.data(T value, {DateTime? time}) = ResponseData;
  // ._ 파라미터가 named이고 optional이라면, factory 생성자는 이를 명시할 필요가 없습니다.
  factory Response.error(Object error) = ResponseError;

  @override
  final DateTime time;
}
```

이 예제에서 `time` 필드는 기본값으로 `DateTime.now()`를 가집니다.

#### 클래스 확장하기

Freezed 클래스가 다른 클래스를 확장(extend)하게 하고 싶을 수 있습니다.\
안타깝게도 `factory`는 `super(...)`를 명시하는 것을 허용하지 않습니다.

따라서 한 가지 해결책은, 상수가 아닌 기본값에 사용했던 것과 유사하게 `MyClass._()`를 다시 명시하는 것입니다. 예시는 다음과 같습니다:

```dart
class Subclass {
  const Subclass.name(this.value);

  final int value;
}

@freezed
abstract class MyFreezedClass extends Subclass with _$MyFreezedClass {
  // 이 생성자에서 파라미터를 받을 수 있고, `super.field`와 함께 사용할 수 있습니다.
  const MyFreezedClass._(super.value) : super.name();

  const factory MyFreezedClass(int value, /* 다른 필드들 */) = _MyFreezedClass;
}
```

이 구문은 상속을 완벽하게 제어할 수 있게 해줍니다.\
물론 `factory` 생성자를 사용하지 않고 일반 클래스를 작성할 수도 있습니다. [일반 클래스](#일반-클래스)를 참조하세요.

일반적으로 이 해결책은 여러 개의 `factory` 생성자가 있는 [유니온](#유니온-타입)에 더 적합합니다.

#### 불변 클래스 대신 가변 클래스 정의하기

지금까지 모든 프로퍼티가 `final`인 모델을 정의하는 방법을 보았습니다. 하지만 모델에 가변(mutable) 프로퍼티를 정의하고 싶을 수도 있습니다.

Freezed는 `@freezed` 어노테이션을 `@unfreezed`로 교체하여 이를 지원합니다:

```dart
@unfreezed
abstract class Person with _$Person {
  factory Person({
    required String firstName,
    required String lastName,
    required final int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json) => _$PersonFromJson(json);
}
```

이것은 이전 스니펫과 거의 동일한 모델을 정의하지만, 다음과 같은 차이점이 있습니다:

- `firstName`과 `lastName`은 이제 가변입니다. 따라서 다음과 같이 작성할 수 있습니다:

  ```dart
  void main() {
    var person = Person(firstName: 'John', lastName: 'Smith', age: 42);

    person.firstName = 'Mona';
    person.lastName = 'Lisa';
  }
  ```

- `age`는 프로퍼티를 명시적으로 `final`로 표시했기 때문에 여전히 불변입니다.
- `Person`은 더 이상 사용자 정의 ==/hashCode 구현을 가지지 않습니다:

  ```dart
  void main() {
    var john = Person(firstName: 'John', lastName: 'Smith', age: 42);
    var john2 = Person(firstName: 'John', lastName: 'Smith', age: 42);

    print(john == john2); // false
  }
  ```

- 물론, `Person` 클래스는 가변이므로 `const`를 사용하여 인스턴스화할 수 없습니다.

#### List/Map/Set의 변경 허용하기

기본적으로 `@freezed`를 사용할 때(`@unfreezed`는 아님), `List`/`Map`/`Set` 타입의 프로퍼티는 불변으로 변환됩니다.

이는 다음 코드를 작성하면 런타임 예외가 발생한다는 것을 의미합니다:

```dart
@freezed
abstract class Example with _$Example {
  factory Example(List<int> list) = _Example;
}

void main() {
  var example = Example([]);
  example.list.add(42); // 컬렉션을 변경하고 있으므로 예외 발생
}
```

이 동작은 다음과 같이 비활성화할 수 있습니다:

```dart
@Freezed(makeCollectionsUnmodifiable: false)
abstract class Example with _$Example {
  factory Example(List<int> list) = _Example;
}

void main() {
  var example = Example([]);
  example.list.add(42); // OK
}
```

### 일반 클래스

기본 생성자 대신 일반적인 Dart 클래스를 작성할 수 있습니다.

이 경우, 평소처럼 일반적인 생성자 + 필드 조합을 작성하면 됩니다:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

// 필수: 'main.dart'와 Freezed가 생성한 코드를 연결합니다.
part 'main.freezed.dart';
// 선택: Person 클래스는 직렬화 가능하므로 이 줄을 추가해야 합니다.
// 하지만 Person이 직렬화 가능하지 않다면 생략할 수 있습니다.
part 'main.g.dart';

@freezed
@JsonSerializable()
class Person with _$Person {
  const Person({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final int age;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);

  Map<String, Object?> toJson() => _$PersonToJson(this);
}
```

이 경우, Freezed는 `copyWith`/`toString`/`==`/`hashCode`를 생성하지만, JSON 인코딩과 관련된 작업은 하지 않습니다(따라서 수동으로 `@JsonSerializable`을 추가해야 합니다).

이 구문은 상속이나 상수가 아닌 기본값과 같은 고급 생성자 로직을 활성화하는 장점이 있습니다.

## copyWith 동작 방식

앞서 설명했듯이, Freezed를 사용하여 모델을 정의하면 코드 생성기가 자동으로 `copyWith` 메서드를 생성해 줍니다. 이 메서드는 다른 값으로 객체를 복제하는 데 사용됩니다.

예를 들어 다음과 같이 정의하면:

```dart
@freezed
abstract class Person with _$Person {
  factory Person(String name, int? age) = _Person;
}
```

다음과 같이 작성할 수 있습니다:

```dart
void main() {
  var person = Person('Remi', 24);

  // `age`가 전달되지 않았으므로, 그 값은 유지됩니다.
  print(person.copyWith(name: 'Dash')); // Person(name: Dash, age: 24)
  // `age`가 `null`로 설정됩니다.
  print(person.copyWith(age: null)); // Person(name: Remi, age: null)
}
```

Freezed는 `person.copyWith(age: null)`을 지원합니다.

### 더 나아가기: 깊은 복사(Deep copy)

`copyWith`는 그 자체로 매우 강력하지만, 더 복잡한 객체에서는 불편해집니다.

다음 클래스를 고려해 보세요:

```dart
@freezed
abstract class Company with _$Company {
  const factory Company({String? name, required Director director}) = _Company;
}

@freezed
abstract class Director with _$Director {
  const factory Director({String? name, Assistant? assistant}) = _Director;
}

@freezed
abstract class Assistant with _$Assistant {
  const factory Assistant({String? name, int? age}) = _Assistant;
}
```

`Company`에 대한 참조에서 `Assistant`를 변경하고 싶을 수 있습니다.\
예를 들어, assistant의 `name`을 변경하려면 `copyWith`를 사용하여 다음과 같이 작성해야 합니다:

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

이것은 *작동하지만*, 중복이 많아 상대적으로 장황합니다.\
이럴 때 [Freezed]의 "깊은 복사"를 사용할 수 있습니다.

Freezed 모델에 다른 Freezed 모델인 프로퍼티가 포함되어 있으면, 코드 생성기는 이전 예제에 대한 대체 구문을 제공합니다:

```dart
Company company;

Company newCompany = company.copyWith.director.assistant(name: 'John Smith');
```

이 스니펫은 이전 스니펫과 정확히 동일한 결과를 달성하지만(업데이트된 assistant 이름으로 새 회사 생성), 더 이상 중복이 없습니다.

이 구문을 더 깊이 파고들어, 대신 director의 이름을 변경하고 싶다면 다음과 같이 작성할 수 있습니다:

```dart
Company company;
Company newCompany = company.copyWith.director(name: 'John Doe');
```

전반적으로, 위에서 언급한 `Company`/`Director`/`Assistant`의 정의를 기반으로, 다음의 모든 "복사" 구문이 작동합니다:

```dart
Company company;

company = company.copyWith(name: 'Google', director: Director(...));
company = company.copyWith.director(name: 'Larry', assistant: Assistant(...));
```

**Null 고려사항**

일부 객체는 `null`일 수 있습니다. 예를 들어, `Company` 클래스에서 `Director`의 `assistant`는 `null`일 수 있습니다.

따라서 다음과 같이 작성하면:

```dart
Company company = Company(name: 'Google', director: Director(assistant: null));
Company newCompany = company.copyWith.director.assistant(name: 'John');
```

의미가 없습니다.\
애초에 assistant가 없으면 assistant의 이름을 변경할 수 없습니다.

이 상황에서 `company.copyWith.director.assistant`는 `null`을 반환하여 코드가 컴파일되지 않게 합니다.

이 문제를 해결하기 위해 `?.call` 연산자를 사용하여 다음과 같이 작성할 수 있습니다:

```dart
Company? newCompany = company.copyWith.director.assistant?.call(name: 'John');
```

## 데코레이터와 주석

[Freezed]는 각각의 파라미터와 생성자 정의를 데코레이팅/문서화하여 프로퍼티 및 클래스 수준의 데코레이터/문서화를 지원합니다.

다음을 고려해 보세요:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person({
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

`name`을 문서화하고 싶다면 다음과 같이 할 수 있습니다:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person({
    /// 사용자의 이름.
    ///
    /// null이 아니어야 함
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

`gender` 프로퍼티를 `@deprecated`로 표시하고 싶다면 다음과 같이 할 수 있습니다:

```dart
@freezed
abstract class Person with _$Person {
  const factory Person({
    String? name,
    int? age,
    @deprecated Gender? gender,
  }) = _Person;
}
```

이것은 다음 모두를 deprecated 처리합니다:

- 생성자
  ```dart
  Person(gender: Gender.something); // gender is deprecated
  ```
- 생성된 클래스의 생성자:
  ```dart
  _Person(gender: Gender.something); // gender is deprecated
  ```
- 프로퍼티:
  ```dart
  Person person;
  print(person.gender); // gender is deprecated
  ```
- `copyWith` 파라미터:
  ```dart
  Person person;
  person.copyWith(gender: Gender.something); // gender is deprecated
  ```

마찬가지로, 생성된 클래스를 데코레이팅하고 싶다면 정의하는 factory 생성자를 데코레이팅하면 됩니다.

따라서 `_Person`을 deprecated 처리하려면 다음과 같이 할 수 있습니다:

```dart
@freezed
abstract class Person with _$Person {
  @deprecated
  const factory Person({
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

## FromJson/ToJson

[Freezed]는 일반적인 `fromJson`/`toJson`을 직접 생성하지 않지만, [json_serializable]이 무엇인지는 알고 있습니다.

클래스를 [json_serializable]과 호환되게 만드는 것은 매우 간단합니다.

이 스니펫을 고려해 보세요:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

[json_serializable]과 호환되도록 하는 데 필요한 변경 사항은 두 줄입니다:

- 새로운 `part`: `part 'model.g.dart';`
- 대상 클래스에 새로운 생성자: `factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);`

최종 결과는 다음과 같습니다:

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

`pubspec.yaml` 파일에 `json_serializable`을 추가하는 것을 잊지 마세요:

```yaml
dev_dependencies:
  json_serializable:
```

이게 전부입니다!\
이러한 변경으로 [Freezed]는 자동으로 [json_serializable]에게 필요한 모든 `fromJson`/`toJson`을 생성하도록 요청할 것입니다.

**참고**:
Freezed는 factory가 `=>`를 사용하는 경우에만 fromJson을 생성합니다.

### fromJSON - 여러 생성자를 가진 클래스

여러 생성자를 가진 클래스의 경우, [Freezed]는 JSON 응답에서 `runtimeType`이라는 문자열 요소를 확인하고 그 값에 따라 사용할 생성자를 선택합니다. 예를 들어, 다음 생성자가 주어졌을 때:

```dart
@freezed
sealed class MyResponse with _$MyResponse {
  const factory MyResponse(String a) = MyResponseData;
  const factory MyResponse.special(String a, int b) = MyResponseSpecial;
  const factory MyResponse.error(String message) = MyResponseError;

  factory MyResponse.fromJson(Map<String, dynamic> json) => _$MyResponseFromJson(json);
}
```

[Freezed]는 각 JSON 객체의 `runtimeType`을 사용하여 다음과 같이 생성자를 선택합니다:

```json
[
  {
    "runtimeType": "default",
    "a": "이 JSON 객체는 MyResponse() 생성자를 사용합니다"
  },
  {
    "runtimeType": "special",
    "a": "이 JSON 객체는 MyResponse.special() 생성자를 사용합니다",
    "b": 42
  },
  {
    "runtimeType": "error",
    "message": "이 JSON 객체는 MyResponse.error() 생성자를 사용합니다"
  }
]
```

`@Freezed`와 `@FreezedUnionValue` 데코레이터를 사용하여 키와 값을 다른 것으로 사용자 정의할 수 있습니다:

```dart
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
sealed class MyResponse with _$MyResponse {
  const factory MyResponse(String a) = MyResponseData;

  @FreezedUnionValue('SpecialCase')
  const factory MyResponse.special(String a, int b) = MyResponseSpecial;

  const factory MyResponse.error(String message) = MyResponseError;

  factory MyResponse.fromJson(Map<String, dynamic> json) =>
      _$MyResponseFromJson(json);
}
```

이것은 이전 json을 다음과 같이 업데이트합니다:

```json
[
  {
    "type": "Default",
    "a": "이 JSON 객체는 MyResponse() 생성자를 사용합니다"
  },
  {
    "type": "SpecialCase",
    "a": "이 JSON 객체는 MyResponse.special() 생성자를 사용합니다",
    "b": 42
  },
  {
    "type": "Error",
    "message": "이 JSON 객체는 MyResponse.error() 생성자를 사용합니다"
  }
]
```

모든 클래스에 대해 키와 값을 사용자 정의하려면 `build.yaml` 파일 내에 명시할 수 있습니다. 예를 들어:

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          union_key: type
          union_value_case: pascal
```

JSON 응답을 제어할 수 없다면 사용자 정의 컨버터를 구현할 수 있습니다. 사용자 정의 컨버터는 사용할 생성자를 결정하는 자체 로직을 구현해야 합니다.

```dart
class MyResponseConverter implements JsonConverter<MyResponse, Map<String, dynamic>> {
  const MyResponseConverter();

  @override
  MyResponse fromJson(Map<String, dynamic> json) {
    // type 데이터가 이미 설정된 경우 (예: 우리가 직접 직렬화한 경우)
    if (json['runtimeType'] != null) {
      return MyResponse.fromJson(json);
    }
    // 어떤 타입인지 알기 위한 조건을 찾아야 합니다. 예: json에 특정 필드가 있는지 확인
    if (isTypeData) {
      return MyResponseData.fromJson(json);
    } else if (isTypeSpecial) {
      return MyResponseSpecial.fromJson(json);
    } else if (isTypeError) {
      return MyResponseError.fromJson(json);
    } else {
      throw Exception('JSON 매핑을 위한 생성자를 결정할 수 없습니다');
    }
 }

  @override
  Map<String, dynamic> toJson(MyResponse data) => data.toJson();
}
```

사용자 정의 컨버터를 적용하려면 생성자 파라미터에 데코레이터를 전달합니다.

```dart
@freezed
abstract class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() MyResponse myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

이렇게 하면, json serializable은 `MyResponse`를 변환하기 위해 `MyResponseConverter.fromJson()`과 `MyResponseConverter.toJson()`을 사용합니다.

`List`에 포함된 생성자 파라미터에도 사용자 정의 컨버터를 사용할 수 있습니다.

```dart
@freezed
abstract class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() List<MyResponse> myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

**참고**:
중첩된 freezed 객체 리스트를 직렬화하려면 `@JsonSerializable(explicitToJson: true)`를 명시하거나 `build.yaml` 파일 내에서 `explicit_to_json`을 변경해야 합니다([문서 참조](https://github.com/google/json_serializable.dart/tree/master/json_serializable#build-configuration)).

### 제네릭 클래스 역직렬화

제네릭 타입의 freezed 객체를 직렬화/역직렬화하려면 `genericArgumentFactories`를 활성화할 수 있습니다.\
`fromJson` 메서드의 시그니처를 변경하고 freezed 설정에 `genericArgumentFactories: true`를 추가하기만 하면 됩니다.

```dart
@Freezed(genericArgumentFactories: true)
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.data(T data) = ApiResponseData;
  const factory ApiResponse.error(String message) = ApiResponseError;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$ApiResponseFromJson(json, fromJsonT);
}
```

또는 `build.yaml` 파일을 수정하여 전체 프로젝트에 대해 `genericArgumentFactories`를 활성화할 수 있습니다:

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          generic_argument_factories: true
```

**`@JsonKey` 어노테이션은 어떻게 하나요?**

생성자 파라미터에 전달된 모든 데코레이터는 생성된 프로퍼티에도 "복사-붙여넣기"됩니다.\
따라서 다음과 같이 작성할 수 있습니다:

```dart
@freezed
abstract class Example with _$Example {
  factory Example(@JsonKey(name: 'my_property') String myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

**`@JsonSerializable` 어노테이션은 어떻게 하나요?**

`@JsonSerializable` 어노테이션은 생성자 위에 배치하여 전달할 수 있습니다. 예:

```dart
@freezed
abstract class Example with _$Example {
  @JsonSerializable(explicitToJson: true)
  factory Example(@JsonKey(name: 'my_property') SomeOtherClass myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

모든 클래스에 대해 사용자 정의 json_serializable 플래그(예: `explicit_to_json` 또는 `any_map`)를 정의하려면 `build.yaml` 파일을 통해 할 수 있습니다. [여기](https://pub.dev/packages/json_serializable#build-configuration)에서 설명된 대로 하세요.

[데코레이터와 주석](#데코레이터와-주석) 섹션도 참조하세요.

## 유니온 타입

다른 언어에서 온 경우 "유니온 타입", "실드 클래스(sealed classes)", 패턴 매칭과 같은 기능에 익숙할 수 있습니다.

이것들은 타입 시스템과 결합하여 강력한 도구이지만, Dart에서 사용하기에는 특별히 편리하지 않습니다.

하지만 걱정 마세요, [Freezed]는 이를 지원하며, 여러분을 돕기 위한 몇 가지 유틸리티를 생성합니다!

요약하자면, 모든 Freezed 클래스에서 여러 생성자를 작성할 수 있습니다:

```dart
@freezed
sealed class Union with _$Union {
  const factory Union.data(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = Error;
}
```

이렇게 함으로써, 우리 모델은 이제 서로 배타적인 다른 상태를 가질 수 있습니다.

특히, 이 스니펫은 `Union`이라는 모델을 정의하고, 이 모델은 3가지 가능한 상태를 가집니다:

- data
- loading
- error

우리가 정의한 factory 생성자의 오른쪽에 의미 있는 이름을 부여한 것을 주목하세요. 나중에 유용하게 사용될 것입니다.

이 예제에서는 더 이상 다음과 같은 코드를 작성할 수 없다는 것을 알 수 있습니다:

```dart
void main() {
  Union union = Union.data(42);

  print(union.value); // 컴파일 오류: value 프로퍼티가 존재하지 않음
}
```

그 이유는 다음 섹션에서 설명하겠습니다.

### 공유 프로퍼티

여러 생성자를 정의하면, 모든 생성자에 공통되지 않은 프로퍼티를 읽을 수 없게 됩니다:

예를 들어, 다음과 같이 작성하면:

```dart
@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

`age`와 `population`을 직접 읽을 수 없게 됩니다:

```dart
var example = Example.person('Remi', 24);
print(example.age); // 컴파일되지 않음!
```

반면에, 모든 생성자에 정의된 프로퍼티는 읽을 **수 있습니다**.
예를 들어, `name` 변수는 `Example.person`과 `Example.city` 생성자 모두에 공통적입니다.

따라서 다음과 같이 작성할 수 있습니다:

```dart
var example = Example.person('Remi', 24);
print(example.name); // Remi
example = Example.city('London', 8900000);
print(example.name); // London
```

같은 로직이 `copyWith`에도 적용될 수 있습니다.\
모든 생성자에 정의된 프로퍼티로 `copyWith`를 사용할 수 있습니다:

```dart
var example = Example.person('Remi', 24);
print(example.copyWith(name: 'Dash')); // Example.person(name: Dash, age: 24)

example = Example.city('London', 8900000);
print(example.copyWith(name: 'Paris')); // Example.city(name: Paris, population: 8900000)
```

반면에, 특정 생성자에만 있는 프로퍼티는 사용할 수 없습니다:

```dart
var example = Example.person('Remi', 24);

example.copyWith(age: 42); // 컴파일 오류, `age` 파라미터가 존재하지 않음
```

이 문제를 해결하려면, "패턴 매칭"이라는 것을 사용하여 객체의 상태를 확인해야 합니다.

### 패턴 매칭을 사용하여 공유되지 않는 프로퍼티 읽기

이 섹션에서는 다음 유니온을 고려해 보겠습니다:

```dart
@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

패턴 매칭을 사용하여 `Example` 인스턴스의 내용을 읽는 방법을 알아봅시다.

이를 위해 Dart의 내장 패턴 매칭인 `switch`를 사용해야 합니다:

```dart
switch (example) {
  Person(:final name) => print('Person $name'),
  City(:final population) => print('City ($population)'),
}
```

또는 `if`-`case` 문을 사용할 수도 있습니다:

```dart
if (example case Person(:final name)) {
  print('Person $name');
} else if (example case City(:final population)) {
  print('City ($population)');
}
```

`is`/`as`를 사용하여 `Example` 변수를 `Person` 또는 `City`로 캐스팅할 수도 있지만, 이것은 매우 권장되지 않습니다. 다른 두 가지 옵션 중 하나를 사용하세요.

### 유니온 타입의 개별 클래스를 위한 Mixin과 Interface

같은 클래스에 여러 타입이 있을 때, 그 타입 중 하나가 인터페이스를 구현하거나 클래스를 mixin하고 싶을 수 있습니다. `@Implements` 또는 `@With` 데코레이터를 각각 사용하여 그렇게 할 수 있습니다. 다음 예제에서 `City`는 `GeographicArea`를 구현합니다.

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

이것은 `AdministrativeArea<House>`와 같은 제네릭 클래스를 구현하거나 mixin하는 경우에도 작동하지만, 클래스가 `AdministrativeArea<T>`와 같은 제네릭 타입 파라미터를 가질 때는 예외입니다. 이 경우 freezed는 올바른 코드를 생성하지만, Dart는 컴파일 시 어노테이션 선언에서 로드 오류를 발생시킵니다. 이를 피하려면 다음과 같이 `@Implements.fromString` 및 `@With.fromString` 데코레이터를 사용해야 합니다:

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

**참고**: 모든 추상 멤버를 구현하여 인터페이스 요구 사항을 준수해야 합니다. 인터페이스에 멤버가 없거나 필드만 있는 경우, 유니온 타입의 생성자에 추가하여 인터페이스 계약을 이행할 수 있습니다. 인터페이스가 메서드나 getter를 정의하고 클래스에서 구현하는 경우, [모델에 getter와 메서드 추가하기](#모델에-getter와-메서드-추가하기) 지침을 사용해야 합니다.

**참고 2**: `@With`/`@Implements`를 freezed 클래스와 함께 사용할 수 없습니다. Freezed 클래스는 확장하거나 구현할 수 없습니다.

### 개별 유니온 케이스 분리하기

모델을 세밀하게 제어하기 위해, Freezed는 유니온의 서브클래스를 수동으로 작성하는 기능을 제공합니다.

다음을 고려해 보세요:

```dart
@freezed
sealed class Result<T> with _$Result {
  factory Result.data(T data) = ResultData;
  factory Result.error(Object error) = ResultError;
}
```

이제 `ResultData`를 직접 작성하고 싶다고 가정해 봅시다. 그러려면 같은 파일에 `ResultData` 클래스를 정의하기만 하면 됩니다:

```dart
@freezed
sealed class Result<T> with _$Result {
  factory Result.data(T data) = ResultData;
  factory Result.error(Object error) = ResultError;
}

class ResultData<T> implements Result<T> {
  // TODO: implement Result<T>
}
```

추출된 클래스도 Freezed 클래스가 될 수 있습니다!

```dart
@freezed
sealed class Result<T> with _$Result<T> {
  const Result._();
  const factory Result.data(T data) = ResultData;
  const factory Result.error(Object error) = ResultError;
}

// TODO: ResultData에만 고유한 메서드 추가
@freezed
abstract class ResultData<T> extends Result<T> with _$ResultData<T> {
  const factory ResultData(T data) = _ResultData;
  const ResultData._() : super._();
}
```

#### (레거시) 패턴 매칭 유틸리티

> [!WARNING]
> Dart 3부터 Dart는 sealed 클래스를 사용한 내장 패턴 매칭을 지원합니다.
> 따라서 더 이상 패턴 매칭을 위해 Freezed가 생성한 메서드에 의존할 필요가 없습니다.
> `when`/`map` 대신 공식 Dart 구문을 사용하세요.
>
> `when`/`map`에 대한 참조는 아직 Dart 3으로 마이그레이션하지 않은 사용자를 위해 유지됩니다.
> 하지만 장기적으로는 이것들에 의존하는 것을 중단하고 `switch` 표현식으로 마이그레이션해야 합니다.

##### When

[when] 메서드는 구조 분해(destructing)를 사용한 패턴 매칭과 동일합니다. 메서드의 프로토타입은 정의된 생성자에 따라 다릅니다.

예를 들어, 다음과 같이 정의했다면:

```dart
@freezed
sealed class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = ErrorDetails;
}
```

[when]은 다음과 같습니다:

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

반면, 다음과 같이 정의했다면:

```dart
@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

[when]은 다음과 같습니다:

```dart
var model = Model.first('42');

print(
  model.when(
    first: (String a) => 'first $a',
    second: (int b, bool c) => 'second $b $c'
  ),
); // first 42
```

각 콜백이 생성자의 이름 및 프로토타입과 일치하는 것을 확인하세요.

##### Map

[map] 메서드는 [when]과 동일하지만, 구조 분해를 **하지 않습니다**.

이 클래스를 고려해 보세요:

```dart
@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

이런 클래스에서 [when]은 다음과 같지만:

```dart
var model = Model.first('42');

print(
  model.when(
    first: (String a) => 'first $a',
    second: (int b, bool c) => 'second $b $c'
  ),
); // first 42
```

[map]은 대신 다음과 같습니다:

```dart
var model = Model.first('42');

print(
  model.map(
    first: (First value) => 'first ${value.a}',
    second: (Second value) => 'second ${value.b} ${value.c}'
  ),
); // first 42
```

이것은 [copyWith]/`toString`과 같은 복잡한 작업을 할 때 유용할 수 있습니다:

```dart
var model = Model.second(42, false)
print(
  model.map(
    first: (value) => value,
    second: (value) => value.copyWith(c: true),
  )
); // Model.second(b: 42, c: true)
```

## 설정

Freezed는 생성된 코드를 사용자 정의할 수 있는 다양한 옵션을 제공합니다. 이를 위해 두 가지 가능성이 있습니다:

### 특정 모델의 동작 변경하기

하나의 특정 클래스에 대해서만 생성된 코드를 사용자 정의하고 싶다면, 다른 어노테이션을 사용하여 그렇게 할 수 있습니다:

```dart
@Freezed()
abstract class Person with _$Person {
  factory Person(String name, int age) = _Person;
}
```

이렇게 하면 `@Freezed`에 다양한 파라미터를 전달하여 출력을 변경할 수 있습니다:

```dart
@Freezed(
  // copyWith/== 생성 비활성화
  copyWith: false,
  equal: false,
)
 abstract class Person with _$Person {...}
```

모든 가능성을 보려면 `@Freezed` 문서를 참조하세요: <https://pub.dev/documentation/freezed_annotation/latest/freezed_annotation/Freezed-class.html>

### 전체 프로젝트의 동작 변경하기

하나의 클래스에 변경 사항을 적용하는 대신, 모든 Freezed 모델에 동시에 적용하고 싶을 수 있습니다.

`build.yaml`이라는 파일을 사용자 정의하여 그렇게 할 수 있습니다.\
이 파일은 `pubspec.yaml` 옆에 위치해야 하는 선택적 설정 파일입니다:

```
my_project_folder/
  pubspec.yaml
  build.yaml
  lib/
```

여기서 `@Freezed`에서 찾을 수 있는 옵션과 동일한 옵션을 변경할 수 있습니다(위 참조):

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          # Freezed에게 .freezed.dart 파일을 포맷하도록 지시합니다.
          # 이는 코드 생성을 상당히 느리게 할 수 있습니다.
          # 포맷팅 비활성화는 프로젝트 SDK 제약 조건에서 Dart 3.7 이상을 선택할 때만 작동합니다.
          format: true
          # 전체 프로젝트에 대해 copyWith/== 생성 비활성화
          copy_with: false
          equal: false
```

# 유틸리티

## IDE 확장 프로그램

### VSCode용 Freezed 확장 프로그램

[Freezed](https://marketplace.visualstudio.com/items?itemName=blaxou.freezed) 확장 프로그램은 freezed 작업을 더 빠르게 하는 데 도움이 될 수 있습니다. 예를 들어:

- <kbd>Ctrl+Shift+B</kbd> (Mac에서는 <kbd>Cmd+Shift+B</kbd>)를 사용하여 `build_runner`로 빠르게 빌드하세요.
- <kbd>Ctrl+Shift+P</kbd> (Mac에서는 <kbd>Cmd+Shift+P</kbd>)> `Generate Freezed class`를 사용하여 Freezed 클래스를 빠르게 생성하세요.

### IntelliJ/Android Studio용 Freezed 확장 프로그램

[여기](https://github.com/Tinhorn/freezed_intellij_live_templates)에서 상용구 코드를 위한 Live Templates를 얻을 수 있습니다.

예시:

- **freezedClass**를 입력하고 <kbd>Tab</kbd>을 눌러 freezed 클래스를 생성하세요
  ```dart
  @freezed
  class Demo with _$Demo {
  }
  ```
- **freezedFromJson**을 입력하고 <kbd>Tab</kbd>을 눌러 json_serializable을 위한 fromJson 메서드를 생성하세요
  ```dart
  factory Demo.fromJson(Map<String, dynamic> json) => _$DemoFromJson(json);
  ```

## 린팅(Linting)

`freezed` 클래스를 만들 때 유용한 유틸리티를 제공하고 일반적인 실수를 잡아내는 `freezed` 관련 린팅 규칙을 추가할 수 있습니다.

[`custom_lint`](https://pub.dev/packages/custom_lint)와 `freezed_lint`를 `pubspec.yaml`에 추가하세요:

```console
dart pub add dev:custom_lint
dart pub add dev:freezed_lint
```

또한 `analysis_options.yaml`에 `custom_lint`를 추가하세요:

```yaml
analyzer:
  plugins:
    - custom_lint
```

## 서드파티 도구

이 부분에는 Freezed와 통합되는 커뮤니티 제작 도구가 포함되어 있습니다.

### DartJ

[DartJ](https://dartj.web.app/#/)는 [**@ttpho**](https://github.com/ttpho)가 만든 Flutter 애플리케이션으로, JSON 페이로드로부터 Freezed 클래스를 생성합니다.

예시:

<https://github.com/ttpho/ttpho/assets/3994863/5d529258-c02c-4066-925e-ca2ffc68a804>

## 스폰서

<p align="center">
  <a href="https://raw.githubusercontent.com/rrousselGit/freezed/master/sponsorkit/sponsors.svg">
    <img src='https://raw.githubusercontent.com/rrousselGit/freezed/master/sponsorkit/sponsors.svg'/>
  </a>
</p>

[build_runner]: https://pub.dev/packages/build_runner
[freezed]: https://pub.dartlang.org/packages/freezed
[freezed_annotation]: https://pub.dartlang.org/packages/freezed_annotation
[json_serializable]: https://pub.dev/packages/json_serializable