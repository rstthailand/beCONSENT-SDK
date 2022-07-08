library beconsent_sdk;

import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;

Widget buildSheet() => Column(
      children: [
        Container(
          child: Text(
            'BeConsent',
            style: TextStyle(fontSize: 20),
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
                child: Text('Decline'),
              ),
              SizedBox(width: 20,),
              ElevatedButton(
                  onPressed: () => Accept(),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  child: Text("Accept All"))
            ],
          ),
        )
      ],
    );

void Accept() {
  print("press Accept");
}

void cancel() {
  print("press cancel");
}
