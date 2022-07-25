<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## การติดตั้ง sdk 

นำ code ชุดนี้ไปไว้ในไฟล์ pubspec.yaml

```
beconsent_sdk:
    git:
      url: https://github.com/RealRavip/beconsent-sdk
```
ตัวอย่าง

```
dependencies:
  flutter:
    sdk: flutter
  beconsent_sdk:
    git:
      url: https://github.com/RealRavip/beconsent-sdk
      
```

จากนั้นเรียกใช้คำสั่ง

```
flutter pub get
```
## การใชังาน

นำเข้า package
```
import 'package:beconsent_sdk/beconsent_sdk.dart' as sdk;
```

เรียกใช้คำสั่ง
```
sdk.init("<URL>",
      "<Name>",
      "<UID>");
      
sdk.popup_show(context);
```

ตัวอย่าง
```
void main() {
sdk.init("<URL>",
      "<Name>",
      "<UID>");
runApp(const MyApp());
      }
.
.
.
Widget build(BuildContext context) {      
sdk.popup_show(context);
return ...
}
```

sdk.init ใช้ในการดึงข้อมูลจาก API และ set ชื่อกับUID ในการส่งข้อมูล.

sdk.popup_show ใช้เรียก BeConsent Dialog ตอน run application.
