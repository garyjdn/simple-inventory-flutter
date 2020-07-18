import 'package:flutter/material.dart';
export './validator.dart';
export './http_request.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class Helpers {
  static String formatDateUtil(String date) {
    return formatDate(DateTime.parse(date),
        [dd, ' ', M, ' ', yyyy, ',', HH, ':', nn, ' ', am]);
  }

  static Color hexToColor(String stringhex) {
    return Color(int.parse(stringhex.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String validateNumber(String value) {
    var re = new RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$');
    if (value.length <= 0) {
      return 'Please Input Weight';
    } else if (!re.hasMatch(value)) {
      return 'Please Input Right Format';
    }
    return null;
  }
}