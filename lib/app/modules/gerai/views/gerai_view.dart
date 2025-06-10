import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/modules/gerai/views/widgets/add_outlet_view.dart';
import 'package:project428app/app/modules/gerai/views/widgets/outlet_item.dart';
import 'package:project428app/app/shared/widgets/text_header.dart';

import '../../../core/constants/constants.dart';
import '../../../style.dart';
import '../../../shared/widgets/admin/admin_appbar.dart';
import '../../../shared/widgets/admin/admin_drawer.dart';
import '../controllers/gerai_controller.dart';

class GeraiView extends GetView<GeraiController> {
  const GeraiView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.OutletS.getOutletList();
    return Scaffold(
      appBar: AdminAppBar(context, "Gerai", null),
      drawer: AdminDrawer(context, kAdminMenuGerai),
      body: Obx(
        () =>
            controller.OutletS.outletList.isEmpty
                ? Center(child: TextTitle(text: 'Gerai Kosong'))
                : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(8),
                        child: TextField(
                          decoration: MyTextFieldInputDecoration(
                            'Cari Gerai',
                            Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                              controller.OutletS.getAllRegencyOfOutletList()
                                  .length,
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextTitle(
                                    text:
                                        controller
                                                .OutletS.getAllRegencyOfOutletList()[index]
                                            .toLowerCase()
                                            .capitalize!,
                                  ),
                                  SizedBox(height: 8),
                                  ...List.generate(
                                    controller.OutletS.getOutletItemByRegency(
                                      controller
                                          .OutletS.getAllRegencyOfOutletList()[index],
                                    ).length,
                                    (secondIndex) => OutletItemWidget(
                                      outlet:
                                          controller
                                              .OutletS.getOutletItemByRegency(
                                            controller
                                                .OutletS.getAllRegencyOfOutletList()[index],
                                          )[secondIndex],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.OutletS.getOutlets();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('Refresh')],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddOutletView(), transition: Transition.rightToLeft);
        },
      ),
    );
  }
}
