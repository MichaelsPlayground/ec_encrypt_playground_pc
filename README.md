# ec_encrypt_playground_pc

EC signature and verification

```plaintext
https://pub.dev/packages/pointycastle
https://github.com/bcgit/pc-dart/
pointycastle: ^3.4.0

https://pub.dev/packages/basic_utils
https://github.com/Ephenodrom/Dart-Basic-Utils
basic_utils: ^3.9.4

https://pub.dev/packages/url_launcher
url_launcher: ^6.0.12

https://pub.dev/packages/path_provider
path_provider: ^2.0.5

in AndroidManifest.xml ergänzen:

    <queries>
        <!-- If your app opens https URLs -->
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="https" />
        </intent>
    </queries>
```    

```plaintext
-----BEGIN PRIVATE KEY-----

-----END PRIVATE KEY-----
```

```plaintext
-----BEGIN PUBLIC KEY-----

-----END PUBLIC KEY-----
```

Klartext:
```plaintext
The quick brown fox jumps over the lazy dog
```

Sample RSA PSS signature:
```plaintext
{
  "algorithm": "RSA-2048 PSS",
  "plaintext": "VGhlIHF1aWNrIGJyb3duIGZveCBqdW1wcyBvdmVyIHRoZSBsYXp5IGRvZw==",
  "signature": "3oUlHXG8Yd9Ew1ByxVfi20Kez6JI/cZ4HjhiB3bBYihrPRpfmwy7pVmhz+4lM8KvEoO+7mnLiF/F2/7+z/UOdqoT35Axry6eHzo8IxHZAxWbO84UV0pbNtJ0PYfXT5fx4Pc47M5AogjBy452ct5MujsM8/Vq+Zc0fbVCsYDgQslmjl0HZK3I4XDuMKRn5Td4WZA9ojmHySJXs3yAibYt9O41jGp1np/PqMzkUPjm/F7O9YrP+xZ+xX0YdAUJ+KXRO+/fxTi9/U3WRsou7WJt7kQNRoMfhHH6UOKVLQu67g1X/tN3fy43rKg7ZfG1k0PBJh032NoHbpi7Nx8FirVqNg=="
}
```

Sample PKCS 1.5 signature:
```plaintext
{
  "algorithm": "RSA-2048 PKCS 1.5",
  "plaintext": "VGhlIHF1aWNrIGJyb3duIGZveCBqdW1wcyBvdmVyIHRoZSBsYXp5IGRvZw==",
  "signature": "abTQ5OdbJlzEz59/sagMjYhXXNZbEX6QJk/Thw8BrFjbTIwvluM/nwiOAN3Kx10p0mlbhVd4iMmN8L+0EPmN0y35/cVTs7Mp7h2QqHWiGMhgf9o/7/oi1Os6/zLPn/UyhpxtGPRUzcj92HrhM804pvAkpq85LcZOkSWyyL8KWnlJL7a6HyAugez+bJFiTAu5woTs3nXTk8GpGGVRwDyB49pYCRBk3G9oym0k8Hur2NthavWjg1xEgN48EGWNKih0uIvFvHBAwyEUpqqrgMVBCjx51caeXma/ID8pvFEgxZXDro7h39xnxLKXHrmWV9Sd6WheolmjbizLvw0b0yp6gw=="
}
```

```plaintext
/Users/michaelfehr/flutter/bin/flutter pub global activate rename
/Users/michaelfehr/flutter/bin/flutter pub global run rename --bundleId de.fluttercrypto.ec_signature_pc
/Users/michaelfehr/flutter/bin/flutter pub global run rename --appname "EC signature and verification"
```

development environment:
```plaintext
Android Studio Arctic Fox Version 2020.3.1 Patch 3
Build #AI-203.7717.56.2031.7784292
Runtime version: 11.0.10+0-b96-7249189 aarch64
VM: OpenJDK 64-Bit Server VM
Flutter 2.5.3 channel stable Framework Revision 18116933e7
Dart 2.14.4
```

tested on:
```plaintext
Android Simulator: 
  Android 11 (SDK 30) Emulator,
  Android 12 SV2 (SDK 31) Emulator, 
  Android 6 (SDK 23) Emulator,
  Android 5 (SDK 21) Emulator.
iOS Simulator:  
  iOS 15 Emulator
  iOS 11.4 Emulator 
```


```plaintext
/Users/michaelfehr/flutter/bin/flutter clean


```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
