# PDFTron Flutter Sample
Flutter sample project that integrates a document viewer using PDFTron Flutter.

PDFTron's Flutter PDF library now supports sound null safety and is available on [GitHub](https://github.com/PDFTron/pdftron-flutter) and [pub.dev](https://pub.dev/packages/pdftron_flutter). To learn how to add PDFTron to your Flutter App, check out the [integration guides](https://www.pdftron.com/documentation/guides/flutter).  

## Preview

**Android** |  **iOS**
:--:|:--:
<img alt='demo-android' src='assets/gifs/android.gif' height="600" /> | <img alt='demo-android' src='assets/gifs/ios.gif' height="600" />

## Installation

### Android
1. Create a `local.properties` file inside the android folder with your Android SDK location, for example:

```
sdk.dir=/Users/<user-name>/Library/Android/sdk
```

### iOS
1. For iOS, run:
```
cd ios
pod install
```

## Run

### Sample App

```
flutter run
```

### Test

```
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```

## Upgrade

For updating flutter projects, please check out [Upgrading Flutter](https://flutter.dev/docs/development/tools/sdk/upgrading).

## License
See [License](./LICENSE)
![](https://onepixel.pdftron.com/flutter-sample)
