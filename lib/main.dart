import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.schedules})
      : super(key: key);

  final String title;
  final List<Map<String, String>> schedules;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.schedules.isEmpty
          ? Center(child: Text('There are no added schedules'))
          : ListView.builder(
              itemCount: widget.schedules.length,
              itemBuilder: (context, index) {
                final schedule = widget.schedules[index];
                // return a widget to display the schedule
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newSchedule = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewSchedulePage()),
          );
          if (newSchedule != null) {
            setState(() {
              widget.schedules.add(newSchedule);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Farm Scheduler Home Page', schedules: []),
    );
  }
}

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement the UI for displaying the current schedule
    return Center(child: Text('Current Schedule'));
  }
}

class NewSchedulePage extends StatefulWidget {
  @override
  _NewSchedulePageState createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  final _formKey = GlobalKey<FormState>();
  late String hour;
  late String minute;
  late String duration;
  late String area;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Hour',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => hour = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an hour';
                  }
                  final int? hour = int.tryParse(value);
                  if (hour == null || hour < 0 || hour > 23) {
                    return 'Please enter a valid hour (0-23)';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Minute',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => minute = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a minute';
                  }
                  final int? minute = int.tryParse(value);
                  if (minute == null || minute < 0 || minute > 59) {
                    return 'Please enter a valid minute (0-59)';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Duration',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => duration = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a duration';
                  }
                  final int? duration = int.tryParse(value);
                  if (duration == null || duration < 0 || duration > 60) {
                    return 'Please enter a valid duration (0-60)';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Area',
                ),
                items: ['1', '2', '3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onSaved: (value) => area = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an area';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context, {
                      'hour': hour,
                      'minute': minute,
                      'duration': duration,
                      'area': area
                    });
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WateringScheduleForm extends StatefulWidget {
  const WateringScheduleForm({Key? key, required this.area}) : super(key: key);

  final String area;

  @override
  _WateringScheduleFormState createState() => _WateringScheduleFormState();
}

class _WateringScheduleFormState extends State<WateringScheduleForm> {
  final _formKey = GlobalKey<FormState>();
  late String hour;
  late String minute;
  late String duration;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Hour',
            ),
            keyboardType: TextInputType.number,
            onSaved: (value) => hour = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an hour';
              }
              final int? hour = int.tryParse(value);
              if (hour == null || hour < 0 || hour > 23) {
                return 'Please enter a valid hour (0-23)';
              }
              return null;
            },
          ),
          // Other TextFormFields and widgets go here
        ],
      ),
    );
  }
}
