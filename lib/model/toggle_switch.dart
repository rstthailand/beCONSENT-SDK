import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Toggle_btn(String text, bool val, Function ChangeState) {
  return Padding(
    padding: const EdgeInsets.only(top: 22.0, left: 16.0, right: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        Spacer(),
        CupertinoSwitch(
            value: val,
            onChanged: (newValue) {
              ChangeState(newValue);
            },
            trackColor: Colors.grey,
            activeColor: Colors.blue)
      ],
    ),
  );
}
