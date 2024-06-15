import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/schedule_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduler'),
      ),
      body: ListView.builder(
        itemCount: 3, // There are 3 areas
        itemBuilder: (context, index) {
          int area = index + 1;
          List schedules =
              scheduleProvider.schedules.where((s) => s.area == area).toList();

          return ExpansionTile(
            title: Text('Area $area'),
            children: schedules.map((schedule) {
              return ListTile(
                title: Text(
                    'Time: ${schedule.hour}:${schedule.minute}, Duration: ${schedule.duration} min'),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/input');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
