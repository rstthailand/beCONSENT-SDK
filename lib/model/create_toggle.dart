import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/toggle_switch.dart';
import 'package:beconsent_sdk/model/Consent.dart';

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
  var consent = [];
  var description = [];
  late String lang = _c.defaultLanguage;
  bool val = false;

  add_index() {
    for (var i in _c.purposes) {
      for (var k in i.purposeCategories) {
        if (lang == 'th') {
          consent.add(k.name.th);
          description.add(k.description.th);
        } else {
          consent.add(k.name.en);
          description.add(k.description.en);
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
        itemCount: consent.length,
        itemBuilder: (context, i) {
          return toggle_switch(consent[i],description[i]);
        });
  }
}
