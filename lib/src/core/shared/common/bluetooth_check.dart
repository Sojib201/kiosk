// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class BluetoothCheck {
//   static final BluetoothCheck _instance = BluetoothCheck._internal();
//
//   // Factory constructor to return the singleton instance
//   factory BluetoothCheck() {
//     return _instance;
//   }
//
//   // Private constructor
//   BluetoothCheck._internal();
//   static bool isBluetoothDeviceConnected = false;
//   static bool isBluetoothOn = false;
//
//   static BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
//   Stream<int?> myStream = bluetooth.onStateChanged();
//
//   // Stream<int?> myStream2 = bluetooth.onStateChanged();
//   final ValueNotifier<Map<String, dynamic>> blueStatusCode = ValueNotifier<Map<String, dynamic>>({"isBluetooth": false, "isBluetoothDevice": false});
//   Future<void> getPrevConnectionStatus() async {
//     isBluetoothOn = await bluetooth.isOn ?? false;
//     isBluetoothDeviceConnected = await bluetooth.isConnected ?? false;
//   }
//   void runBluetoothStream() {
//     myStream.listen((event) {
//       if (event == 0) {
//         isBluetoothDeviceConnected = false;
//         Fluttertoast.showToast(
//           msg: "Bluetooth Printer Disconnected",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.TOP,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//       }
//       if (event == 1) {
//         isBluetoothDeviceConnected = true;
//         Fluttertoast.showToast(
//           msg: "Bluetooth Printer Connected",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.TOP,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//       }
//       if (event == 10) {
//         isBluetoothOn = false;
//         Fluttertoast.showToast(
//           msg: "Bluetooth status off",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.TOP,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//       }
//       // if(event==11)
//       //   {
//       //     getConnectivityStatus();
//       //   }
//       if (event == 12) {
//         isBluetoothOn = true;
//       }
//
//       debugPrint("Device Connected $isBluetoothDeviceConnected");
//       debugPrint("Blue Connected $isBluetoothOn");
//       blueStatusCode.value = {"isBluetooth": isBluetoothOn, "isBluetoothDevice": isBluetoothDeviceConnected};
//     });
//   }
//
//   Future<void> setCurrentBluetoothStatus() async {
//     isBluetoothDeviceConnected = await bluetooth.isConnected ?? false;
//     isBluetoothOn = await bluetooth.isOn ?? false;
//   }
//
// // bool isModem = false;
// // List<BluetoothDevice> devices = [];
// // BluetoothDevice? selectedDevice;
// // static bool  isBluetoothDeviceConnected = false;
// // static bool isBluetoothOn = false;
//
// // Future<bool> isBluetoothDeviceCurrentlyConnected()
// // async {
// //    isBluetoothDeviceConnected = await bluetooth.isConnected??false;
// //    isBluetoothOn = await bluetooth.isOn??false;
// //   return isBluetoothDeviceConnected;
// // }
// //
// // String connectedDeviceName = "";
// // bool isDeviceConnected1 =false;
// //
// //
// // static bool isPrinterDeviceConnected = false;
// // static bool isBluetoothOn = false;
// // Singleton instance
// // static final BluetoothCheck _instance = _internal();
//
// // _internal();
//
// // Future<void> initializeBluetooth() async {
// //   // Check if the Bluetooth printer is available
// //   bool isAvailable = await bluetooth.isAvailable ?? false;
// //   if (!(await bluetooth.isOn ?? false)) {
// //      isBluetoothDeviceConnected = false;
// //
// //     Fluttertoast.showToast(
// //       msg: "Please turn on your bluetooth",
// //       toastLength: Toast.LENGTH_SHORT,
// //       gravity: ToastGravity.TOP,
// //       backgroundColor: Colors.red,
// //       textColor: Colors.white,
// //       fontSize: 16.0,
// //     );
// //
// //   }
// //   if (isAvailable) {
// //     // Get list of bonded devices (paired devices)
// //     devices = await bluetooth.getBondedDevices();
// //     await isDeviceConnected();
// //   }
// //
// //   setState(() {});
// // }
//
// // factory BluetoothCheck() {
// //   return _instance;
// // }
//
// // void runStream() {
// //   myStream.listen((event) async {
// //     print("skjdflksdjfk");
// //     print("Bluetooth State Changed manual print : $event");
// //
// //     if (event == 1) {
// //       isPrinterDeviceConnected = true;
// //       Fluttertoast.showToast(
// //         msg: "Printer Disconnected",
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.TOP,
// //         backgroundColor: Colors.blue,
// //         textColor: Colors.white,
// //         fontSize: 16.0,
// //       );
// //     } else if (event == 0) {
// //       isPrinterDeviceConnected = false;
// //       Fluttertoast.showToast(
// //         msg: "Printer Connected",
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.TOP,
// //         backgroundColor: Colors.blue,
// //         textColor: Colors.white,
// //         fontSize: 16.0,
// //       );
// //     } else if (event == 10) {
// //       isBluetoothOn = false;
// //     } else if (event == 12) {
// //       isBluetoothOn = true;
// //       devices = await bluetooth.getBondedDevices();
// //       print("dvc:");
// //       print(devices.toString());
// //     }
// //
// //     print("Device status: $isPrinterDeviceConnected");
// //     print("Bluetooth status: $isBluetoothOn");
// //   });
// // }
// //   void disconnectFromDevice() async {
// //     await bluetooth.disconnect();
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     prefs.setString('connectedDeviceName', "");
// //     prefs.setBool('isConnected', false);
// //   }
// //
// //   void connectToDevice(BluetoothDevice device) async {
// //     await bluetooth.connect(device).onError(
// //             (error, stackTrace) => (error, stackTrace) => Fluttertoast.showToast(
// //           msg: "Try Again!",
// //           toastLength: Toast.LENGTH_SHORT,
// //           gravity: ToastGravity.TOP,
// //           backgroundColor: Colors.red,
// //           textColor: Colors.white,
// //           fontSize: 16.0,
// //         ));
// //     if (await bluetooth.isConnected ?? false) {
// //       SharedPreferences prefs = await SharedPreferences.getInstance();
// //       prefs.setString('connectedDeviceName', device.name ?? "");
// //       prefs.setBool('isConnected', true);
// //       print(prefs.getBool('isConnected'));
// //        isBluetoothDeviceConnected = await bluetooth.isConnected??false;
// //       selectedDevice = device;
// //     } else {
// //       Fluttertoast.showToast(
// //         msg: "Try Again!",
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.TOP,
// //         backgroundColor: Colors.red,
// //         textColor: Colors.white,
// //         fontSize: 16.0,
// //       );
// //     }
// //   }
// //
// }