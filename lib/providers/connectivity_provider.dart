import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:floward_task/enums/connectivity_status.dart';
import 'package:floward_task/services/connectivity_service.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  bool isConnected = false;

  Future<void> init() async {
    ConnectivityStatus status = ConnectivityService()
        .getStatusFromResult(await Connectivity().checkConnectivity());
    log('Connection Init');
    switch (status) {
      case ConnectivityStatus.wifi:
      case ConnectivityStatus.cellular:
        isConnected = true;
        break;
      case ConnectivityStatus.offline:
        isConnected = false;
        break;
    }
    log('Connection Status -> $isConnected');
    ConnectivityService().connectionStatusController.stream.listen((status) {
      switch (status) {
        case ConnectivityStatus.wifi:
        case ConnectivityStatus.cellular:
          isConnected = true;
          break;
        case ConnectivityStatus.offline:
          isConnected = false;
          break;
      }
      log('Connection Status -> $isConnected');
      notifyListeners();
    });
  }
}
