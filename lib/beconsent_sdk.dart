library beconsent_sdk;

import 'package:beconsent_sdk/model/record_consent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;
import 'package:beconsent_sdk/model/Consent.dart';
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
                      global.Save = "บันทึกค่าที่เลือก";
                      // check_prime(_ws);
                      // global.havePrime
                      //     ? global.Decline = "ปฏิเสธค่าที่ไม่จำเป็น"
                      //     : global.Decline = "ปฏิเสธ";
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
  String lang = _ws.defaultLanguage;
  bool val = false;

  add_index() {
    int count = 0;
    int normal = 0;
    if (global.record.isNotEmpty) {
    } else {
      for (var i in _ws.purposes) {
        if (i.primary == true) {
          if (lang == 'th') {
            consent_record rec = consent_record(
                id: i.id,
                uuid: i.uuid,
                val: true,
                name: i.title.th,
                description: i.description.th,
                primary: i.primary,
                isSelected: false);
            global.c.add(i.primary);
            setState(() {
              global.Decline = "ปฏิเสธค่าที่ไม่จำเป็น";
            });
          } else {
            consent_record rec = consent_record(
                id: i.id,
                uuid: i.uuid,
                val: true,
                name: i.title.en,
                description: i.description.en,
                primary: i.primary,
                isSelected: false);
            global.record.add(rec);
            global.Decline = "Decline Additions";
            // global.Accept = "Accept All";
          }
        } else {
          if (lang == 'th') {
            consent_record rec = consent_record(
                id: i.id,
                uuid: i.uuid,
                val: val,
                name: i.title.th,
                description: i.description.th,
                primary: i.primary,
                isSelected: false);
            global.c.add(i.primary);
            global.record.add(rec);
            global.Decline = "ปฏิเสธ";
            // global.Accept = "ยอมรับทั้งหมด";
          } else {
            consent_record rec = consent_record(
                id: i.id,
                uuid: i.uuid,
                val: val,
                name: i.title.en,
                description: i.description.en,
                primary: i.primary,
                isSelected: false);
            global.c.add(i.primary);
            global.record.add(rec);
            // global.Decline = "Decline";
            // global.Accept = "Accept All";
          }
        }
      }
    }
  }

  @override
  void initState() {
    getData(global.Url);
    add_index();
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
                              )),
                        ]),
                      )),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Accept All",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      trailing: CupertinoSwitch(
                          value: global.accept_all,
                          onChanged: (newValue) {
                            setState(() {
                              global.accept_all = newValue;
                              check_true();
                            });
                          },
                          trackColor: Colors.grey,
                          activeColor: Colors.blue),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: global.record.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              title: Text(global.record[i].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              subtitle: global.record[i].isSelected
                                  ? Text(global.record[i].description)
                                  : null,
                              trailing: CupertinoSwitch(
                                  value: global.accept_all
                                      ? global.accept_all
                                      : global.record[i].val,
                                  onChanged: global.record[i].primary
                                      ? null
                                      : (newValue) {
                                          setState(() {
                                            global.record[i].val = newValue;
                                            check_true();
                                            // global.toggle_true = newValue;
                                          });
                                        },
                                  trackColor: Colors.grey,
                                  activeColor: Colors.blue),
                              onTap: () {
                                setState(() {
                                  if (global.record[i].isSelected == false) {
                                    global.record[i].isSelected = true;
                                  } else {
                                    global.record[i].isSelected = false;
                                  }
                                });
                              },
                            ),
                          );
                        }),
                    // child: create_toggle(_ws),
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
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))),
                                child: Text(
                                  global.Decline,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )),
                            ElevatedButton(
                                onPressed: global.check ? () => save() : null,
                                style: ButtonStyle(
                                    backgroundColor: global.check
                                        ? MaterialStateProperty.all(Colors.blue)
                                        : MaterialStateProperty.all(
                                            Color.fromARGB(255, 189, 189, 189)),
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

void check_true() {
  int count = 0;
  for (var i in global.record) {
    if (i.val == true && i.primary == false) {
      count++;
    }
  }
  if (count > 0) {
    global.check = true;
  }
  if (count == 0) {
    global.check = false;
  }
  global.accept_all
  ? global.check = true
  : global.check = false;
}
