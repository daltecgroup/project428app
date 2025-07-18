import 'package:intl/intl.dart';

String inRupiah(double number) {
  return 'Rp ${NumberFormat('#,##0.##', 'id_ID').format(number)}';
}

String inLocalNumber(double number) {
  return NumberFormat('#,##0.##', 'id_ID').format(number);
}
