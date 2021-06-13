# simple_property_observer
プロパティの変更を監視可能にする、シンプルな Dart パッケージです。
PropertyChangedNotifier としても知られているパターンを利用しています。

# 使い方
このリポジトリは、`simple_property_observer` と `simple_property_observer_builder` という2つのパッケージから構成されています。
これらのパッケージは、Flutter だけではなく純粋な Dart プロジェクトでも利用可能です。
`example` ディレクトリには、これらのパッケージの簡単な利用例があります。

## 依存関係の設定
`pubspec.yaml` に以下の設定を記述してください。

```yaml
dependencies:
  simple_property_observer: any

dev_dependencies:
  build_runner: any
  simple_property_observer_builder: any
```

`simple_property_observer` にはプロパティ監視パターンや、自動生成アノテーション（メタデータ）の定義が含まれています。

`simple_property_observer_builder` には自動生成のためのコマンドラインツールが含まれています。

## クラス定義の方法
たとえば、以下のようなメタデータ付きのクラスを定義してください。

```Dart
import 'package:simple_property_observer/simple_property_observer.dart';

part 'example.g.dart';

@propertyObservable
class Example {
  @observable
  String? get observableProperty => null;
}
```

Dart Analysis がエラーを指摘すると思いますが、ここでは無視して次のステップへ進んでください。

#### ポイント
- プロパティ監視パターン自動生成のため、**クラス**に対して `@propertyObservable` を付与してください。
- **プロパティのgetter**を定義して `@observable` を付与してください。
- 自動生成ファイルに対する `part` 文を記述してください。

その後、以下のビルドコマンドを Terminal から実行してください。

```bash
$ flutter packages pub run build_runner build
```

純粋な Dart プロジェクトを作っている場合は、代わりに以下のコマンドを実行してください。

```bash
$ dart run build_runner build
```

処理が終わった後、`example.g.dart` というファイルが生成されているはずです。

```Dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// PropertyObservableGenerator
// **************************************************************************

mixin _ObservableMembers on PropertyObservable {
  String? __observableProperty;
  set observableProperty(String? value) {
    if (__observableProperty == value) {
      return;
    }
    final oldValue = __observableProperty;
    __observableProperty = value;
    notifyPropertyChanged(PropertyChangedInfo(
        'observableProperty', oldValue, __observableProperty));
  }
}
```

#### ポイント
この後、`example.dart` を以下のように修正する必要があります。

```Dart
import 'package:simple_property_observer/simple_property_observer.dart';

part 'example.g.dart';

@propertyObservable
class Example with PropertyObservable, _ObservableMembers {
  @observable
  String? get observableProperty => __observableProperty;
}
```

`with PropertyObservable, _ObservableMembers` を加えて、getter の参照先を `null` から `__observableProperty` に変更しました。

## インスタンスを監視する
`registerObserver` メソッドを使って、プロパティの変更を監視できます。

```Dart
import 'example.dart';

void main() {
  final example = Example();

  // Observe property changes
  example.registerObserver((info) {
    print('${info.name} changed: from ${info.oldValue} to ${info.newValue}');
  });

  print('set Apple');
  example.observableProperty = 'Apple';

  print('set Banana');
  example.observableProperty = 'Banana';

  // Shows the output below:
  // set Apple
  // observableProperty changed: from null to Apple
  // set Banana
  // observableProperty changed: from Apple to Banana
}
```

また、`unregisterObserver` メソッドを使って、プロパティの変更監視を中止することができます。
これを行わないと参照を保持し続けることになるため、通知が不要になったら必ず呼ぶべきです。
