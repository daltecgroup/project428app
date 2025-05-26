import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/new_sales_view.dart';
import 'package:project428app/app/services/operator_service.dart';

class PendingTransactionItemWidget extends StatelessWidget {
  const PendingTransactionItemWidget({super.key, required this.pendingSales});

  final PendingSales pendingSales;

  @override
  Widget build(BuildContext context) {
    OperatorService OperatorS = Get.find<OperatorService>();
    return Stack(
      children: [
        Card(
          color: Colors.amber[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: EdgeInsets.all(0),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              pendingSales.trxCode,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            '10.11 - Jeremy Harris',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'IDR 17.000',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '1 Item',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.end,
                        runSpacing: 5,
                        spacing: 5,

                        children: [
                          Badge(
                            backgroundColor: Colors.brown[500],
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            label: Text('Coklat Keju (2)'),
                          ),
                          Badge(
                            backgroundColor: Colors.brown[500],
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            label: Text('Mozarella (1)'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onTap: () {
                OperatorS.currentPendingTrxCode.value = pendingSales.trxCode;
                Get.to(() => NewSalesView());
              },
            ),
          ),
        ),
      ],
    );
  }
}
