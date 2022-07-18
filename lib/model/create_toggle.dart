import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/toggle_switch.dart';
import 'package:beconsent_sdk/model/Consent.dart';
import 'package:beconsent_sdk/model/record_consent.dart';

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
  List<consent_record> record = [];
  var consent = [];
  var description = [];
  late String lang = _c.defaultLanguage;
  bool val = false;

  add_index() {
    if (!record.isEmpty) {
      for (var i in record) {
        print('${i.val} ${i.name} ');
      }
    } else {
      for (var i in _c.purposes) {
        for (var k in i.purposeCategories) {
          if (lang == 'th') {
            consent_record rec = consent_record(
                id: k.id,
                uuid: k.uuid,
                val: val,
                name: k.name.th,
                description: k.description.th);
            record.add(rec);
          } else {
            consent_record rec = consent_record(
                id: k.id,
                uuid: k.uuid,
                val: val,
                name: k.name.en,
                description: k.description.en);
            record.add(rec);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    add_index();
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: record.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              title: Text(record[i].name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              subtitle: Text(record[i].description),
              trailing: CupertinoSwitch(
                  value: record[i].val,
                  onChanged: (newValue) {
                    setState(() {
                      record[i].val = newValue;
                    });
                  },
                  trackColor: Colors.grey,
                  activeColor: Colors.blue),
            ),
          );
        });
  }
}
