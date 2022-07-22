library beconsent_sdk;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;
import 'package:beconsent_sdk/model/Consent.dart';
import 'package:beconsent_sdk/model/create_toggle.dart';
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
}

press(var context) {
  return showDialog(
    context: context,
    builder: (context) => BeConsent(),
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
                    if (_ws.defaultLanguage == "th") {
                      global.title = _ws.title.th;
                      global.description = _ws.description.th;
                      global.Accept = "ยอมรับทั้งหมด";
                      global.Save = "บันทึกค่าที่เลือก";
                      check_prime(_ws);
                      global.havePrime
                          ? global.Decline = "ปฏิเสธค่าที่ไม่จำเป็น"
                          : global.Decline = "ปฏิเสธ";
                    } else {
                      global.title = _ws.title.en;
                      global.description = _ws.description.en;
                    }
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(children: [
                          Text(
                            global.title,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Kanit',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(
                                child: Text(
                                  global.description,
                                  style: TextStyle(
                                    fontFamily: 'Kanit',
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ]),
                      )),
                  SingleChildScrollView(
                    child: Container(
                        color: Colors.white,
                        height: 350,
                        child: SingleChildScrollView(
                          child: Column(
                          children: [
                            ListTile(
                              title: Text("Accept All",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              trailing: CupertinoSwitch(
                                  value: global.accept_all,
                                  onChanged: (newValue) {
                                    setState(() {
                                      global.accept_all = newValue;
                                    });
                                  },
                                  trackColor: Colors.grey,
                                  activeColor: Colors.blue),
                            ),
                            SingleChildScrollView(
                            child: create_toggle(_ws)),
                          ],
                        ))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () => cancel(),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 189, 189, 189)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))),
                                child: Text(
                                  global.Decline,
                                  style: TextStyle(fontSize: 16),
                                )),
                            ElevatedButton(
                                onPressed: () => save(),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))),
                                child: Text(
                                  global.Save,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )),
                            ElevatedButton(
                                onPressed: () => Accept(),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))),
                                child: Text(
                                  global.Accept,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ))
                          ],
                        ),
                      ))
                ],
              )),
        ));
  }

  void cancel() {
    print("press cancel");
    response.cancelConsent(_ws);
    Navigator.of(context).pop();
  }

  void save() {
    print("save");
    response.saveConsent(_ws);
    Navigator.of(context).pop();
  }

  void Accept() {
    print("press Accept");
    response.AcceptAllConsent(_ws);
    Navigator.of(context).pop();
  }
}

void check_prime(var _ws) {
  for (var i in _ws.purposes) {
    if (i.primary == true) {
      global.havePrime = true;
    }
  }
}
