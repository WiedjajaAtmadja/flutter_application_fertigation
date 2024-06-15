import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/schedule_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<ScheduleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Scheduler', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: ListView.builder(
        itemCount: 3, // There are 3 areas
        itemBuilder: (context, index) {
          int area = index + 1;
          List schedules =
              scheduleProvider.schedules.where((s) => s.area == area).toList();

          return Card(
            margin: EdgeInsets.all(12.0),
            color: Theme.of(context).cardColor.withOpacity(0.7),
            child: ExpansionTile(
              backgroundColor: Theme.of(context).cardColor,
              title: Text('Area $area',
                  style: Theme.of(context).textTheme.headlineSmall),
              children: schedules.map((schedule) {
                return ListTile(
                  title: Text(
                    'Time: ${schedule.hour}:${schedule.minute}, Duration: ${schedule.duration} min',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }).toList(),
            ),
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
