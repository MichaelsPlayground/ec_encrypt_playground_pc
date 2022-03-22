import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'storage.dart';

class EcP256KeyGenerationRoute extends StatefulWidget {
  const EcP256KeyGenerationRoute({Key? key}) : super(key: key);

  final String title = 'EC Schlüsselerzeugung';

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<EcP256KeyGenerationRoute> {
  @override
  void initState() {
    super.initState();
    descriptionController.text = txtDescription;
    setState(() {
      state = '';
      statePriKey = '';
      statePubKey = '';
    });
  }

  final _formKey = GlobalKey<FormState>();
  String state = '';
  String statePriKey = '';
  String statePubKey = '';
  TextEditingController privateKeyController = TextEditingController();
  TextEditingController publicKeyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final BEGIN_PRIVATE_KEY = '-----BEGIN PRIVATE KEY-----';
  final END_PRIVATE_KEY = '-----END PRIVATE KEY-----';
  final BEGIN_PUBLIC_KEY = '-----BEGIN PUBLIC KEY-----';
  final END_PUBLIC_KEY = '-----END PUBLIC KEY-----';

  String privateKeyAfterGeneration = '';
  String publicKeyAfterGeneration = '';

  String txtDescription =
      'Erzeugung eines EC Schlüsselpaares der Kurve P-256.'
      ' Das Schlüsselpaar kann lokal gespeichert werden.';

  Future<bool> _fileExistsPrivateKey() async {
    bool ergebnis = false;
    await Storage().filePrivateKeyExists().then((bool value) {
      setState(() {
        state = '';
        if (value == true) {
          privateKeyController.text = 'Datei existiert ';
        } else {
          privateKeyController.text = 'Datei existiert NICHT';
        }
        ergebnis = value;
      });
    });
    return ergebnis;
  }

  Future<bool> _fileExistsPublicKey() async {
    bool ergebnis = false;
    await Storage().filePublicKeyExists().then((bool value) {
      setState(() {
        state = '';
        if (value == true) {
          publicKeyController.text = 'Datei existiert ';
        } else {
          publicKeyController.text = 'Datei existiert NICHT';
        }
        ergebnis = value;
      });
    });
    return ergebnis;
  }

  Future<File> _writeDataPrivateKey() async {
    setState(() {
      statePriKey = privateKeyAfterGeneration;
    });
    return Storage().writeDataPrivateKey(statePriKey);
  }

  Future<File> _writeDataPublicKey() async {
    setState(() {
      statePubKey = publicKeyAfterGeneration;
    });
    return Storage().writeDataPublicKey(statePubKey);
  }

  Future<void> _readDataPrivateKey() async {
    Storage().readDataPrivateKey().then((String value) {
      setState(() {
        statePriKey = value;
        privateKeyAfterGeneration = '';
        privateKeyController.text = value;
      });
    });
  }

  Future<void> _readDataPublicKey() async {
    Storage().readDataPublicKey().then((String value) {
      setState(() {
        statePubKey = value;
        publicKeyAfterGeneration = '';
        publicKeyController.text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //SizedBox(height: 20),
                // form description
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  enabled: false,
                  // false = disabled, true = enabled
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Beschreibung',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),
                // private key
                TextFormField(
                  controller: privateKeyController,
                  maxLines: 4,
                  maxLength: 2000,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  //enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Privater Schlüssel',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte den Schlüssel laden oder erzeugen';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final data =
                            ClipboardData(text: privateKeyController.text);
                            await Clipboard.setData(data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: const Text(
                                    'Privaten Schlüssel in die Zwischenablage kopiert'),
                              ),
                            );
                          } else {
                            print("Formular ist nicht gültig");
                          }
                        },
                        child: Text('Schlüssel in die Zwischenablage kopieren'),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                // public key
                TextFormField(
                  controller: publicKeyController,
                  maxLines: 4,
                  maxLength: 600,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  // enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Öffentlicher Schlüssel',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bitte den Schlüssel laden oder erzeugen';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final data =
                            ClipboardData(text: publicKeyController.text);
                            await Clipboard.setData(data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: const Text(
                                    'Öffentlichen Schlüssel in die Zwischenablage kopiert'),
                              ),
                            );
                          } else {
                            print("Formular ist nicht gültig");
                          }
                        },
                        child: Text('Schlüssel in die Zwischenablage kopieren'),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          bool priKeyFileExists =
                          await _fileExistsPrivateKey() as bool;
                          bool pubKeyFileExists =
                          await _fileExistsPublicKey() as bool;
                          if (priKeyFileExists && pubKeyFileExists) {
                            await _readDataPrivateKey();
                            await _readDataPublicKey();
                          }
                        },
                        child: Text('lokal laden'),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          // generate an EC key pair from curve P256
                          AsymmetricKeyPair keyPair = CryptoUtils.generateEcKeyPair(curve: 'prime256v1');
                          ECPrivateKey privateKey = keyPair.privateKey as ECPrivateKey;
                          final privateKeyPem = CryptoUtils.encodeEcPrivateKeyToPem(privateKey);
                          ECPublicKey publicKey = keyPair.publicKey as ECPublicKey;
                          final publicKeyPem = CryptoUtils.encodeEcPublicKeyToPem(publicKey);
                          privateKeyAfterGeneration = privateKeyPem;
                          publicKeyAfterGeneration = publicKeyPem;
                          privateKeyController.text = privateKeyPem;
                          publicKeyController.text = publicKeyPem;
                        },
                        child: Text('erzeugen'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          privateKeyAfterGeneration = '';
                          publicKeyAfterGeneration = '';
                          privateKeyController.text = '';
                          publicKeyController.text = '';
                          //_formKey.currentState!.reset();
                        },
                        child: Text('Formulardaten löschen'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          if (privateKeyAfterGeneration != '' &&
                              publicKeyAfterGeneration != '') {
                            // stores data from privateKeyAfterGeneration and
                            // publicKeyAfterGeneration
                            await _writeDataPrivateKey();
                            await _writeDataPublicKey();
                            await ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                    'Privaten und Öffentlichen Schlüssel lokal gespeichert'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(
                                    'Keinen Schlüssel lokal gespeichert, bitte erst neu erzeugen.'),
                              ),
                            );
                          }
                        },
                        child: Text('Schlüssel lokal speichern'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String base64Encoding(Uint8List input) {
    return base64.encode(input);
  }

  ///
  /// Splits the given String [s] in chunks with the given [chunkSize].
  ///
  static List<String> chunk(String s, int chunkSize) {
    var chunked = <String>[];
    for (var i = 0; i < s.length; i += chunkSize) {
      var end = (i + chunkSize < s.length) ? i + chunkSize : s.length;
      chunked.add(s.substring(i, end));
    }
    return chunked;
  }
}
