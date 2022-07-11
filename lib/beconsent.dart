import 'package:beconsent_sdk/beconsent_sdk.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:beconsent_sdk/model/beconsent_info.dart' as response;

press (var context) async {
    int? code = await response.beconsent_api().getData();
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20)
          )
      ),
      context: context,
      builder: (context) => sdk.BeConsent(),
    );
  }