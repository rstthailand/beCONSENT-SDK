import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:beconsent_sdk/model/toggle_switch.dart';
import 'package:beconsent_sdk/model/getWorkspace.dart';

class create_toggle extends StatefulWidget {
  late GetWorkspace _ws;
  create_toggle(GetWorkspace ws) {
    _ws = ws;
  }
  @override
  State<StatefulWidget> createState() {
    return _create_toggleState(_ws);
  }
}

class _create_toggleState extends State<create_toggle> {
  _create_toggleState(GetWorkspace ws) {
    _ws = ws;
  }

  late GetWorkspace _ws;
  var consent = ['consent1', 'consent2'];
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: consent.length,
      itemBuilder: (context, i){
        return toggle_switch('txt');
      });
  }
}
