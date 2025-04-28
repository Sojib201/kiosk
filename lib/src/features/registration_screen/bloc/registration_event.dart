import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {}

class RegistrationPerform extends RegistrationEvent {
  final String cid;
  final String branchId;
  final String deviceId;
  final String deviceName;
  final String deviceType;
  final String appVersion;
  final String osVersion;
  final String ipAddress;
  final String macAddress;
  final String deviceToken;

  RegistrationPerform({required this.cid, required this.branchId, required this.deviceId, required this.deviceName, required this.deviceType, required this.appVersion, required this.osVersion, required this.ipAddress, required this.macAddress, required this.deviceToken});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
