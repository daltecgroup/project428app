import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:intl/intl.dart';

String inRupiah(double number) {
  return '${AppConstants.DEFAULT_CURRENCY_SYMBOL} ${NumberFormat('#,##0.##', 'id_ID').format(number)}';
}

String inLocalNumber(double number) {
  return NumberFormat('#,##0.###', 'id_ID').format(number);
}
