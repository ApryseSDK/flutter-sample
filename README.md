# PDFTron Flutter Sample
Flutter sample project that integrates a document viewer using [PDFTron Flutter](https://github.com/PDFTron/pdftron-flutter). Check out the [integration guides](https://www.pdftron.com/documentation/android/guides/flutter) to learn how to add PDFTron to your Flutter App.

## Preparation

### Android
Add your [AWS credentials](https://www.pdftron.com/documentation/android/guides/getting-started/integrate-gradle) to the gradle.properties file:
```
AWS_ACCESS_KEY=YOUR_ACCESS_KEY_GOES_HERE
AWS_SECRET_KEY=YOUR_SECRET_KEY_GOES_HERE
```
Your AWS credentials are confidential. Please make sure that they are not publicly available.

### iOS
Add your [pod link](https://www.pdftron.com/documentation/ios/guides/getting-started/integrate-cocoapods) to the Podfile:
```
target 'Runner' do
  # PDFTron Pods
  use_frameworks!
  pod 'PDFNet', podspec: 'POD_LINK_GOES_HERE'
end
```

Your pod link is confidential. Please make sure that they are not publicly available.

## Run

```
flutter run
```


## License
See [License](./LICENSE)
