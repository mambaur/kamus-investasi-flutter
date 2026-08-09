## 1.0.9 (11)

* Menaikkan target Android ke API level 36 (Android 16) sesuai persyaratan Google Play
* Upgrade toolchain Android: Gradle 8.14.3, Android Gradle Plugin 8.13.0, Kotlin 2.2.20
* Menghapus package `clipboard` (tidak terawat, masih compileSdk 33 sehingga build gagal) dan
  menggantinya dengan `Clipboard` bawaan Flutter
* Memperbaiki constraint Dart SDK di `pubspec.yaml` agar cocok dengan Flutter/Dart terpasang

## 1.0.8 (10)

* Memperbaiki issue admob: Modified ad code: Resizing Ad Frames

## 1.0.7 (9)

* Memperbaiki issue admob: Modified ad code: Resizing Ad Frames

## 1.0.6 (7)

* Menghapus interstitial ad di halaman detail dictionary

## 1.0.5 (6)

* Menghapus halaman feedback
* Upgrade dependency/package
* Improve banner placement