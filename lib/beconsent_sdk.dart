library beconsent_sdk;

import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;

Widget buildSheet() => Column(
      children: [
        Text(
          'BeConsent',
          style: TextStyle(fontSize: 16),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Accept(),
                child: Text('Accept All'),
              ),
              ElevatedButton(onPressed: () => cancel(),
               child: Text("Deceli"))
            ],
          ),
        )
      ],
    );

void Accept(){
  print("press Accept");
}

void cancel(){
  print("press cancel");
}