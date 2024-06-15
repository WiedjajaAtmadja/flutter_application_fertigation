import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> schedules = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(title: 'Home Page', schedules: schedules),
    );
  }
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
  List<Map<String, String>> schedules = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: schedules.isEmpty
          ? Center(child: Text('There are no added schedules'))
          : ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return Card(
                  // Add this
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Add this
                  ),
                  child: ListTile(
                    title: Text(schedules[index]
                        .entries
                        .map((e) => '${e.key}: ${e.value}')
                        .join(', ')),
                  ),
                );
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
              schedules.add(newSchedule);
            });
          }
        },
        child: Icon(Icons.add),
      ),
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
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
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15), // Add this
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
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
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15), // Add this
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
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
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Area',
                    ),
                    items: ['1', '2', '3'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Add your logic here
                    },
                    onSaved: (value) => area = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an area';
                      }
                      return null;
                    }),
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
