[English](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/README.md) | [한국어](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ko_KR/README.md) | [简体中文](https://github.com/rrousselGit/freezed/blob/master/resources/translations/zh_CN/README.md) | [日本語](https://github.com/rrousselGit/freezed/blob/master/resources/translations/ja_JP/README.md)

![Build](https://github.com/rrousselGit/freezed/workflows/Build/badge.svg)
[![pub package](https://img.shields.io/pub/v/freezed.svg)](https://pub.dartlang.org/packages/freezed)
<a href="https://discord.gg/hUUQkd9v"><img src="https://img.shields.io/discord/765557403865186374.svg?logo=discord&color=blue" alt="Discord"></a>

[<img src="https://raw.githubusercontent.com/rrousselGit/provider/master/resources/flutter_favorite.png" width="200" />](https://flutter.dev/docs/development/packages-and-plugins/favorites)

[Freezed]へようこそ、Freezedはdata classes、unions、cloningのためのコードジェネレーターです。

> [!注意]
> マクロを使用したFreezedの初期プレビューが利用可能です。
> 詳細は<https://github.com/rrousselGit/freezed/tree/macros>を参照してください。

# モチベーション

Dartは素晴らしい言語ですが、「モデル」を定義するのは面倒です。通常、次のようなことをする必要があります。

- コンストラクターとプロパティの定義
- `toString`、`operator ==`、`hashCode`のオーバーライド
- オブジェクトを複製するための`copyWith`の実装
- シリアライズとデシリアライズの処理

これらを実装するとなると、数百行の実装が必要となり、エラーも発生しやすく、モデルの可読性にも大きく影響します。

Freezedは、上記のほとんどを自動的に実装することにより、モデルの定義にのみ集中できることを目的としています。

| Before                                                                                       | After                                                                                       |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| ![before](https://raw.githubusercontent.com/rrousselGit/freezed/master/resources/before.png) | ![before](https://raw.githubusercontent.com/rrousselGit/freezed/master/resources/after.png) |

# 目次

- [モチベーション](#モチベーション)
- [目次](#目次)
- [使い方](#使い方)
  - [インストール](#インストール)
    - [invalid\_annotation\_targetのwarning無効化および生成されたファイル内のwarning](#invalid_annotation_targetのwarning無効化および生成されたファイル内のwarning)
  - [ジェネレーターの実行](#ジェネレーターの実行)
  - [Freezedを使用したモデルの作成](#freezedを使用したモデルの作成)
    - [イミュータブルクラスの代わりにミュータブルクラスを定義する](#イミュータブルクラスの代わりにミュータブルクラスを定義する)
    - [Lists/Maps/Setsの変更を許可する](#listsmapssetsの変更を許可する)
    - [copyWithの仕組み](#copywithの仕組み)
    - [発展: Deep copy](#発展-deep-copy)
    - [モデルにゲッターとメソッドを追加する](#モデルにゲッターとメソッドを追加する)
    - [アサート](#アサート)
    - [デフォルト値](#デフォルト値)
    - [デコーダーとコメント](#デコーダーとコメント)
    - [個々のクラスにミックスインとインタフェースを使用して合成型を作る](#個々のクラスにミックスインとインタフェースを使用して合成型を作る)
  - [FromJsonとToJson](#fromjsonとtojson)
    - [fromJson - 複数のコンストラクタを持つクラス](#fromjson---複数のコンストラクタを持つクラス)
    - [ジェネリッククラスのデシリアライズ](#ジェネリッククラスのデシリアライズ)
  - [ユニオン型](#ユニオン型)
    - [共有プロパティ](#共有プロパティ)
    - [パターンマッチングを使って非共有のプロパティを読み取る方法](#パターンマッチングを使って非共有のプロパティを読み取る方法)
      - [（レガシー）パターンマッチングユーティリティ](#レガシーパターンマッチングユーティリティ)
        - [When](#when)
        - [Map](#map)
  - [設定](#設定)
    - [特定のモデルに対する動作変更](#特定のモデルに対する動作変更)
    - [プロジェクト全体の動作変更](#プロジェクト全体の動作変更)
- [ユーティリティ](#ユーティリティ)
  - [IDE拡張機能](#ide拡張機能)
    - [VSCode用のFreezed拡張機能](#vscode用のfreezed拡張機能)
    - [IntelliJとAndroid StudioのFreezed拡張機能](#intellijとandroid-studioのfreezed拡張機能)
  - [サードパーティツール](#サードパーティツール)
    - [DartJ](#dartj)
  - [スポンサー](#スポンサー)

# 使い方

## インストール

[Freezed]を利用するには、通常の[build_runner]/code-generatorのセットアップが必要です。
まず、次の手順で`pubspec.yaml`ファイルに[build_runner]と[Freezed]を追加してください。

Flutterプロジェクトの場合:

```console
flutter pub add freezed_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
# FreezedでfromJson/toJsonを生成する場合は以下も追加
flutter pub add json_annotation
flutter pub add dev:json_serializable
```

Dartプロジェクトの場合:

```console
dart pub add freezed_annotation
dart pub add dev:build_runner
dart pub add dev:freezed
# FreezedでfromJson/toJsonを生成する場合は以下も追加
dart pub add json_annotation
dart pub add dev:json_serializable
```

これにより、次の3つのパッケージがインストールされます。

- [build_runner](https://pub.dev/packages/build_runner): コードジェネレーターを実行するツール
- [freezed]: コードジェネレーター
- [freezed_annotation](https://pub.dev/packages/freezed_annotation): [freezed]用のアノテーションを含むパッケージ

### invalid_annotation_targetのwarning無効化および生成されたファイル内のwarning

[Freezed]を`json_serializable`と組み合わせて使用する場合、最新バージョンの`json_serializable`と`meta`では、`invalid_annotation_target`のwarningを無効にする必要があるかもしれません。

これを行うには、プロジェクトのルートにある`analysis_options.yaml`ファイルに以下を追加します:

```yaml
analyzer:
  errors:
    invalid_annotation_target: ignore
```

## ジェネレーターの実行

コードジェネレーターを実行するには、次のコマンドを実行してください:

```
dart run build_runner build
```

ほとんどのコードジェネレーターと同様に、[Freezed]を使用するには、アノテーション（[freezed_annotation]）をインポートし、ファイルの先頭で`part`キーワードを使用する必要があります。

そのため、[Freezed]を使用したいファイルは次のように始まります。

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_file.freezed.dart';

```

**考慮する** `package:flutter/foundation.dart`もインポートしてください。
理由としては、`foundation.dart`をインポートすることにより、Flutterのdevtoolでオブジェクトをきれいに読みやすくするためのクラスも一緒にインポートされるからです。
`foundation.dart`をインポートすると、[Freezed]がそれを自動的に行なってくれます。

## Freezedを使用したモデルの作成

抽象的な説明よりも具体的な例の方が分かりやすいので、典型的なFreezedクラスを紹介します。

```dart
// このファイルは "main.dart" です
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// 必須: この`main.dart`とFreezedによって生成されたコードを関連付けます
part 'main.freezed.dart';
// 任意: Personクラスはシリアライズ可能なので、この行を追加する必要があります。
// もし、Personがシリアライズ不可能なら、この行は省略できます。
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

次のスニペットは`Person`という名前モデルを定義しています:

- `Person`は3つのプロパティ`firstName`、`lastName`、`age`を持っています。
- `@freezed`を使用しているので、このクラスの全てのプロパティはイミュータブルです。
- `fromJson`メソッドを定義しているので、このクラスはデシリアライズおよびシリアライズが可能です。
  Freezedは自動的に`toJson`メソッドも自動的に追加します。
- Freezedは以下も自動生成します。
    - `copyWith`メソッドは、異なるプロパティを持つオブジェクトを複製します。
    - `toString`オーバーライドは、オブジェクトの全てのプロパティを列挙します。
    - `operator ==`と`hashCode`のオーバーライド（`Person`はイミュータブルなので）

この例から、いくつかのことがわかります。

- モデルには、`@freezed`（または`@Freezed`や`@unfreezed`については後述）というアノテーションを付ける必要があります。
  このアノテーションが、Freezedにそのクラスのコードを生成するように指示します。

- クラス名の前に`_$`が付いたミックスインを適用する必要があります。
  このミックスインが、オブジェクトの様々なプロパティやメソッドを定義します。

- Freezedクラスでコンストラクタを定義する際、`factory`キーワードを使う必要があります（constは任意です）。 
  コンストラクタのパラメータは、クラスに含まれるすべてのプロパティのリストになります。
  パラメータは名前付きである必要は**なく**、必要に応じて位置指定のオプションパラメータを使うこともできます。

### イミュータブルクラスの代わりにミュータブルクラスを定義する

これまでは、全てのプロパティが`final`のモデルを定義する方法を見てきました。
しかし、モデル内でミュータブルなプロパティを定義したい場合もあるでしょう。

Freezedは、`@freezed`アノテーションを`@unfreezed`で置き換えることで、これをサポートしています。

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

このスニペットは、以前とほぼ同じモデルを定義していますが、次の点が異なります。

- `firstName`と`lastName`がミュータブルになりました。そのため、次のように書くことができます。

  ```dart
  void main() {
    var person = Person(firstName: 'John', lastName: 'Smith', age: 42);

    person.firstName = 'Mona';
    person.lastName = 'Lisa';
  }
  ```

- `age`はイミュータブルのままです。なぜなら、プロパティを`final`として明記しているからです。
- `Person`は==とhashCodeの実装がなくなりました。

  ```dart
  void main() {
    var john = Person(firstName: 'John', lastName: 'Smith', age: 42);
    var john2 = Person(firstName: 'John', lastName: 'Smith', age: 42);

    print(john == john2); // false
  }
  ```

- もちろん、`Person`はミュータブルなクラスなので、`const`を使ってインスタンス化することはできなくなります。

### Lists/Maps/Setsの変更を許可する

デフォルトでは、`@freezed`（ただし`@unfreezed`を除く）を使用する場合、`List`/`Map`/`Set`型のプロパティはイミュータブルとして扱われます。

そのため、次のようなコードを実行すると、実行時に例外が発生します。

```dart
@freezed
abstract class Example with _$Example {
  factory Example(List<int> list) = _Example;
}

void main() {
  var example = Example([]);
  example.list.add(42); // コレクションを変更しようとしているため、例外がスローされます
}
```

この挙動は、次のように書くことで無効化できます。

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

### copyWithの仕組み

前述のように、Freezedを使ってモデルを定義すると、コードジェネレーターが自動的に`copyWith`メソッドを生成します。
このメソッドは、異なる値を持つオブジェクトを複製するために使われます。

例えば、以下のようにクラスを定義するとします。

```dart
@freezed
abstract class Person with _$Person {
  factory Person(String name, int? age) = _Person;
}
```

このとき、次のように書くことができます。

```dart
void main() {
  var person = Person('Remi', 24);

  // `age`に値が渡されていないので、ageの値は変わらない
  print(person.copyWith(name: 'Dash')); // Person(name: Dash, age: 24)
  // `age`に`null`がセットされる
  print(person.copyWith(age: null)); // Person(name: Remi, age: null)
}
```

Freezedは、`person.copyWith(age: null)`をサポートするということに気をつけてください。

### 発展: Deep copy

`copyWith`自体は非常に強力ですが、より複雑なオブジェクトを扱う際は不便になります。

次のようなクラスを考えてみましょう。

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

このとき、`Company`の参照から`Assistant`の変更を行いたいとします。
例えば、Assistantの`name`を変更するには、`copyWith`を使って次のように書く必要があります。

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

これは _動作します_ が、重複が多く冗長になってしまいます。
ここで、[Freezed]の「deep copy」を使用することができます。

Freezedモデルが他のFreezedモデルをプロパティとして含んでいる場合、コードジェネレーターは上記の例の代わりとなる次のような構文を提供します。

```dart
Company company;

Company newCompany = company.copyWith.director.assistant(name: 'John Smith');
```

このスニペットは、上記のスニペットと同じ結果（アシスタントの名前を更新した新しい会社の作成）になりますが、重複がなくなりました。

この構文をさらに深く掘り下げると、ディレクターの名前を変更したい場合は、次のように書くことができます。

```dart
Company company;
Company newCompany = company.copyWith.director(name: 'John Doe');
```

全体として、上記の`Company`/`Director`/`Assistant`の定義に基づくと、以下のすべての「copy」構文が機能します。

```dart
Company company;

company = company.copyWith(name: 'Google', director: Director(...));
company = company.copyWith.director(name: 'Larry', assistant: Assistant(...));
```

**Nullの考慮**

一部のオブジェクトは`null`になる場合もあります。例えば、`Company`クラスと使うと、
`Director`の`assistant`は`null`になる可能性があります。

そのため、次のように書くのは意味がありません。

```dart
Company company = Company(name: 'Google', director: Director(assistant: null));
Company newCompany = company.copyWith.director.assistant(name: 'John');
```

アシスタントが存在しないのに、アシスタントの名前を変更することはできません。

このような場合、`company.copyWith.director.assistant`は`null`を返し、コードがコンパイルに失敗します。

これを修正するには、`?.call`演算子を使用して次のように書くことができます。

```dart
Company? newCompany = company.copyWith.director.assistant?.call(name: 'John');
```

### モデルにゲッターとメソッドを追加する

場合によっては、クラス内にメソッドやプロパティを手動で定義したいことがあるかもしれません。
しかし、次のように書いてしまうと、すぐにエラーが発生することがわかります。

```dart
@freezed
abstract class Person with _$Person {
  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

この場合、`The non-abstract class _$_Person is missing implementations for these members:`というエラーが発生します。

これを機能させるには、プライベートな空のコンストラクタを定義する必要があります。これにより、次のように生成されたコードが*実装*する代わりに、*継承やサブクラス化*することができるようになります（デフォルトだと型のみを継承し、プロパティやメソッドは継承されません）。

```dart
@freezed
abstract class Person with _$Person {
  // コンストラクタを追加。パラメータを持たせてはいけない
  const Person._();

  const factory Person(String name, {int? age}) = _Person;

  void method() {
    print('hello world');
  }
}
```

### アサート

Dartでは、`factory`コンストラクタに`assert(...)`を追加することはできません。
そのため、Freezedクラスにアサートを追加するには、`@Assert`デコーダを追加する必要があります。

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

### デフォルト値

アサートと同じく、Dartでは「redirecting factory constructors」にデフォルト値を指定することはできません。

そのため、プロパティにデフォルト値を指定したい場合は、次のように`@Default`アノテーションを使用する必要があります。

```dart
class Example with _$Example {
  const factory Example([@Default(42) int value]) = _Example;
}
```

**注意**:\
シリアライズまたはデシリアライズを使用している場合、`@JsonKey(defaultValue: <something>)`が自動的に追加されます。

### デコーダーとコメント

[Freezed]は、それぞれのパラメータやコンストラクタ定義をデコレート/ドキュメント化することにより、プロパティおよびクラスレベルのデコレーター/ドキュメントコメントをサポートしています。

次の例を考えてみましょう。

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

もし、`name`プロパティにドキュメントコメントを追加したい場合は、次のように記述できます。

```dart
@freezed
abstract class Person with _$Person {
  const factory Person({
    /// ユーザーの名前
    ///
    /// nullになってはいけません
    String? name,
    int? age,
    Gender? gender,
  }) = _Person;
}
```

`gender`プロパティに`@deprecated`を付けたい場合は、次のよう書くことができます。

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

これにより、以下の全てが非推奨になります。

- コンストラクタ
  ```dart
  Person(gender: Gender.something); // gender is deprecated
  ```
- 生成されたクラスのコンストラクタ
  ```dart
  _Person(gender: Gender.something); // gender is deprecated
  ```
- プロパティ
  ```dart
  Person person;
  print(person.gender); // gender is deprecated
  ```
- `copyWith`のパラメータ
  ```dart
  Person person;
  person.copyWith(gender: Gender.something); // gender is deprecated
  ```

同様に、生成されたクラスをデコレートしたい場合は、定義するファクトリコンストラクタをデコレートすることができます。

そのため、`_Person`を非推奨にするには、次のように書くことができます。

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

### 個々のクラスにミックスインとインタフェースを使用して合成型を作る

同じクラス内に複数の型が存在する場合、そのうちの1つの型にインタフェースを実装させたり、クラスをミックスインさせたりしたいことがあるかもしれません。
これを実現するには、それぞれ`@Implements`デコーダまたは`@With`デコーダを使用します。
次の例では、`City`が`GeographicArea`を実装しています。

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

これは、ジェネリッククラス（例：`AdministrativeArea<House>`）を実装またはミックスインする場合も同様です。
ただし、クラスにジェネリック型のパラメータ（例：`AdministrativeArea<T>`）がある場合は例外です。
この場合、Freezed は正しいコードを生成しますが、コンパイル時にDartがアノテーション宣言でロードエラーをスローします。
これを回避するには、次のように`@Implements.fromString`と`@With.fromString`デコレーターを使用する必要があります:

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

**注意1**: インターフェースの要件に従って、すべての抽象メンバーを実装してください。
インターフェースがメンバーを持たない場合やフィールドしかない場合、それらをユニオン型のコンストラクタに追加することにより、インターフェース契約を満たすことができます。
インターフェイスがメソッドやゲッターを定義していて、それをクラスで実装する場合は、[Adding getters and methods to our models](#adding-getters-and-methods-to-our-models)を参照してください。

**注意2**: Freezedクラスで`@With`と`@Implements`を使うことはできません。
Freezedクラスは拡張や実装ができないためです。

## FromJsonとToJson

[Freezed]自体は`fromJson`と`toJson`を生成しませんが、[json_serializable]と互換性があります。

[json_serializable]と互換性のあるクラスを作成するのはとても簡単です。

次のスニペットを見てみましょう。

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

[json_serializable]と互換性を持たせるために必要な変更は次の2つです。

- 新しい`part`: `part 'model.g.dart';`
- ターゲットクラスの新しいコンストラクタ: `factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);`

変更後のコードは次のようになります。

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

`pubspec.yaml`に`json_serializable`を追加するのを忘れないでください。

```yaml
dev_dependencies:
  json_serializable:
```

これで完了です！
これらの変更により、[Freezed]は自動的に[json_serializable]を呼び出し、必要な`fromJson`と`toJson`のコードを生成します。

**注意**:
Freezed は、ファクトリが`=>`を使用している場合にのみ、fromJsonを生成します。

### fromJson - 複数のコンストラクタを持つクラス

複数のコンストラクタを持つクラスの場合、[Freezed]はJSONレスポンスから`runtimeType`という文字列要素を確認し、その値に基づいて使用するコンストラクタを選択します。
例えば、次のコンストラクタがある場合について考えます。

```dart
@freezed
sealed class MyResponse with _$MyResponse {
  const factory MyResponse(String a) = MyResponseData;
  const factory MyResponse.special(String a, int b) = MyResponseSpecial;
  const factory MyResponse.error(String message) = MyResponseError;

  factory MyResponse.fromJson(Map<String, dynamic> json) => _$MyResponseFromJson(json);
}
```

このとき、[Freezed]は、各JSONオブジェクトの`runtimeType`を使って、次のようにコンストラクタを選択します。

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

`@Freezed`と`@FreezedUnionValue`を使うと、キーと値を別のものにカスタマイズできます。

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

これにより、以前のJSONは次のように更新されます。

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

すべてのクラスのキーと値をカスタマイズしたい場合は、`build.yaml`ファイル内で指定できます。例えば、次のように記述します。

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          union_key: type
          union_value_case: pascal
```

もし、JSONレスポンスを制御できない場合、カスタムコンバータを実装することもできます。
カスタムコンバータは、使用するコンストラクタを決定するための独自のロジックを実装する必要があります。

```dart
class MyResponseConverter implements JsonConverter<MyResponse, Map<String, dynamic>> {
  const MyResponseConverter();

  @override
  MyResponse fromJson(Map<String, dynamic> json) {
    // typeデータが既にセットされている場合（例：自分たちでシリアライズした場合）
    if (json['runtimeType'] != null) {
      return MyResponse.fromJson(json);
    }
    // どの型なのかを判別するために条件分岐を行う必要があります (例：json内のフィールドの存在をチェック)
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

次に、このカスタムコンバータを適用するには、コンストラクタのパラメータにデコレータを渡します。

```dart
@freezed
abstract class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() MyResponse myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

これにより、json serializableは、`MyResponseConverter.fromJson()`と`MyResponseConverter.toJson()`を使って、`MyResponse`を変換します。

また、`List`に含まれるコンストラクタのパラメータにカスタムコンバータを使用することもできます。

```dart
@freezed
abstract class MyModel with _$MyModel {
  const factory MyModel(@MyResponseConverter() List<MyResponse> myResponse) = MyModelData;

  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}
```

**注意**
Freezedオブジェクトのネストされたリストをシリアライズするには、`@JsonSerializable(explicitToJson: true)`を指定するか、`build.yaml`ファイル内で`explicit_to_json`を変更する必要があります（[ドキュメントを参照](https://github.com/google/json_serializable.dart/tree/master/json_serializable#build-configuration)）。

### ジェネリッククラスのデシリアライズ

ジェネリック型のFreezedオブジェクトのデシリアライズまたはシリアライズを行うには、`genericArgumentFactories`を有効にします。
必要なのは、`fromJson`メソッドのシグネチャを変更して、freezedの設定に`genericArgumentFactories: true`を追加するだけです。

```dart
@Freezed(genericArgumentFactories: true)
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.data(T data) = ApiResponseData;
  const factory ApiResponse.error(String message) = ApiResponseError;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$ApiResponseFromJson(json, fromJsonT);
}
```

また、`build.yaml`ファイルを変更して、プロジェクト全体の`genericArgumentFactories`を有効にすることもできます。

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          generic_argument_factories: true
```

**`@JsonKey`はどうすればいいですか？**

コンストラクタのパラメータに渡されたすべてのデコレータは、生成されたプロパティにも"コピー&ペースト"されます。
したがって、次のように書くことができます。

```dart
@freezed
abstract class Example with _$Example {
  factory Example(@JsonKey(name: 'my_property') String myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

**`@JsonSerializable`はどうすればいいですか？**

コンストラクタの上に`@JsonSerializable`アノテーションを置くことで適用できます。
以下が例です。

```dart
@freezed
abstract class Example with _$Example {
  @JsonSerializable(explicitToJson: true)
  factory Example(@JsonKey(name: 'my_property') SomeOtherClass myProperty) = _Example;

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
}
```

全てのクラス（例`explicit_to_json`や`any_map`）に対してカスタムのjson_serializableフラグを定義したい場合、`build.yaml`ファイルで設定することができます。詳細は[こちら](https://pub.dev/packages/json_serializable#build-configuration)を参照してください。

また、[デコレータ](#decorators-and-comments)のセクションも参照してください。

## ユニオン型

他の言語からDartに移ってきた場合、「ユニオン型」や「シールドクラス」、「パターンマッチング」などの機能に慣れているかもしれません。

これらは型システムと組み合わせると強力なツールですが、Dart 2ではサポートされていません。
Dart 3ではサポートされていますが、使い勝手が良いとは言えません。

しかし、安心してください。[Freezed]はこれらをサポートしており、便利なユーティリティをいくつか生成してくれます！

簡単に言うと、Freezedクラスでは、次のように複数のコンストラクタを書くことができます。

```dart
@freezed
sealed class Union with _$Union {
  const factory Union.data(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = Error;
}
```

> [!注意]
> この例では、Dart 3で導入された`sealed`キーワードを使用しています。
> Dart 3を使用している場合は、Freezedユニオンを定義する際に必ずsealedキーワードを使用してください。
> Dart 2 を使用している場合は、これを無視しても問題ありませんが、ネイティブなパターンマッチングのためにDart 3へのアップグレードが推奨されます。

これにより、私たちのモデルは相互排他的な異なる状態を持つことができるようになりました。

具体的には、このスニペットでは、`Union`というモデルが定義され、そのモデルには以下の3つの状態があります。

- data
- loading
- error

注目すべきは、ファクトリーコンストラクタの右側に意味のある名前をつけたことです。
これらは後で役に立ちます。

また、この例では、次のようなコードが書けなくなることにも気づくかもしれません。

```dart
void main() {
  Union union = Union.data(42);

  print(union.value); // コンパイルエラー: プロパティvalueは存在しません
}
```

その理由は次にセクションで解説します。

### 共有プロパティ

複数のコンストラクタを定義すると、すべてのコンストラクタに共通でないプロパティを読み取ることができなくなります。

例えば、次のように書くとします。

```dart
@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

すると、`age`と`population`は直接読み取ることができなくなります。

```dart
var example = Example.person('Remi', 24);
print(example.age); // コンパイルエラー！
```

一方、すべてのコンストラクタで定義されているプロパティは、読み取り**可能**です。
例えば、`name`は`Example.person`と`Example.city`の両方のコンストラクタで共通しているプロパティです。

したがって、次のように書くことができます。

```dart
var example = Example.person('Remi', 24);
print(example.name); // Remi
example = Example.city('London', 8900000);
print(example.name); // London
```

同じロジックを`copyWith`に適用することもできます。
全コンストラクタ共通で定義されたプロパティでは、次のように`copyWith`を使用することができます。

```dart
var example = Example.person('Remi', 24);
print(example.copyWith(name: 'Dash')); // Example.person(name: Dash, age: 24)

example = Example.city('London', 8900000);
print(example.copyWith(name: 'Paris')); // Example.city(name: Paris, population: 8900000)
```

一方で、全コンストラクタ共通ではない固有のプロパティでは、使用できません。

```dart
var example = Example.person('Remi', 24);

example.copyWith(age: 42); // compilation error, parameter `age` does not exist
```

この問題を解決するには、"パターンマッチング"と呼ばれる手法を使ってオブジェクトの状態を確認する必要があります。

### パターンマッチングを使って非共有のプロパティを読み取る方法

このセクションでは、次のユニオン型を例に考えてみましょう。

```dart
@freezed
sealed class Example with _$Example {
  const factory Example.person(String name, int age) = Person;
  const factory Example.city(String name, int population) = City;
}
```

それでは、`Example`インスタンスの内容を読み取るためにパターンマッチングを使ってみましょう。

Dart 3の組み込みの`switch`を用いたパターンマッチングを使用して、次のように書くことができます。

```dart
switch (example) {
Person(:final name) => print('Person $name'),
City(:final population) => print('City ($population)'),
}
```

Dart 2を使用している場合、Freezedによって生成された[legacy pattern matching utilities](#legacy-pattern-matching-utilities)を使ってオブジェクトの内容を確認することもできます。

また、`is`や`as`を使って`Example`を`Person`または`City`にキャストすることもできますが、これは強く非推奨です。他の2つのオプションのいずれかを使用してください。

#### （レガシー）パターンマッチングユーティリティ

> [!警告]
> Dart 3以降、Dartはシールドクラスを使用した組み込みのパターンマッチング機能をサポートしています。
> そのため、パターンマッチングのためにFreezedが生成するメソッドに依存する必要はなくなりました。
> `when`や`map`の代わりに、公式のDart構文を使用してください。
>
> `when`や`map`に関する記述は、まだDart 3に移行していないユーザーのために残されています。 
> しかし、長期的には、それらに依存することをやめて`switch`式に移行する必要があります。

##### When

[when]メソッドは、デストラクティングを使用したパターンマッチングと同等です。
メソッドのプロトタイプは、定義されたコンストラクタによって異なります。

次の例について考えてみましょう。

```dart
@freezed
sealed class Union with _$Union {
  const factory Union(int value) = Data;
  const factory Union.loading() = Loading;
  const factory Union.error([String? message]) = ErrorDetails;
}
```

このとき、[when]を次のように使用することができます。

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

このとき、[when]は次のようになります。

```dart
@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

このとき、[when]は次のようになります。

```dart
var model = Model.first('42');

print(
model.when(
first: (String a) => 'first $a',
second: (int b, bool c) => 'second $b $c'
),
); // first 42
```

各コールバックは、それぞれのコンストラクタの名前とプロトタイプに一致していることに注意してください。

##### Map

[map]メソッドは[when]と同様の機能を持ちますが、デストラクチャリングを**行いません**。

次のクラスを考えてみましょう。

```dart
@freezed
sealed class Model with _$Model {
  factory Model.first(String a) = First;
  factory Model.second(int b, bool c) = Second;
}
```

このクラスの場合、[when]は次のように動作します。

```dart
var model = Model.first('42');

print(
model.when(
first: (String a) => 'first $a',
second: (int b, bool c) => 'second $b $c'
),
); // first 42
```

一方で、[map]は次のように動作します。

```dart
var model = Model.first('42');

print(
model.map(
first: (First value) => 'first ${value.a}',
second: (Second value) => 'second ${value.b} ${value.c}'
),
); // first 42
```

このメソッドは、[copyWith]や`toString`などの複雑な操作を行いたい場合に便利です。

```dart
var model = Model.second(42, false)
print(
model.map(
first: (value) => value,
second: (value) => value.copyWith(c: true),
)
); // Model.second(b: 42, c: true)
```

## 設定

Freezedには、生成されるコードをカスタマイズするためのさまざまなオプションが用意されています。
例えば、`when`メソッドの生成を無効にしたい場合などです。

これを実現するには、次の2つの方法があります。

### 特定のモデルに対する動作変更

特定のクラスに対して生成されるコードをカスタマイズしたい場合、別のアノテーションを使用することができます。

```dart
@Freezed()
class Person with _$Person {
  factory Person(String name, int age) = _Person;
}
```

`@Freezed`にさまざまなパラメータを渡すことで、生成されるコードの内容を変更できます。

```dart
@Freezed(
  // copyWithと==の生成を無効化
  copyWith: false,
  equal: false,
)
class Person with _$Person {...}
```

利用可能なオプションの詳細については、以下の`@Freezed`ドキュメントを参照してください。
<https://pub.dev/documentation/freezed_annotation/latest/freezed_annotation/Freezed-class.html>

### プロジェクト全体の動作変更

特定のクラスに対して変更を適用する代わりに、すべてのFreezedモデルに対して動作変更を一括で適用することもできます。

この場合、`build.yaml`というファイルをカスタマイズします。
このファイルはオプションの設定ファイルで、`pubspec.yaml`の隣に配置します：

```
my_project_folder/
  pubspec.yaml
  build.yaml
  lib/
```

ここで、`@Freezed`に渡すオプションと同様のオプションを設定できます（上記参照）。
次のように書くことができます。

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          # .freezed.dartファイルのフォーマットを無効にします。
          # これによりコード生成の速度が大幅に向上する可能性があります。
          format: false
          # プロジェクト全体でcopyWithや==の生成を無効にします。
          copy_with: false
          equal: false
          # `true`または`false`の設定により、`when`と`map`の生成を有効または無効にします。
          map: false
          # 特定の`when`と`map`のバリアントの生成を個別に有効または無効にできます。
          when:
            when: true
            maybe_when: true
            when_or_null: false
```

# ユーティリティ

## IDE拡張機能

### VSCode用のFreezed拡張機能

拡張機能[Freezed](https://marketplace.visualstudio.com/items?itemName=blaxou.freezed)は、Freezedを使用する際の作業効率を向上させるのに役立ちます。例えば、次のような機能があります。

- <kbd>Ctrl+Shift+B</kbd>（Macでは<kbd>Cmd+Shift+B</kbd>）を使用すると、`build_runner`で素早くビルドできます。
- <kbd>Ctrl+Shift+P</kbd>（Macでは<kbd>Cmd+Shift+P</kbd>）を使用して、`Generate Freezed class`を選択すると、Freezedクラスをすばやく生成できます。

### IntelliJとAndroid StudioのFreezed拡張機能

You can get Live Templates for boiler plate code [here](https://github.com/Tinhorn/freezed_intellij_live_templates).
IntelliJやAndroid Studioでは、[こちら](https://github.com/Tinhorn/freezed_intellij_live_templates)から定型コード用のライブテンプレートを入手できます。

例:

- **freezedClass**と入力して<kbd>Tab</kbd>を押すと、Freezed クラスが生成されます。
  ```dart
  @freezed
  class Demo with _$Demo {
  }
  ```
- **freezedFromJson**と入力して<kbd>Tab</kbd>を押すと、json_serializableのfromJsonが生成されます。
  ```dart
  factory Demo.fromJson(Map<String, dynamic> json) => _$DemoFromJson(json);
  ```

## サードパーティツール

ここでは、Freezedと連携するコミュニティ製ツールを紹介します。

### DartJ

[DartJ](https://dartj.web.app/#/)は、[**@ttpho**](https://github.com/ttpho)が作成したFlutterアプリケーションで、JSONペイロードからFreezedクラスを生成します。

例:

<https://github.com/ttpho/ttpho/assets/3994863/5d529258-c02c-4066-925e-ca2ffc68a804>

## スポンサー

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
