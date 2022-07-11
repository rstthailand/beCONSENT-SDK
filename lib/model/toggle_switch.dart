import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool check = false;

Widget Toggle_btn(String text, Function ChangeState) {
  return Padding(
    padding: const EdgeInsets.only(top: 22.0, left: 16.0, right: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        Spacer(),
        CupertinoSwitch(
            value: check,
            onChanged: (newValue) {
              ChangeState(newValue);
            },
            trackColor: Colors.grey,
            activeColor: Colors.blue)
      ],
    ),
  );
}
