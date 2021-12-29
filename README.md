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
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEICuBx3EABrYE2PS1PjVI8AUlgLo6P1HW9DN3JpZp8vGQoAoGCCqGSM49
AwEHoUQDQgAEaxfR8uEsQkf4vOblY6RA8ncDfYEt6zOg9KE5RdiYwpZP40Li/hp/
m47n60p8D54WK84zV2sxXs7LtkBoN79R9Q==
-----END EC PRIVATE KEY-----
```

```plaintext
-----BEGIN EC PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAESYkCeCKg/FUxlAehp/Oo6rp528TU
yK/p2To10FhCiIRuq4ZHq/3FVoqOlECkhgfMsxjOyGh9Wb+tv+tZEs5CRQ==
-----END EC PUBLIC KEY-----
```

Klartext:
```plaintext
Meine geheime Nachricht
```

Sample ECDSA SHA-256 signature:
```plaintext
{
  "algorithm": "ECDSA P256 SHA256",
  "plaintext": "TWVpbmUgZ2VoZWltZSBOYWNocmljaHQ=",
  "signature": "XZvsbEIpNKQYx0TDZQOyl8PR0817uos6bEUihSAU8IWQ5hsB2AfH/sWGIVEiDG/AZOU3E/KAKrPlS6WcEOe0ow=="
}
```

Sample ECDSA SHA-1 signature:
```plaintext
{
  "algorithm": "ECDSA P256 SHA1",
  "plaintext": "TWVpbmUgZ2VoZWltZSBOYWNocmljaHQ=",
  "signature": "iNsDwFzpU6C8c6eX79SIdSOvOChRyJ3bBRsLSNMA6lAUQAAAtnbNYLhmjFw+JBND+nc/ofryltRQikWMUNf9dw=="
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
