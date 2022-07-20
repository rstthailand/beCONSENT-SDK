library beconsent_sdk;

import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;
import 'package:beconsent_sdk/model/Consent.dart';
import 'package:beconsent_sdk/model/create_toggle.dart';
import 'package:beconsent_sdk/model/record_consent.dart';
import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/globals.dart' as global;

late Consent _ws;

Future getData(String url) async {
  final url = Uri.parse(global.Url);
  var response = await http.get(url);
  print(response.body);
  _ws = consentFromJson(response.body);
}

init(String url, String name, String uid) {
  global.Url = url;
  global.Name = name;
  global.uid = uid;
  getData(global.Url);
  if(_ws.defaultLanguage == "th"){
    global.title = _ws.title.th;
    global.description = _ws.description.th;
    global.Decline = "ปฏิเสธค่าที่ไม่จำเป็น";
    global.Accept = "ยอมรับทั้งหมด";
  }
  else{
    global.title = _ws.title.en;
    global.description = _ws.description.en;
    global.Decline = "Decline Addition";
    global.Accept = "Accept All";
  }
}

press(var context) {
  return showDialog(
    context: context,
    builder: (context) => FutureBuilder(
        future: getData(global.Url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BeConsent();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
  );
}

popup_show(BuildContext context) {
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
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
                global.title,
                style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
                textAlign: TextAlign.center,
              ),
              Text(global.description)
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
    print("press Accept");
    response.AcceptAllConsent(_ws);
    Navigator.of(context).pop();
  }
}
