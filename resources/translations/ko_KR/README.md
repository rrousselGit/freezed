[English](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/README.md) | [한국어](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ko_KR/README.md) | [简体中文](https://github.com/rrousselGit/freezed/blob/master/resources/translations/zh_CN/README.md) | [日本語](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ja_JP/README.md) | [Tiếng Việt](https://github.com/rrousselGit/freezed/blob/master/resources/translations/vi_VN/README.md)

![Build](https://github.com/rrousselGit/freezed/workflows/Build/badge.svg)
[![pub package](https://img.shields.io/pub/v/freezed.svg)](https://pub.dartlang.org/packages/freezed)
<a href="https://discord.gg/GSt793j6eT"><img src="https://img.shields.io/discord/765557403865186374.svg?logo=discord&color=blue" alt="Discord"></a>

[<img src="https://raw.githubusercontent.com/rrousselGit/provider/master/resources/flutter_favorite.png" width="200" />](https://flutter.dev/docs/development/packages-and-plugins/favorites)

[Freezed] 세계에 오신걸 환영합니다. [Freezed]는 data-classes/unions/cloning를 위한 코드 생성기입니다.

# Freezed가 만들어진 이유

Dart는 훌륭한 언어입니다. 하지만 "모델"을 정의하는 과정은 번거롭습니다.

모델을 정의하려면 아래와 같은 작업이 필요합니다:

생성자와 속성 정의하기
toString, operator ==, hashCode 오버라이드
객체를 복사하기 위한 copyWith 메서드 구현
직렬화 및 역직렬화 처리
게다가 Dart에는 union types나 pattern-matching 같은 기능이 없습니다.

이 모든 것을 직접 구현하려면 코드가 수백 줄로 늘어날 수도 있습니다. 이런 작업은 오류를 만들기 쉽고, 모델의 가독성을 떨어뜨릴 수 있습니다.

[Freezed]는 이런 부분들을 대신 처리해줌으로써 위와 같은 문제를 해결하고, 사용자가 모델 정의에 집중할 수 있도록 도와줍니다.

| Freezed 사용 전                                                                    | Freezed 사용 후                                                                  |
| ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| ![before](https://github.com/rrousselGit/freezed/blob/master/resources/before.png) | ![After](https://github.com/rrousselGit/freezed/blob/master/resources/after.png) |

# 목차

- [Freezed를 만들게된 이유](#Freezed를-만들게된-이유)
- [목차](#목차)
- [사용방법](#사용방법)
  - [설치하기](#설치하기)
    - [invalid_annotation_target 경고 및 생성파일의 경고를 비활성 시키기](#invalid_annotation_target-경고-및-생성파일의-경고를-비활성-시키기)
  - [generator 실행하기](#generator-실행하기)
  - [Freezed를 사용하여 모델 생성하기](#Freezed를-사용하여-모델-생성하기)
    - [immutable 클래스 대신 mutable 클래스 정의하기](#Immutable-클래스-대신-Mutable-클래스-정의하기)
    - [Lists/Maps/Sets의 변경 허용하기](#listsmapssets의-변경-허용하기)
    - [copyWith의 작동방식](#copyWith의-작동방식)
    - [더 나아가기: 깊은복사](#더-나아가기-깊은복사)
    - [모델에 getters 와 메서드 추가하기](#모델에-getters와-메서드-추가하기)
    - [Asserts](#asserts)
    - [기본 값](#기본-값)
    - [데코레이터와 코멘트](#데코레이터와-코멘트)
    - [Union Types에서 Mixin 및 Interface 사용하기](#Union-Types에서-Mixin-및-Interface-사용하기)
  - [FromJson/ToJson](#fromjsontojson)
    - [fromJSON - 복수의 생성자가 있는 클래스](#fromjson---복수의-생성자가-있는-클래스)
    - [제네릭 클래스 역직렬화하기](#제네릭-클래스-역직렬화하기)
  - [Union types과 Sealed classes](#Union-types과-Sealed-classes)
    - [공유속성 Shared properties](#공유속성-Shared-properties)
    - [패턴매칭(pattern-matching)을 사용하여 비공유 속성 읽기](#패턴매칭pattern-matching을-사용하여-비공유-속성읽기)
      - [권장하지 않는 패턴매칭 메소드](#)
        - [When](#when)
        - [Map](#map)
  - [환경설정](#환경설정)
    - [특정 모델의 동작변경](#특정-모델의-동작변경)
    - [전체 프로젝트의 동작변경](#전체-프로젝트의-동작변경)
- [Utilities](#utilities)
  - [VSCode전용 Freezed extension](#VSCode전용-Freezed-extension)
  - [IntelliJ/Android Studio전용 Freezed extension](#IntelliJAndroid-Studio전용-Freezed-extension)
  - [Sponsors](#sponsors)

# 사용방법

## 설치하기

[Freezed]를 사용하려면 일반적으로 [build_runner]/code-generator 설정이 필요합니다.
먼저 [build_runner]와 [Freezed]를 `pubspec.yaml` 파일에 추가합니다.

만약에 `Flutter`프로젝트를 생성하는 경우에는 아래와 같이 진행합니다.

```console
flutter pub add freezed_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
# fromJson/toJson 생성도 사용하려면 아래를 추가하세요:
flutter pub add json_annotation
flutter pub add dev:json_serializable
```

만약에 `Dart`프로젝트를 생성하는 경우에는 아래와 같이 진행합니다.

```console
dart pub add freezed_annotation
dart pub add dev:build_runner
dart pub add dev:freezed
# fromJson/toJson 생성도 사용하려면 아래를 추가하세요:
dart pub add json_annotation
dart pub add dev:json_serializable
```

이렇게 하면 3개의 패키지(freezed_annotation, build_runner, freezed)가 설치됩니다.

- [build_runner](https://pub.dev/packages/build_runner): `code-generators`를 실행하기 위한 도구입니다.
- [freezed]: `code generator` 입니다.
- [freezed_annotation](https://pub.dev/packages/freezed_annotation): [freezed]전용 annotations을 포함하고 있는 패키지.

### invalid_annotation_target 경고 및 생성파일의 경고를 비활성 시키기

[Freezed]를 `json_serializable`과 함께 사용할 계획이라면 최근 `json_serializable`와 `meta` 버전의 `invalid_annotation_target` 경고를 비활성화해야 할 수 있습니다.

이를 해결하려면 프로젝트 루트에서 `analysis_options.yaml`에 아래의 내용을 추가할 수 있습니다.

```yaml
analyzer:
  errors:
    invalid_annotation_target: ignore
```

## generator 실행하기

코드 생성기를 실행하려면 다음 명령을 실행하십시오.

```
dart run build_runner build
```

`Flutter`프로젝트라면 아래의 명령을 수행하면 됩니다.

```
flutter pub run build_runner build
```

대부분의 코드 생성기와 마찬가지로 [Freezed]는 `annotation`([freezed_annotation])을 모두 import해야 합니다.
그리고 파일 상단에 `part` 키워드를 사용하세요.

이 처럼 [Freezed]를 사용하려는 파일은 아래와 같이 시작합니다.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_file.freezed.dart';

```

**고려사항**
`package:flutter/foundation.dart`도 같이 import해서 사용합니다. 그 이유는 `foundation.dart`를 가져오면 Flutter의 `devtool`에서 개체를 보기 좋게 만들기 위해 클래스도 가져오기 때문입니다 `foundation.dart`를 가져오면 [Freezed]가 자동으로 수행합니다.

## Freezed를 사용하여 모델 생성하기

예제는 길고긴 추상적인 설명보다 이해하기 쉽습니다.
다음은 전형적인 Freezed 클래스입니다:

```dart
// 이 파일은 "main.dart" 입니다.
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// 필수: `main.dart`를 Freezed에서 생성한 코드와 연결합니다.
part 'main.freezed.dart';
// 옵션(선택사항): Person 클래스는 직렬화 가능하므로 이 줄을 추가해야 합니다.
// 그러나 Person이 직렬화 가능하지 않은 경우 건너뛸 수 있습니다.
part 'main.g.dart';

@freezed
abstract class Person with _$Person {
  const factory Person({
    required String firstName,
    required String lastName,
    required int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);
}
```

다음 `snippet`은 `Person`이라는 모델을 정의합니다.

- `Person`에는 `firstName`, `lastName` 및 `age`의 3가지 속성이 있습니다.
- 우리는 `@freezed`를 사용하기 때문에 이 클래스의 모든 속성은 변경할 수 없습니다(immutable).
- 'fromJson'을 정의했기 때문에 이 클래스는 역직렬화/직렬화 가능합니다.
  Freezed는 `toJson` 메서드를 자동으로 추가할 것입니다.
- Freeze는 자동으로 아래의 항목을 생성합니다.
  - 다른 속성을 가진 객체를 복제하기 위한 `copyWith` 메서드
  - 객체의 모든 속성을 나열하는 `toString` 재정의(오버라이드)
  - `operator ==` 및 `hashCode` 재정의(`Person`은 변경할 수 없으므로(immutable)

예제로부터 우리는 몇 가지를 알 수 있습니다.

- 모델에 `@freezed`(또는 `@Freezed`/`@unfreezed`, 나중에(아래에) 자세히 설명)annotate을 달아야 합니다.
  이 `annotation`은 Freezed에게 해당 클래스에 대한 코드를 생성하도록 지시하는 것입니다.
- 또한 접두사 `_$`가 붙은 클래스 이름과 함께 `믹스인(mixin)`을 적용해야 합니다. 믹스인은 객체의 다양한 속성/메서드를 정의합니다.

- Freezed 클래스에서 생성자를 정의할 때 표시된 대로 `factory` 키워드를 사용해야 합니다(`const`는 선택 사항임).
  이 생성자의 매개변수는 이 클래스에 포함된 모든 속성의 목록이 됩니다.
  매개변수는 **필요하지 않음**에 이름을 지정하고 필수로 지정해야 합니다. 부담없이 사용하세요
  원하는 경우 positional optional parameters를 사용하세요.

### Immutable 클래스 대신 Mutable 클래스 정의하기

지금까지 모든 속성이 `final`인 모델을 정의하는 방법을 살펴보았습니다.
그러나 모델에서 변경 가능한 속성을 정의할 수 있습니다.

Freezed는 `@freezed` annotation을 `@unfreezed`로 대체하여 사용할 수 있습니다.

```dart
@unfreezed
abstract class Person with _$Person {
  factory Person({
    required String firstName,
    required String lastName,
    required final int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);
}
```

위의 예시는 이전 `snippets`과 거의 동일하지만 다음과 같은 차이점이 있는 모델을 정의합니다.

- `firstName`과 `lastName`은 이제 변경할 수 있습니다. 따라서 다음과 같이 작성할 수 있습니다.

  ```dart
  void main() {
    var person = Person(firstName: 'John', lastName: 'Smith', age: 42);

    person.firstName = 'Mona';
    person.lastName = 'Lisa';
  }
  ```

- `age`는 속성을 명시적으로 `final`로 표시했기 때문에 여전히 변경할 수 없습니다(immutable).
- `Person`에는 더 이상 사용자 정의 ==/hashCode 구현이 없습니다.

  ```dart
  void main() {
    var john = Person(firstName: 'John', lastName: 'Smith', age: 42);
    var john2 = Person(firstName: 'John', lastName: 'Smith', age: 42);

    print(john == john2); // false
  }
  ```

- 당연히 `Person` 클래스는 변경 가능하므로 `const`를 사용하여 더 이상 인스턴스화할 수 없습니다.

### Lists/Maps/Sets의 변경 허용하기

기본적으로 `@freezed`를 사용할 때(`@unfreezed`는 제외), `List`/`Map`/`Set` 데이터 타입의 속성은 변경할 수 없도록 변환됩니다(immutable).

즉, 아래와 같이 작성하면 런타임 예외(runtime exception)가 발생합니다.

```dart
@freezed
abstract class Example with _$Example {
  factory Example(List<int> list) = _Example;
}

void main() {
  var example = Example([]);
  example.list.add(42); // 컬렉션을 변경하기 때문에 throw됩니다.
}
```

아래와 같이 설정하면 해당 동작을 비활성화할 수 있습니다.

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

### copyWith의 작동방식

이전에 설명했듯이 [Freezed]를 사용하여 모델을 정의할 때 코드 생성기는 자동으로 `copyWith` 메서드를 생성합니다. 이는 다른 값을 가진 개체를 복제하는 데 사용됩니다.

예를 들어 다음을 정의하는 경우:

```dart
@freezed
abstract class Person with _$Person {
  factory Person(String name, int? age) = _Person;
}
```

그 다음 아래와 같이 작성할 수 있습니다.

```dart
void main() {
  var person = Person('Remi', 24);

  // `age`가 전달되지 않고 값이 유지됩니다.
  print(person.copyWith(name: 'Dash')); // Person(name: Dash, age: 24)
  // `age`는 `null`로 설정됩니다.
  print(person.copyWith(age: null)); // Person(name: Remi, age: null)
}
```

Freezed는 `person.copyWith(age: null)`을 지원하는것에 주목하세요.

### 더 나아가기: 깊은복사

`copyWith`는 그 자체로 매우 강력하지만 더 복잡한 객체에서는 불편해지기 시작합니다.

아래와 같은 클래스들이 있다고 생각해 봅시다.

```dart
@freezed
abstract class Company with _$Company {
  factory Company({String? name, required Director director}) = _Company;
}

@freezed
abstract class Director with _$Director {
  factory Director({String? name, Assistant? assistant}) = _Director;
}

@freezed
abstract class Assistant with _$Assistant {
  factory Assistant({String? name, int? age}) = _Assistant;
}
```

그런 다음 `Company`에 참조된 `Assistant`에 대한 변경을 원할 수 있습니다.\
예를 들어, `copyWith`를 사용하여 `Assistant`의 `name`을 변경하려면 다음과 같이 작성해야 합니다.

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

위의 코드는 잘 동작하지만 많은 복사로 인해 비교적 코드가 장황합니다.
여기에서 [Freezed]의 "깊은복사(deep copy)"를 사용할 수 있습니다.

만약에 [Freezed]모델이 또 다른 [Freezed]모델을 속성을 가지고 있다면,
코드 생성기는 이전 예제에 대한 대체 구문을 제공합니다.

```dart
Company company;

Company newCompany = company.copyWith.director.assistant(name: 'John Smith');
```

이 snippet은 이전 snippet(업데이트된 `assistant`의 `name`으로 새로운 `company` 생성)과 완전히 동일한 결과를 달성하지만 더 이상 중복되지 않습니다.

이 구문을 더 자세히 살펴보고 대신 감독(director)의 이름을 변경하려면 다음과 같이 작성할 수 있습니다.

```dart
Company company;
Company newCompany = company.copyWith.director(name: 'John Doe');
```

전반적으로 위에서 언급한 `Company`/`Director`/`Assistant`의 정의에 따라 다음의 모든 "복사" 구문이 작동합니다.

```dart
Company company;

company = company.copyWith(name: 'Google', director: Director(...));
company = company.copyWith.director(name: 'Larry', assistant: Assistant(...));
```

**Null 고려사항**

일부 객체는 `null`일 수도 있습니다. 예를 들어, `Company` 클래스를 사용하면 `Director`의 `assistant`가 `null`이 될 수 있습니다.

예를 들어, 다음과 같이 작성해보면

```dart
Company company = Company(name: 'Google', director: Director(assistant: null));
Company newCompany = company.copyWith.director.assistant(name: 'John');
```

말도 안 되는 이야기이죠. 의미 없습니다.
처음부터 assistant가 없으면 assistant의 이름을 변경할 수 없습니다.

이 상황에서 `company.copyWith.director.assistant`는 `null`을 반환하여 코드를 컴파일하지 못하게 합니다.

이를 수정하기 위해 `?.call` 연산자를 사용하고 다음과 같이 작성할 수 있습니다.

```dart
Company? newCompany = company.copyWith.director.assistant?.call(name: 'John');
```

### 모델에 getters와 메서드 추가하기

때로는 클래스에서 메서드/속성을 수동으로 정의하고 싶을 수도 있습니다.
그러나 아래의 코드를 작성해보면 빨리 이해할 수 있습니다.

```dart
@freezed
abstract class Person with _$Person {
  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

위의 코드는 작동하지 않습니다.

원하는 메서드나 속성을 추가하려면 추가처리가 필요합니다.
`a private empty constructor`를 정의해야 합니다.

```dart
@freezed
abstract class Person with _$Person {
  // 생성자를 추가했습니다. 매개변수가 없어야 합니다.
  const Person._();

  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

### Asserts

Dart는 `factory` 생성자에 `assert(...)` 문을 추가하는 것을 허용하지 않습니다.
따라서 Freezed 클래스에 assert를 추가하려면 `@Assert` 데코레이터가 필요합니다.

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

### 기본 값

asserts과 유사하게 Dart는 "redirecting factory constructors"이 기본값을 지정하는 것을 허용하지 않습니다.
따라서 속성의 기본값을 지정하려면 `@Default` annotation이 필요합니다.

```dart
class Example with _$Example {
  const factory Example([@Default(42) int value]) = _Example;
}
```

**NOTE**:\
직렬화/역직렬화를 사용하는 경우 자동으로 `@JsonKey(defaultValue: <something>)`가 추가됩니다.

### 데코레이터와 코멘트

[Freezed]는 각각의 매개변수와 생성자 정의를 decorators/documentation하여 속성 및 클래스 수준 decorators/documentation를 지원합니다.

아래와 같은 예제를 생각해봅시다.

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

`name`을 문서화하려면 다음을 수행할 수 있습니다.

```dart
@freezed
abstract class Person with _$Person {
  const factory Person({
    /// 사용자의 이름입니다.
    ///
    /// null이 아니어야 합니다.
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

속성 `gender`를 `@deprecated`로 표시하려면 아래의 예시처럼 작성해 보세요.

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

이렇게 하면 둘 다 더 이상 사용되지 않습니다.

- 생성자(The constructor):
  ```dart
  Person(gender: Gender.something); // gender는 더 이상 사용되지 않습니다
  ```
- 자동 생성된 클래스의 생성자(The generated class's constructor):
  ```dart
  _Person(gender: Gender.something); // gender는 더 이상 사용되지 않습니다
  ```
- 속성(the property):
  ```dart
  Person person;
  print(person.gender); // gender는 더 이상 사용되지 않습니다
  ```
- `copyWith` 파라미터 (the `copyWith` parameter):
  ```dart
  Person person;
  person.copyWith(gender: Gender.something); // gender는 더 이상 사용되지 않습니다
  ```

마찬가지로 생성된 클래스를 decorate하려는 경우 정의하는 팩토리 생성자를 decorate할 수 있습니다.
다시 말해, 클래스 자체를 `deprecated` 시키기 위해서는 factory 생성자위에 `@deprecated`를 annotation으로 붙여주면 됩니다.

따라서 `_Person`을 더 이상 사용하지 않으려면 다음과 같이 작성하면 됩니다.

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

### Union Types에서 Mixin 및 Interface 사용하기

Union Type 클래스는 `@implements` 또는 `@with` decarator를 사용하여 `Mixin` 또는 `Interface`를 구현할 수 있습니다. 아래 예제에서는 `City` 클래스가 `GeographicArea` 추상 클래스를 구현합니다.

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

이 방법은 제네릭 클래스, 예를 들어 `AdministrativeArea<House>`를 구현하는 경우에도 동작합니다. 그러나 `AdministrativeArea<T>`처럼 제네릭 타입을 받는 클래스일 때는 문제가 발생합니다. 이 경우에는 `freezed`가 올바른 코드를 생성하는 것처럼 보이지만, Dart 컴파일 과정에서 `Load` 에러가 발생합니다. 따라서 `@Implements.fromSring` 또는 `@With.fromString` decorator를 사용해야 합니다.

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

**Note**: 인터페이스를 완벽하게 준수하는지 확인해야 합니다. 만약 인터페이스가 `method`나 `getter`를 정의하지 않고, `filed`만을 정의한다면, Union Type의 생성자에서 이를 초기화해야 합니다. 반면에 `method`, `getter`를 정의한다면 반드시 이를 구현해야합니다. [모델에 getters 와 메서드 추가하기](#모델에-getters와-메서드-추가하기)를 참고하세요.

**Note**: `freezed` 클래스에는 `@With` / `@Implements`를 사용할 수 없습니다. `extension`을 사용하거나 직접 구현하세요.

## FromJson/ToJson

[Freezed]는 일반적인 `fromJson`/`toJson`을 자체적으로 생성하지 않지만 [json_serializable]이 무엇인지 알고 있습니다.

[json_serializable]과 호환되는 클래스를 만드는 것은 매우 간단합니다.

아래의 snippet을 확인해보세요.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
abstract class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

[json_serializable]과 호환되도록 하는 데 필요한 변경 사항은 다음 두 줄로 구성됩니다.

- `part`를 새로 추가합니다: `part 'model.g.dart';`
- 새로운 생성자를 추가합니다: `factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);`

최종적인 결과는 아래와 같습니다.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
abstract class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
}
```

`pubspec.yaml`에 `json_serializable`을 추가하는 것을 잊지마세요.

```yaml
dev_dependencies:
  json_serializable:
```

이게 전부입니다!\
간단한 변경으로 [Freezed]는 [json_serializable]에 필요한 모든 `fromJson`/`toJson`을 생성하도록 자동으로 요청합니다.

**Note**:
Freezed는 factory가 `=>`를 사용하는 경우에만 `fromJson`을 생성합니다.

### fromJSON - 복수의 생성자가 있는 클래스

여러 생성자가 있는 클래스의 경우 [Freezed]는 `runtimeType`이라는 문자열 요소에 대한 JSON 응답을 확인하고 해당 값에 따라 사용할 생성자를 선택합니다.
예를 들어, 다음 생성자가 주어진 경우:

```dart
@freezed
abstract class MyResponse with _$MyResponse {
  const factory MyResponse(String a) = MyResponseData;
  const factory MyResponse.special(String a, int b) = MyResponseSpecial;
  const factory MyResponse.error(String message) = MyResponseError;

  factory MyResponse.fromJson(Map<String, dynamic> json) => _$MyResponseFromJson(json);
}
```

[Freezed]는 각 JSON 객체의 `runtimeType`을 사용하여 다음과 같이 생성자를 선택합니다.

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

`@Freezed` 및 `@FreezedUnionValue` 데코레이터를 사용하여 다른 것으로 키와 값을 사용자 정의할 수 있습니다.

```dart
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
class MyResponse with _$MyResponse {
  const factory MyResponse(String a) = MyResponseData;

  @FreezedUnionValue('SpecialCase')
  const factory MyResponse.special(String a, int b) = MyResponseSpecial;

  const factory MyResponse.error(String message) = MyResponseError;

  // ...
}
```

이전 json을 아래와 같이 업데이트합니다.

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

모든 클래스의 키와 값을 사용자 정의하려면 `build.yaml` 파일 내부에 지정할 수 있습니다.
예를 들면 다음과 같습니다.

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          union_key: type
          union_value_case: pascal
```

JSON 응답을 제어하지 않는 경우 사용자 지정 변환기를 구현할 수 있습니다.
사용자 지정 변환기는 사용할 생성자를 결정하기 위한 자체 논리를 구현해야 합니다.

```dart
class MyResponseConverter implements JsonConverter<MyResponse, Map<String, dynamic>> {
  const MyResponseConverter();

  @override
  MyResponse fromJson(Map<String, dynamic> json) {
    // 타입 데이터가 이미 설정되었습니다(예: 직접 직렬화했기 때문에)
    if (json['runtimeType'] != null) {
      return MyResponse.fromJson(json);
    }

    // 어떤 타입인지 알기 위해서는 몇 가지 조건을 찾아야 합니다. 예를 들어 json에 일부 필드가 있는지 확인하십시오.
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

그런 다음 사용자 지정 변환기(커스텀 컨버터)를 적용하려면 데코레이터를 생성자 매개변수에 전달합니다.

```dart
@freezed
abstract class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() MyResponse myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

이렇게 하면 직렬화 가능한 json은 `MyResponseConverter.fromJson()` 및 `MyResponseConverter.toJson()`을 사용하여 `MyResponse`를 변환합니다.
`List`에 포함된 생성자 매개변수에 사용자 지정 변환기(custom converter)를 사용할 수도 있습니다.

```dart
@freezed
abstract class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() List<MyResponse> myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

**Note**:

고정된 개체의 중첩 목록을 직렬화하려면 `@JsonSerializable(explicitToJson: true)`을 지정하거나 `build.yaml` 파일([see the documentation](https://github.com/google/json_serializable.dart/tree/master/json_serializable#build-configuration)) 내에서 `explicit_to_json`을 변경해야 합니다.

### 제네릭 클래스 역직렬화하기

제네릭 타입의 freezed 객체를 역/직렬화하기 위해서는 `genericArgumentFactories`를 사용할 수 있습니다.
이를 위해서는 `fromJson` 메서드의 시그니처를 바꾸고 `genericArgumentFactories: true`를 freezed 환경설정에 추가해야 합니다:

```dart
@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.data(T data) = ApiResponseData;
  const factory ApiResponse.error(String message) = ApiResponseError;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$ApiResponseFromJson(json, fromJsonT);
}
```

아래와 같이 `build.yaml` 파일을 수정해서 프로젝트 전체에서 `genericArgumentFactories`를 허용할 수도 있습니다:

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          generic_argument_factories: true
```

**`@JsonKey` annotation은 어떤가요?**

생성자 매개변수에 전달된 모든 데코레이터는 생성된 속성에도 "복사-붙여넣기"됩니다.
따라서 다음과 같이 작성할 수 있습니다.

```dart
@freezed
abstract class Example with _$Example {
  factory Example(@JsonKey(name: 'my_property') String myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

**`@JsonSerializable` annotation은 어떤가요?**

예를 들어 다음과 같이 생성자 위에 배치하여 `@JsonSerializable` annotation을 전달할 수 있습니다.

```dart
@freezed
abstract class Example with _$Example {
  @JsonSerializable(explicitToJson: true)
  factory Example(@JsonKey(name: 'my_property') SomeOtherClass myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

모든 클래스에 대해 사용자 정의 json_serializable 플래그를 정의하려는 경우(예를 들어 `explicit_to_json` 또는 `any_map`) [여기](https://pub.dev/packages/json_serializable#build-configuration)에 설명된 대로 `build.yaml` 파일을 통해 수행할 수 있습니다.

[데코레이터와 코멘트](#데코레이터와-코멘트) 섹션을 참고해보세요.

## Union types

만약 다른 언어를 쓰다 오셨다면 "union types"/"sealed classes"/pattern matching과 같은 기능을 사용한 적이 있을 겁니다.
이 기능들은 Dart 3부터 도입되어 타입 시스템에서 타입을 조합해내는 강력한 도구지만, 기본적인 사용 방법은 생산적이지 않습니다.
하지만 걱정마세요. [Freezed]가 몇 가지 유틸리티를 만들어서 이 기능들을 지원하니까요.
간단히 말해서 모든 Freezed 클래스에서 복수의 생성자를 작성할 수 있습니다.

```dart
@freezed
sealed class Union with _$Union {
  const factory Union.data(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = Error;
}
```

> [!메모]
> 이 예제에서는 Dart 3에서 도입된 키워드를 사용합니다. Dart 3를 사용하는 경우 Freezed 객체를 정의할 때 항상 `sealed` 키워드를 사용해야 합니다. 아직 Dart 2를 사용 중이라면 무시해도 되지만, 기본적인 pattern matching을 사용하려면 Dart 3으로 업그레이드해야 합니다.

이렇게 하면 우리의 모델이 이제 상호 배타적인 상태가 될 수 있습니다.
구체적으로 말하자면, 이 snippet은 `Union` 모델을 정의하며 해당 모델은 3가지 상태를 가집니다.

- data
- loading
- error

정의한 팩토리 생성자의 오른쪽에 의미 있는 이름을 부여하는 방법을 주목하세요.
나중에 유용하게 사용할 수 있습니다.

또 주목해야 할 점은 이 예시에서 다음과 같은 코드는 더 이상 쓸 수 없다는 것입니다.

```dart
void main() {
  Union union = Union.data(42);

  print(union.value); // 컴파일 오류: 속성 값이 존재하지 않습니다
}
```

다음 섹션에서 그 이유를 살펴보겠습니다.

### 공유속성 Shared properties

여러 생성자를 정의하면 모든 생성자들이 공통적으로 가지고 있지 않은 속성을 읽을 수 없게 됩니다.

예를 들어 다음과 같이 작성하는 경우:

```dart
@freezed
abstract class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

`age`와 `population` 속성은 직접 읽을 수 없습니다.

```dart
var example = Example.person('Remi', 24);
print(example.age); // 컴파일되지 않습니다!
```

반면에 모든 생성자에 정의된 속성은 **읽을 수** 있습니다.

예를 들어 `name` 변수는 `Example.person` 및 `Example.city` 생성자 모두 공통으로 가지고 있는 속성입니다.

따라서 다음과 같이 코드를 쓸 수 있습니다.

```dart
var example = Example.person('Remi', 24);
print(example.name); // Remi
example = Example.city('London', 8900000);
print(example.name); // London
```

같은 논리를 `copyWith`에도 적용할 수 있습니다.
모든 생성자에 정의된 속성에는 `copyWith`를 사용할 수 있습니다.

```dart
var example = Example.person('Remi', 24);
print(example.copyWith(name: 'Dash')); // Example.person(name: Dash, age: 24)

example = Example.city('London', 8900000);
print(example.copyWith(name: 'Paris')); // Example.city(name: Paris, population: 8900000)
```

반면에 특정 생성자에만 있는 속성에는 사용할 수 없습니다.

```dart
var example = Example.person('Remi', 24);

example.copyWith(age: 42); // 컴파일 오류, 매개변수 `age`가 존재하지 않습니다
```

이 문제를 해결하려면 "pattern matching"을 사용하여 객체의 상태를 확인해야 합니다.

### 패턴매칭(pattern-matching)을 사용하여 비공유 속성읽기

이번 섹션에서는 다음에 나오는 union을 한 번 봅시다.

```dart
@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

이제 패턴 비교(pattern matching)를 사용하여 `Example` 인스턴스의 내용을 읽는 방법을 살펴보겠습니다.

이 경우에는 `switch`를 사용하여 Dart 3의 기본 pattern matching을 사용해야합니다.

```dart
switch (example) {
  Person(:final name) => print('Person $name'),
  City(:final population) => print('City ($population)'),
}
```

만약 Dart 2를 사용하고 있다면, freezed의 [legacy pattern matching utilities](https://github.com/rrousselGit/freezed?tab=readme-ov-file#legacy-pattern-matching-utilities)를 사용해서 객체의 내용을 검사할 수 있습니다. 또한 `is` / `as` 를 사용하여 `Example` 변수를 `Person` 이나 `city`로 cast할 수 있지만, 권장하지 않습니다. `when` / `map` 옵션을 사용하세요.

#### 권장하지 않는 패턴매칭 메소드

> [!WARNING]
> Dart 3부터는 sealed class를 사용한 patten matching이 도입되었습니다.
> 따라서 더 이상 freezed가 생성하는 pattern matching 메소드를 사용할 필요가 없습니다.
> `when`/`map` 대신 Dart 공식 문법을 사용하세요.
>
> 당장은 문제없지만, Dart 3으로 업그레이드를 고려한다면 `switch` 구문으로 마이그레이션하는 것을 권장합니다.

##### When

[when] 메서드는 '구조 분해(destructuring)'를 사용한 패턴 비교와 동일합니다.
when 메서드의 프로토타입은 생성자가 정의된 방식에 따라 다릅니다.

아래의 예시를 보면

```dart
@freezed
abstract class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = ErrorDetails;
}
```

[when]은 아래와 같이 사용할 수 있습니다.

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

반면에 다음과 같이 정의하면

```dart
@freezed
abstract class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

[when]은 아래와 같이 사용할 수 있습니다.

```dart
var model = Model.first('42');

print(
  model.when(
    first: (String a) => 'first $a',
    second: (int b, bool c) => 'second $b $c'
  ),
); // first 42
```

각 콜백이 생성자의 이름 및 프로토타입과 어떻게 일치하는지 확인하십시오.

**NOTE**:\
모든 콜백이 필수이며 `null` 이 아니어야 합니다.\
원하는 방식이 아니라면 [maybeWhen] 사용을 고려해보세요.

##### Map

[map] 메서드는 [when]와 동일하지만 **구조분해(destructing)를 하지 않**습니다.

아래에 정의된 클래스를 생각해봅시다.

```dart
@freezed
abstract class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

이러한 클래스를 사용하면 [when] 메서드를 다음과 같이 쓸 수 있습니다.

```dart
var model = Model.first('42');

print(
  model.when(
    first: (String a) => 'first $a',
    second: (int b, bool c) => 'second $b $c'
  ),
); // first 42
```

[map] 메서드을 사용하면 다음과 같습니다.

```dart
var model = Model.first('42');

print(
  model.map(
    first: (First value) => 'first ${value.a}',
    second: (Second value) => 'second ${value.b} ${value.c}'
  ),
); // first 42
```

예를 들어 [copyWith]/`toString`과 같은 복잡한 작업을 수행하려는 경우에 유용할 수 있습니다.

```dart
var model = Model.second(42, false)
print(
  model.map(
    first: (value) => value,
    second: (value) => value.copyWith(c: true),
  )
); // Model.second(b: 42, c: true)
```

## 환경설정

[Freezed]는 생성된 코드를 사용자 정의할 수 있는 다양한 옵션을 제공합니다. 예를 들어 `when` 메서드의 생성을 비활성화할 수 있습니다.

이렇게 하려면 두 가지 경우가 있습니다.

### 특정 모델의 동작변경

하나의 특정 클래스에 대해서만 생성된 코드를 사용자 지정하려면 다른 annotation을 사용하여 수행할 수 있습니다.

```dart
@Freezed()
class Person with _$Person {
  factory Person(String name, int age) = _Person;
}
```

이렇게 하면 이제 다양한 매개변수를 `@Freezed`에 전달하여 출력을 변경할 수 있습니다.

```dart
@Freezed(
  // copyWith/== 생성 비활성화
  copyWith: false,
  equal: false,
)
class Person with _$Person {...}
```

모든 가능한 경우를 확인해보고자 한다면 `@Freezed` 문서를 참조하세요: https://pub.dev/documentation/freezed_annotation/latest/freezed_annotation/Freezed-class.html

### 전체 프로젝트의 동작변경

수정 사항을 단일 클래스에 적용하는 대신 모든 Freezed 모델에 동시에 적용할 수 있습니다.
`build.yaml`이라는 파일을 사용자 지정하여 사용할 수 있습니다.
이 파일은 `pubspec.yaml` 파일과 동일 폴더에 위치해야 합니다.

```
my_project_folder/
  pubspec.yaml
  build.yaml
  lib/
```

거기에서 다음과 같이 작성하여 `@Freezed`(위 참조)에 있는 옵션과 동일한 옵션을 변경할 수 있습니다.

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          # 전체 프로젝트에 대해 copyWith/== 생성 비활성화
          copy_with: false
          equal: false
```

# Utilities

## IDE Extensions

### VSCode전용 Freezed extension

[Freezed](https://marketplace.visualstudio.com/items?itemName=blaxou.freezed)확장 프로그램을 사용하면 Freezed를 더 빠르게 작업할 수 있도록 도와줍니다.

예를 들어:

- `build_runner`를 사용하여 빠르게 빌드하려면 `Ctrl+Shift+B`(Mac의 경우 `Cmd+Shift+B`)를 사용하세요.
- 'Ctrl+Shift+P' > 'Freezed 클래스 생성'을 사용하여 Freezed 클래스를 빠르게 생성합니다.

### IntelliJ/Android Studio전용 Freezed extension

보일러 플레이트 코드에 대한 라이브 템플릿을 얻을 수 있습니다.
[확장링크](https://github.com/Tinhorn/freezed_intellij_live_templates).

예:

- **freezedClass**를 입력하고 <kbd>Tab</kbd>를 눌러 freezed 클래스를 생성합니다.
  ```dart
  @freezed
  class Demo with _$Demo {
  }
  ```
- **freezedFromJson**을 입력하고 <kbd>Tab</kbd>를 눌러 `json_serializable`에 대한 `fromJson` 메서드를 생성합니다.
  ```dart
  factory Demo.fromJson(Map<String, dynamic> json) => _$DemoFromJson(json);
  ```

## Third-party tools

이 단락에서는 `freezed`를 사용한 여러 툴들을 소개합니다.

### DartJ

[DartJ](https://dartj.web.app/#/)는 =[**@ttpho**](https://github.com/ttpho)님이 만든 플러터 어플리케이션입니다. JSON 데이터를 통해 Freezed 클래스를 생성할 수 있습니다.

시연 영상:

<https://github.com/ttpho/ttpho/assets/3994863/5d529258-c02c-4066-925e-ca2ffc68a804>

## Sponsors

<p align="center">
  <a href="https://raw.githubusercontent.com/rrousselGit/freezed/master/sponsorkit/sponsors.svg">
    <img src='https://raw.githubusercontent.com/rrousselGit/freezed/master/sponsorkit/sponsors.svg'/>
  </a>
</p>

[build_runner]: https://pub.dev/packages/build_runner
[freezed]: https://pub.dartlang.org/packages/freezed
[freezed_annotation]: https://pub.dartlang.org/packages/freezed_annotation
[copywith]: #copyWith
[when]: #when
[maybewhen]: #maybeWhen
[map]: #mapMaybeMap
[maybemap]: #mapMaybeMap
[json_serializable]: https://pub.dev/packages/json_serializable
