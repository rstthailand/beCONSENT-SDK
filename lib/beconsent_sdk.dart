library beconsent_sdk;

import 'package:flutter/material.dart';

Widget PbuildSheet() => Column(
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
                onPressed: () {},
                child: Text('Accept All'),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Deceli"))
            ],
          ),
        )
      ],
    );
