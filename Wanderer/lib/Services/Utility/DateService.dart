import 'dart:core';

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

extension DateExtension on DateTime {
  bool isSameDay(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  bool isSameYear(DateTime other) {
    return this.year == other.year;
  }

  bool isSameMonth(DateTime other) {
    return this.year == other.year && this.month == other.month;
  }

  String monthDayPostFix() {
    switch (this.day) {
      case 1:
        return "st";
        break;
      case 2:
        return "nd";
        break;
      default:
        return "th";
    }
  }

  String humanReadableDate() {
    var currentDate = DateTime.now();
    if (this.isSameDay(currentDate)) {
      //today
      return "Today at ${formatDate(this, [HH, ':', nn])}";
    } else if (this.isSameDay(currentDate.add(Duration(days: 1)))) {
      //tomorrow
      return "Tomorrow at ${formatDate(this, [HH, ':', nn])}";
    } else if (this.compareTo(currentDate) > 0 &&
        this.compareTo(currentDate.add(Duration(days: 7))) < 0) {
      //coming up this week
      return "Next ${formatDate(this, [DD])}" +
          " at ${formatDate(this, [HH, ':', nn])}";
    } else if (this.isSameYear(currentDate)) {
      //same year
      return "${formatDate(this, [MM])} ${this.day}${this.monthDayPostFix()}" +
          " at ${formatDate(this, [HH, ':', nn])}";
    } else {
      //full date
      return "${formatDate(this, [MM])}" +
          " ${this.day}${this.monthDayPostFix()} ${this.year}" +
          " at ${formatDate(this, [HH, ':', nn])}";
    }
  }
}
