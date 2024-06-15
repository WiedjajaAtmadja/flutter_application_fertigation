import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/schedule_provider.dart';
import '../models/schedule.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  int _area = 1;
  int _hour = 0;
  int _minute = 0;
  int _duration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Area'),
                value: _area,
                items: [1, 2, 3].map((area) {
                  return DropdownMenuItem(
                    value: area,
                    child: Text('Area $area'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _area = value as int;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an area';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hour'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _hour = int.parse(value!);
                },
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.parse(value) < 0 ||
                      int.parse(value) > 23) {
                    return 'Please enter a valid hour (0-23)';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Minute'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _minute = int.parse(value!);
                },
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.parse(value) < 0 ||
                      int.parse(value) > 59) {
                    return 'Please enter a valid minute (0-59)';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duration (minutes)'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _duration = int.parse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) <= 0) {
                    return 'Please enter a valid duration (greater than 0)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Provider.of<ScheduleProvider>(context, listen: false)
                        .addSchedule(
                      Schedule(
                          area: _area,
                          hour: _hour,
                          minute: _minute,
                          duration: _duration),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Schedule'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
