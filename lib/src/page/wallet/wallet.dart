import 'dart:io';

import 'package:blue/src/api/klaytn.dart';
import 'package:blue/src/api/klip.dart';
import 'package:blue/src/helper.dart';
import 'package:blue/src/service/klaytn_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

// reference: https://github.com/kws1207/flutter_klip_wallet
// total balance and operations not currently working

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  KlipApi klipApi = KlipApi();
  KlaytnApi klaytnApi = KlaytnApi();
  int balance = 100;

  @override
  void initState() {
    // TODO: implement initState
    klipApi.initKlipApi();
    super.initState();
  }

  void getKlipAddress() {
    if (klipApi.getUserKlipAddress.isEmpty) {
      if (Platform.isAndroid) {
        klipApi.createIntent().whenComplete(
            () => klipApi.getKlipAddress().whenComplete(() => setState(() {})));
      } else {
        klipApi.createDeepLink().whenComplete(
            () => klipApi.getKlipAddress().whenComplete(() => setState(() {})));
      }
    }
  }

  void getBalance() async {
    if (klipApi.getUserKlipAddress.isNotEmpty) {
      await klaytnApi.getBalance(klipApi.getUserKlipAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(klipApi.getRequestKey),
                    Text(klipApi.getUserKlipAddress),
                    Text(klipApi.priceKlay.toString()),
                    Text(balance.toString()),
                    Container(
                        height: 56.0,
                        child: OutlinedButton(
                            onPressed: getKlipAddress,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff216FEA)),
                              foregroundColor: MaterialStateProperty.all(
                                Color(0xffffffff),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.all(kDefaultPadding / 2),
                                    child: SvgPicture.asset(
                                      'assets/logos/klip_logo.svg',
                                      height: 18.0,
                                      fit: BoxFit.fitWidth,
                                    )),
                                Text(
                                  "Klip으로 시작",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ))),
                    OutlinedButton(
                        onPressed: getBalance, child: Text("getBalance"))
                  ],
                ))));
  }
}
