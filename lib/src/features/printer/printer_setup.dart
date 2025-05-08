// import 'dart:developer';
// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:kiosk/src/features/printer/set_up_wifi_printer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../core/shared/common/bluetooth_check.dart';
// import '../../core/utils/color_utils.dart';
// import '../../core/utils/style.dart';
//
// class SetupPrinter extends StatefulWidget {
//
//
//
//   const SetupPrinter({Key? key}) : super(key: key);
//
//   @override
//   State<SetupPrinter> createState() => _SetupPrinterState();
//
// }
//
// class _SetupPrinterState extends State<SetupPrinter> {
//   // BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
//   List<BluetoothDevice> blueDevices = [];
//   BluetoothDevice? selectedBlueDevice;
//   String connectedBlueDeviceName = "Select Printer";
//   bool isWifiPrinterConnected = false;
//   // var profile;
//   // var printer;
//
//   //
//   TextEditingController ipTextController = TextEditingController();
//   final SetUpWifiPrinter wifiPrinter = SetUpWifiPrinter();
//
//   //
//
//   @override
//   void initState() {
//
//     // TODO: implement initState
//     super.initState();
//     initializeBluetooth();
//     getConnectivityStatus();
//   }
//
//   Future<void> getConnectivityStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (BluetoothCheck.isBluetoothOn) {
//       if (BluetoothCheck.isBluetoothDeviceConnected) {
//         connectedBlueDeviceName = prefs.getString('connectedDeviceName') ?? "";
//         setState(() {});
//       }
//     }
//
//     if (prefs.getBool("isWifiConnected") ?? false) {
//       try {
//         await wifiPrinter.connectWifiPrinter();
//         if (wifiPrinter.isConnected) {
//           ipTextController.text = prefs.getString("ip") ?? "";
//           setState(() {});
//         }
//       } catch (e) {
//         log(e.toString());
//       }
//     }
//   }
//
//   Future<void> initializeBluetooth() async {
//     blueDevices = await BluetoothCheck.bluetooth.getBondedDevices();
//     print(blueDevices.toList().toString());
//     setState(() {});
//   }
//
//   Future<void> saveBlueConnectivityDataToLocal(
//       BluetoothDevice blueToothDevice) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool("isConnected", true);
//     prefs.setString("connectedDeviceName", blueToothDevice.name.toString());
//     prefs.setString(
//         "connectedDeviceAddress", blueToothDevice.address.toString());
//
//     log(prefs.getString("connectedDeviceName").toString());
//     log(prefs.getBool("isConnected").toString());
//     log(blueToothDevice.toMap().toString());
//
//   }
//
//   Future<void> saveWifiConnectivityDataToLocal(String wifiPrinterIp) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (wifiPrinterIp == "") {
//       prefs.setBool("isWifiConnected", false);
//       prefs.setString("ip", wifiPrinterIp);
//       ipTextController.clear();
//       Fluttertoast.showToast(
//         msg: "Wifi Printer Disconnected!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.TOP,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } else {
//       prefs.setBool("isWifiConnected", true);
//       prefs.setString("ip", wifiPrinterIp);
//       Fluttertoast.showToast(
//         msg: "Wifi Printer Connected!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.TOP,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }
//
//   // Future<void> saveConnectivityDataToLocal(
//   //     BluetoothDevice blueToothDevice) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setBool("isConnected", true);
//   //   prefs.setString("connectedDeviceName", blueToothDevice.name.toString());
//   //   prefs.setString(
//   //       "connectedDeviceAddress", blueToothDevice.address.toString());
//   // }
//
//   // Connect to the selected Bluetooth device
//   Future<void> connectToDevice(BluetoothDevice device) async {
//
//     try{
//       await BluetoothCheck.bluetooth.disconnect();
//     }
//     catch(e){
//
//     }
//     try{
//       await BluetoothCheck.bluetooth.connect(device);
//       saveBlueConnectivityDataToLocal(device);
//     }
//     catch(e){
//
//     }
//
//     // await BluetoothCheck.bluetooth
//     //     .disconnect()
//     //     .onError((error, stackTrace) async => await BluetoothCheck.bluetooth
//     //         .connect(device)
//     //         .onError((error, stackTrace) =>
//     //             (error, stackTrace) => Fluttertoast.showToast(
//     //                   msg: "Try Again!",
//     //                   toastLength: Toast.LENGTH_SHORT,
//     //                   gravity: ToastGravity.TOP,
//     //                   backgroundColor: Colors.red,
//     //                   textColor: Colors.white,
//     //                   fontSize: 16.0,
//     //                 ))
//     //         .then((value) => saveBlueConnectivityDataToLocal(device)))
//     //     .then((value) async => await BluetoothCheck.bluetooth
//     //         .connect(device)
//     //         .onError((error, stackTrace) =>
//     //             (error, stackTrace) => Fluttertoast.showToast(
//     //                   msg: "Try Again!",
//     //                   toastLength: Toast.LENGTH_SHORT,
//     //                   gravity: ToastGravity.TOP,
//     //                   backgroundColor: Colors.red,
//     //                   textColor: Colors.white,
//     //                   fontSize: 16.0,
//     //                 ))
//     //         .then((value) => saveBlueConnectivityDataToLocal(device)));
//   }
//
//   void disconnectFromDevice() async {
//     if (BluetoothCheck.isBluetoothDeviceConnected) {
//       print("printer device is connected");
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
//       try {
//        await BluetoothCheck.bluetooth.disconnect();
//         print("then function");
//         prefs.setString('connectedDeviceName', "");
//         prefs.setString('connectedDeviceAddress', "");
//         prefs.setBool('isConnected', false);
//         print("from disconnect");
//         log(prefs.getString("connectedDeviceName").toString());
//         log(prefs.getBool("isConnected").toString());
//         setState(() {
//           selectedBlueDevice = null;
//         });
//       }
//       catch (e) {
//
//         prefs.setString('connectedDeviceName', "");
//         prefs.setString('connectedDeviceAddress', "");
//         prefs.setBool('isConnected', false);
//
//         print("from else");
//         log(prefs.getString("connectedDeviceName").toString());
//         log(prefs.getBool("isConnected").toString());
//
//         setState(() {
//           selectedBlueDevice = null;
//         });
//       }
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme _textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//
//       appBar: AppBar(
//         title: Text("Printer Setup"),
//         centerTitle: true,
//         backgroundColor: ColorUtils.backGroundColor,
//         foregroundColor: Colors.white,
//       ),
//
//       body: Center(
//         child: Container(
//           height: 400.h,
//           width: 1500.w,
//          decoration: BoxDecoration(
//            color: ColorUtils.backGroundColor,
//            borderRadius: BorderRadius.circular(16)
//          ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Wifi Printers :",
//                     style: MyStyle.heading1,
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   SizedBox(
//                     width: 200,
//                     child: TextField(
//                       style: MyStyle.heading1,
//                       textAlign: TextAlign.center,
//                       controller: ipTextController,
//
//                       decoration: const InputDecoration(
//                         hintText: "Wifi Printer IP",
//                         hintStyle: TextStyle(color: Colors.white),
//                         filled: false,
//                         enabledBorder: UnderlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.white, width: 2)),
//                         border: UnderlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.white, width: 2)),
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.white, width: 2)),
//                       ),
//                     ),
//                   ),
//                   wifiPrinter.isConnected
//                       ? ElevatedButton(
//                           onPressed: () async {
//                             wifiPrinter.disconnectWifiPrinter();
//                             await saveWifiConnectivityDataToLocal("");
//                             setState(() {});
//                           },
//                           child: const Text("Disconnect"))
//                       : ElevatedButton(
//                           onPressed: () async {
//                             if (ipTextController.text.isEmpty) {
//                               Fluttertoast.showToast(
//                                   msg: "Please Enter wifi printer IP",
//                                   backgroundColor: Colors.red);
//                               return;
//                             }
//                             await wifiPrinter.connectWifiPrinter(
//                                 ip: ipTextController.text.toString());
//                             if (wifiPrinter.isConnected) {
//                               wifiPrinter.printer.text(
//                                   "Device Connected Successfully",
//                                   styles: PosStyles(align: PosAlign.center));
//                               wifiPrinter.printer.cut();
//                               await saveWifiConnectivityDataToLocal(
//                                   ipTextController.text.toString());
//                               setState(() {});
//                             } else if (!wifiPrinter.isConnected) {
//                               Fluttertoast.showToast(
//                                   msg: "Failed!Check IP and try again",
//                                   backgroundColor: Colors.red);
//                             }
//                           },
//                           child: const Text("Connect")),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               ValueListenableBuilder<Map?>(
//                   valueListenable: BluetoothCheck().blueStatusCode,
//                   builder: (context, value, child) {
//                     print(
//                         "blu device conncted ${BluetoothCheck.isBluetoothDeviceConnected}");
//                     print(
//                         "blu feature connected ${BluetoothCheck.isBluetoothOn}");
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Bluetooth Printers :",
//                           style: MyStyle.heading1,
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         InkWell(
//                           onTap: () async {
//                             if (!BluetoothCheck.isBluetoothOn) {
//                               Fluttertoast.showToast(
//                                 msg: "Please turn on your bluetooth",
//                                 toastLength: Toast.LENGTH_SHORT,
//                                 gravity: ToastGravity.TOP,
//                                 backgroundColor: Colors.red,
//                                 textColor: Colors.white,
//                                 fontSize: 16.0,
//                               );
//                             } else {
//                               await initializeBluetooth();
//                             }
//                           },
//                           child: DropdownButton<BluetoothDevice>(
//                             dropdownColor: ColorUtils.secondaryColor,
//                             onTap: () async {
//                               if (!BluetoothCheck.isBluetoothOn) {
//                                 Fluttertoast.showToast(
//                                   msg: "Please turn on your bluetooth",
//                                   toastLength: Toast.LENGTH_SHORT,
//                                   gravity: ToastGravity.TOP,
//                                   backgroundColor: Colors.red,
//                                   textColor: Colors.white,
//                                   fontSize: 16.0,
//                                 );
//                               } else {
//                                 await initializeBluetooth();
//                               }
//                             },
//                             hint: Text(
//                               BluetoothCheck.isBluetoothDeviceConnected
//                                   ? connectedBlueDeviceName
//                                   : "Select Printer",
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                             value: selectedBlueDevice,
//                             items: blueDevices.map((device) {
//                               return DropdownMenuItem(
//                                 child: Text(
//                                   device.name ?? "Unknown device",
//                                   style: const TextStyle(color: Colors.white),
//                                 ),
//                                 value: device,
//                               );
//                             }).toList(),
//                             onChanged: (device) async {
//                               if (BluetoothCheck.isBluetoothDeviceConnected) {
//                                 Fluttertoast.showToast(
//                                   msg: "Please Disconnect First!",
//                                   toastLength: Toast.LENGTH_SHORT,
//                                   gravity: ToastGravity.TOP,
//                                   backgroundColor: Colors.red,
//                                   textColor: Colors.white,
//                                   fontSize: 16.0,
//                                 );
//                               } else {
//                                 setState(() {
//                                   selectedBlueDevice = device;
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         ElevatedButton(
//                           onPressed: selectedBlueDevice != null
//                               ? () async {
//                                   if (BluetoothCheck.isBluetoothOn) {
//                                     if (!BluetoothCheck
//                                         .isBluetoothDeviceConnected) {
//                                       // if (await bluetooth.isConnected ?? false) {
//                                       //   await bluetooth.disconnect();
//                                       // }
//                                     await  connectToDevice(selectedBlueDevice!);
//                                     } else {
//                                       Fluttertoast.showToast(
//                                         msg:
//                                             "${selectedBlueDevice!.name} is already Connected",
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.TOP,
//                                         backgroundColor: Colors.red,
//                                         textColor: Colors.white,
//                                         fontSize: 16.0,
//                                       );
//                                     }
//                                   } else {
//                                     Fluttertoast.showToast(
//                                       msg: "Turn on your bluetooth",
//                                       toastLength: Toast.LENGTH_SHORT,
//                                       gravity: ToastGravity.TOP,
//                                       backgroundColor: Colors.red,
//                                       textColor: Colors.white,
//                                       fontSize: 16.0,
//                                     );
//                                   }
//                                 }
//                               : null,
//                           child: Text(
//                               BluetoothCheck.isBluetoothDeviceConnected &&
//                                       BluetoothCheck.isBluetoothOn
//                                   ? "Connected"
//                                   : "Connect",
//                               style: const TextStyle(color: Colors.black)),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                        BluetoothCheck.isBluetoothDeviceConnected ?  ElevatedButton(
//                           onPressed:(){
//                     disconnectFromDevice();
//                           },
//
//
//                           child: const Text("Disconnect"),
//                         ):Text(""),
//                       ],
//                     );
//
//                     // }
//                     // else {
//                     //   return const Text("Error!Please Turn On Your Bluetooth and Try Again",style: TextStyle(color: Colors.white),);
//                     // }
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
