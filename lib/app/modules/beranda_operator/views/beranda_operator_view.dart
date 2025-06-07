import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/modules/beranda_operator/views/pages/select_menu_view.dart';
import 'package:project428app/app/modules/beranda_operator/views/widgets/closed_transaction_item_widget.dart';
import 'package:project428app/app/modules/beranda_operator/views/widgets/indicator_oder_done_widget.dart';
import 'package:project428app/app/modules/beranda_operator/views/widgets/operator_user_indicator_widget.dart';
import 'package:project428app/app/modules/beranda_operator/views/widgets/pending_transaction_item_widget.dart';
import 'package:project428app/app/shared/widgets/operator/operator_appbar.dart';
import 'package:project428app/app/shared/widgets/operator/operator_drawer.dart';
import 'package:project428app/app/shared/widgets/text_header.dart';
import '../controllers/beranda_operator_controller.dart';

class BerandaOperatorView extends GetView<BerandaOperatorController> {
  const BerandaOperatorView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.OperatorS.getTodaySalesByOutlet();
    controller.OperatorS.refreshSalesIndicator();
    return Obx(
      () => Scaffold(
        appBar: OperatorAppBar(
          context,
          controller.OperatorS.currentOutletName.isEmpty
              ? "Operator"
              : controller.OperatorS.currentOutletName.value,
        ),
        drawer: OperatorDrawer(context, kOperatorMenuBeranda),
        body: RefreshIndicator(
          onRefresh: () {
            return controller.OperatorS.getTodaySalesByOutlet();
          },
          child: ListView(
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
                                  controller.OperatorS.todayIncome.value == 0
                                      ? "IDR 0"
                                      : "IDR ${NumberFormat("#,##0", "id_ID").format(controller.OperatorS.todayIncome.value)}",
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
                                title: 'Order Pending',
                                number:
                                    controller.OperatorS.pendingOrder.value
                                        .toString(),
                              ),
                              IndicatorOderDoneWidget(
                                position: 'middle',
                                title: 'Order Selesai',
                                number:
                                    controller.OperatorS.orderDone.value
                                        .toString(),
                              ),
                              IndicatorOderDoneWidget(
                                position: 'right',
                                title: 'Item Terjual',
                                number:
                                    controller.OperatorS.itemSold.value
                                        .toString(),
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
              controller.OperatorS.pendingSales.isEmpty
                  ? SizedBox()
                  : Card(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextTitle(text: 'Pending'),
                          SizedBox(height: 8),
                          ...List.generate(
                            controller.OperatorS.pendingSales.length,
                            (index) => Column(
                              children: [
                                PendingTransactionItemWidget(
                                  pendingSales:
                                      controller.OperatorS.pendingSales[index],
                                ),
                                SizedBox(
                                  height:
                                      index ==
                                              controller
                                                      .OperatorS
                                                      .pendingSales
                                                      .length -
                                                  1
                                          ? 0
                                          : 8,
                                ),
                              ],
                            ),
                          ),
                          // PendingTransactionItemWidget(),
                        ],
                      ),
                    ),
                  ),
              controller.OperatorS.pendingSales.isEmpty
                  ? SizedBox()
                  : SizedBox(height: 20),

              // closed transactions
              controller.OperatorS.closedSales.isEmpty
                  ? SizedBox()
                  : Card(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextTitle(text: 'Selesai'),
                          SizedBox(height: 8),

                          controller.OperatorS.closedSales.isEmpty
                              ? SizedBox()
                              : Column(
                                children: List.generate(
                                  controller.OperatorS.closedSales.length,
                                  (index) => Column(
                                    children: [
                                      ClosedTransactionItemWidget(
                                        sale:
                                            controller
                                                .OperatorS
                                                .closedSales[index],
                                      ),
                                      index ==
                                              controller
                                                      .OperatorS
                                                      .closedSales
                                                      .length -
                                                  1
                                          ? SizedBox()
                                          : SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
              SizedBox(height: 50),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            controller.OperatorS.getLatestProducts().then(
              (_) => Get.to(
                () => SelectMenuView(),
                transition: Transition.rightToLeft,
                arguments: 'homepage',
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
