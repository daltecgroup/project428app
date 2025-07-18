import 'package:abg_pos_app/app/utils/helpers/logger_helper.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService extends GetxService {
  final _connectionChecker = InternetConnectionChecker.createInstance();
  final RxBool _isConnected = true.obs;

  RxBool get isConnected => _isConnected;

  @override
  void onInit() {
    super.onInit();
    _connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        LoggerHelper.logInfo('Connected to the internet');
        _isConnected.value = true;
      } else {
        LoggerHelper.logWarning('No internet connection');
        _isConnected.value = false;
      }
    });
    _initialCheck();
  }

  Future<void> _initialCheck() async {
    _isConnected.value = await _connectionChecker.hasConnection;
  }
}
