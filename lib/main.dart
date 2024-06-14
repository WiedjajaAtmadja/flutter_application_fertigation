import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Farm Scheduler Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const <Widget>[
            WateringScheduleForm(area: 'Area 1'),
            WateringScheduleForm(area: 'Area 2'),
            WateringScheduleForm(area: 'Area 3'),
          ],
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process the data
      print('Hour: $hour, Minute: $minute, Duration: $duration');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(widget.area,
                  style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
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
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a minute' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Duration',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => duration = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a duration' : null,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
