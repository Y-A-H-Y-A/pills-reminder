import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) =>
      Scaffold.of(context);
  // ..removeCurrentSnackBar()
  // ..showSnackBar(SnackBar(content: Text(text)));

  // static DateTime? toDateTime(Timestamp value) {
  //   if (value == null) return null;

  //   return value.toDate();
  // }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static toDateTime(json) {}
}
