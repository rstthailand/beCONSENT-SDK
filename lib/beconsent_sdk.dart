library beconsent_sdk;

import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;
import 'package:beconsent_sdk/model/Consent.dart';
import 'package:beconsent_sdk/model/create_toggle.dart';
import 'package:beconsent_sdk/model/record_consent.dart';
import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/globals.dart' as global;

late Consent _ws;

press(var context, String url) {
  global.Url = url;
  return showDialog(
            context: context,
            builder: (context) => FutureBuilder(
                future: getData(global.Url),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return BeConsent();
                  }
                  return LinearProgressIndicator();
                }),
          );
}


popup_show(BuildContext context, String url) {
  global.Url = url;
  Future.delayed(
      Duration.zero,
      () => showDialog(
            context: context,
            builder: (context) => FutureBuilder(
                future: getData(global.Url),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return BeConsent();
                  }
                  return LinearProgressIndicator();
                }),
          ));
}

class BeConsent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BeConsentState();
  }
}

class _BeConsentState extends State<BeConsent> {
  late Future<String?> code;
  String? label = "";

  @override
  void initState() {
    getData(global.Url);
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SingleChildScrollView(
      child: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Column(children: [
              Text(
                _ws.title.th,
                style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
                textAlign: TextAlign.center,
              ),
              Text(_ws.description.th)
            ]),
          ),
          SingleChildScrollView(
            child: Container(
              height: 500,
              child: create_toggle(_ws),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => cancel(),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  child: Text(global.Decline),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () => Accept(),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                    child: Text(global.Accept))
              ],
            ),
          )
        ],
      )),
    ));
    
  }

  void cancel() {
    print("press cancel");
    response.cancelConsent(_ws);
    Navigator.of(context).pop();
  }

  void Accept() {
    for (var i in global.record) {
      if (i.val == true) {}
    }
    print("press Accept");
    Navigator.of(context).pop();
  }
}

Future<Consent> getData(String url) async {
  final url = Uri.parse(global.Url);
  var response = await http.get(url);
  print(response.body);
  _ws = consentFromJson(response.body);
  return _ws;
}
