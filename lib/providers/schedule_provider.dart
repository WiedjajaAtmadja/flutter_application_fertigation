import 'package:flutter/material.dart';
import '../models/schedule.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> _schedules = [];

  List<Schedule> get schedules => _schedules;

  void addSchedule(Schedule schedule) {
    _schedules.add(schedule);
    notifyListeners();
  }
}
