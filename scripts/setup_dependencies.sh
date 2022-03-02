BASEDIR=$(dirname "$0")

cd $BASEDIR/../packages/freezed_annotation

echo "Installing freezed_annotation"
dart pub get

cd ../freezed

echo "overriding freezed dependencies"
if grep -Fxq "dependency_overrides:" pubspec.yaml
then
echo "
  freezed_annotation:
    path: ../freezed_annotation" >> pubspec.yaml
else
echo "
dependency_overrides:
  freezed_annotation:
    path: ../freezed_annotation" >> pubspec.yaml
fi

echo "Installing freezed"
dart pub get
