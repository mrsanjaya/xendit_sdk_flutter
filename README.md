
# Xendit SDK Unofficial

Ini bukan SDK Resmi

## Badges

[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)


## Installation

Install my-project with npm

```bash
  npm install my-project
  cd my-project
```
    
## Authors

- [@mrsanjaya](https://www.github.com/mrsanjaya)


## Roadmap

- Penambahan Kartu Kredit

- Penambahan Paylater

- Penambahan EWallet


## Usage/Examples

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:xendit_unofficial/xendit_unofficial.dart';

void main() {
  XenditSDK(apiKey: "").init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _platformVersion = 'Unknown';
  int saldo = 0;
  XenditQrisModel? xenditQrisModel;
  XenditVaModel? xenditVaModel;
  @override
  void initState() {
    super.initState();
  }

  void checkSaldo() async {
    String tmpsaldo = await XenditBalance().check();
    print("hit");
    print(tmpsaldo);
    setState(() {
      saldo = int.parse(tmpsaldo);
    });
  }

  void generateQrCode() async {
    XenditQRIS qris = XenditQRIS(
        external_id: "sjhdgfhjdsgf5",
        nominal: 1500,
        callback: "https://coba.com/callback");
    String qrStringTmp = await qris.generate();
    setState(() {
      xenditQrisModel = xenditQrisModelFromJson(qrStringTmp);
    });
  }

  void generateVA() async {
    XenditVA va = XenditVA(
        external_id: "demo-8", bank_code: XenditBankCode.BNI, name: "Rika");
    String vaTmp = await va.generate();
    setState(() {
      xenditVaModel = xenditVaModelFromJson(vaTmp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            InkWell(
              onTap: checkSaldo,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Cek Saldo",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Text("${saldo}"),
            InkWell(
              onTap: generateQrCode,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Generate QRIS",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Text("${jsonEncode(xenditQrisModel)}"),
            InkWell(
              onTap: generateVA,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Generate Virtual Code BNI",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Text("${jsonEncode(xenditVaModel)}")
          ],
        ),
      ),
    );
  }
}

```

