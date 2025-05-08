import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SetUpWifiPrinter {
  static final SetUpWifiPrinter _instance = SetUpWifiPrinter._internal();

  late CapabilityProfile _profile;
  late NetworkPrinter _printer;
  bool isConnected = false;

  factory SetUpWifiPrinter() {
    return _instance;
  }

  SetUpWifiPrinter._internal();

  Future<void> connectWifiPrinter({String ip = ""}) async {
    if (isConnected) return; // Prevent multiple connections
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _profile = await CapabilityProfile.load();
    _printer = NetworkPrinter(PaperSize.mm80, _profile);

    if (ip.isEmpty) {
      ip = prefs.getString("ip") ?? "192.168.0.108";
    }
    final connect = await _printer.connect(ip, port: 9100);

    if (connect == PosPrintResult.success) {
      isConnected = true;
    }
  }

  Future<void> disconnectWifiPrinter() async {
    printer.disconnect();
    isConnected = false;
  }

  NetworkPrinter get printer => _printer;
  CapabilityProfile get profile => _profile;
}
