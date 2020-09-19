BASEDIR=$(dirname "$0")

cd $BASEDIR/../packages/freezed_annotation

echo "Installing freezed_annotation"
dart pub get

cd ../freezed

echo "overriding freezed dependencies"
echo "
dependency_overrides:
  freezed_annotation:
    path: ../freezed_annotation" >> pubspec.yaml

echo "Installing freezed"
dart pub get
