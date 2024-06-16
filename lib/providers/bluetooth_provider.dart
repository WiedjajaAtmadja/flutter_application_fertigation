import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothProvider with ChangeNotifier {
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  BluetoothDevice? _connectedDevice;
  List<BluetoothService> _services = [];
  List<BluetoothDevice> _devices = [];

  BluetoothDevice? get connectedDevice => _connectedDevice;
  List<BluetoothService> get services => _services;
  List<BluetoothDevice> get devices => _devices;

  BluetoothProvider() {
    _flutterBlue.scanResults.listen((results) {
      _devices = results.map((r) => r.device).toList();
      notifyListeners();
    });
  }

  Future<void> requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();
  }

  Future<void> startScan() async {
    await requestPermissions();
    _flutterBlue.startScan(timeout: Duration(seconds: 4));
  }

  void stopScan() {
    _flutterBlue.stopScan();
  }

  void connect(BluetoothDevice device) async {
    await device.connect();
    _connectedDevice = device;
    _services = await device.discoverServices();
    notifyListeners();
  }

  void disconnect() async {
    await _connectedDevice?.disconnect();
    _connectedDevice = null;
    _services = [];
    notifyListeners();
  }
}
