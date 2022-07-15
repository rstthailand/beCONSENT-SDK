library beconsent_sdk;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;
import 'package:beconsent_sdk/model/toggle_switch.dart';
import 'package:beconsent_sdk/model/Consent.dart';
import 'package:http/src/response.dart';
import 'package:beconsent_sdk/model/create_toggle.dart';
import 'package:http/http.dart' as http;

late Consent _ws;

press(var context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) => FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BeConsent();
          }
          return LinearProgressIndicator();
        }),
  );
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

  String Decline = 'Decline';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                child: Column(
              children: [
                Text(
                  _ws.title.th,
                  style: TextStyle(fontSize: 20, fontFamily: 'Kanit'),
                ),
                Text(_ws.description.th),
              ],
            )),
            Container(
              child: create_toggle(_ws),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => cancel(),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                    child: Text('$Decline'),
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
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                      child: Text("Accept All"))
                ],
              ),
            ),
          ],
        ));
  }

  void cancel() {
    print("press cancel");
    Navigator.of(context).pop();
  }

  void Accept() {
    print("press Accept");
    Navigator.of(context).pop();
  }
}

Future<Consent> getData() async {
  final url =
      Uri.parse("http://sit-consent.beconsent.tech:3003/api/v1/workspaces/1");
  var response = await http.get(url);
  print(response.body);
  _ws = consentFromJson(response.body);
  return _ws;
}
