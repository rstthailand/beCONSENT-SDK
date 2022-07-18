import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/Consent.dart';
import 'package:beconsent_sdk/model/record_consent.dart';
import 'package:beconsent_sdk/model/globals.dart' as global;

class create_toggle extends StatefulWidget {
  late Consent _c;
  create_toggle(Consent c) {
    _c = c;
  }
  @override
  State<StatefulWidget> createState() {
    return _create_toggleState(_c);
  }
}

class _create_toggleState extends State<create_toggle> {
  _create_toggleState(Consent c) {
    _c = c;
  }

  late Consent _c;
  late String lang = _c.defaultLanguage;
  bool val = false;

  add_index() {
    global.record.clear();
    for (var i in _c.purposes) {
      if (lang == 'th') {
        consent_record rec = consent_record(
            id: i.id,
            uuid: i.uuid,
            val: val,
            name: i.title.th,
            description: i.description.th);
        global.record.add(rec);
        global.Decline = "ปฏิเสธค่าที่ไม่จำเป็น";
        global.Accept = "ยอมรับทั้งหมด";
      } else {
        consent_record rec = consent_record(
            id: i.id,
            uuid: i.uuid,
            val: val,
            name: i.title.en,
            description: i.description.en);
        global.record.add(rec);
        global.Decline = "Decline";
        global.Accept = "Accept All";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    add_index();
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: global.record.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              title: Text(global.record[i].name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              subtitle: Text(global.record[i].description),
              trailing: CupertinoSwitch(
                  value: global.record[i].val,
                  onChanged: (newValue) {
                    setState(() {
                      global.record[i].val = newValue;
                    });
                  },
                  trackColor: Colors.grey,
                  activeColor: Colors.blue),
            ),
          );
        });
  }
}
