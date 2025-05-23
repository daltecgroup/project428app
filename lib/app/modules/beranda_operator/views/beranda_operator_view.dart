import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/new_sales_view.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/select_menu_view.dart';
import 'package:project428app/app/modules/beranda_operator/views/widgets/closed_transaction_item_widget.dart';
import 'package:project428app/app/modules/beranda_operator/views/widgets/indicator_oder_done_widget.dart';
import 'package:project428app/app/modules/beranda_operator/views/widgets/operator_user_indicator_widget.dart';
import 'package:project428app/app/modules/beranda_operator/views/widgets/pending_transaction_item_widget.dart';
import 'package:project428app/app/widgets/operator/operator_appbar.dart';
import 'package:project428app/app/widgets/operator/operator_drawer.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../controllers/beranda_operator_controller.dart';

class BerandaOperatorView extends GetView<BerandaOperatorController> {
  const BerandaOperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OperatorAppBar(context, "Operator"),
      drawer: OperatorDrawer(context, kOperatorMenuBeranda),
      body: ListView(
        children: [
          Hero(
            tag: 'login-to-select-role',
            child: Card(
              color: Colors.white,
              elevation: 1,
              margin: EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'IDR 88.000',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            'Omzet Hari Ini',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      height: 65,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IndicatorOderDoneWidget(
                            position: 'left',
                            title: 'Order Selesai',
                            number: '2',
                          ),
                          IndicatorOderDoneWidget(
                            position: 'middle',
                            title: 'Order Pending',
                            number: '1',
                          ),
                          IndicatorOderDoneWidget(
                            position: 'right',
                            title: 'Item Terjual',
                            number: '34',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    OperatorUserIndicatorWidget(controller: controller),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          // pending transactions
          Card(
            color: Colors.white,
            elevation: 1,
            margin: EdgeInsets.symmetric(horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextTitle(text: 'Pending'),
                  SizedBox(height: 8),
                  PendingTransactionItemWidget(),
                  SizedBox(height: 8),
                  PendingTransactionItemWidget(),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          // closed transactions
          // pending transactions
          Card(
            color: Colors.white,
            elevation: 1,
            margin: EdgeInsets.symmetric(horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextTitle(text: 'Selesai'),
                  SizedBox(height: 8),
                  ClosedTransactionItemWidget(),
                  SizedBox(height: 8),
                  ClosedTransactionItemWidget(),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Get.to(() => SelectMenuView(), transition: Transition.rightToLeft);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
