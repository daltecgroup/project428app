import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/modules/gerai/views/widgets/add_outlet_view.dart';
import 'package:project428app/app/modules/gerai/views/widgets/outlet_item.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../../../constants.dart';
import '../../../style.dart';
import '../../../widgets/admin/admin_appbar.dart';
import '../../../widgets/admin/admin_drawer.dart';
import '../controllers/gerai_controller.dart';

class GeraiView extends GetView<GeraiController> {
  const GeraiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(context, "Gerai"),
      drawer: AdminDrawer(context, kAdminMenuGerai),
      body: Obx(
        () => Column(
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
                      controller.getAllRegencyOfOutletList().length,
                      (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextTitle(
                            text:
                                controller
                                    .getAllRegencyOfOutletList()[index]
                                    .toLowerCase()
                                    .capitalize!,
                          ),
                          SizedBox(height: 8),
                          ...List.generate(
                            controller
                                .getOutletItemByRegency(
                                  controller.getAllRegencyOfOutletList()[index],
                                )
                                .length,
                            (secondIndex) => OutletItemWidget(
                              outlet:
                                  controller.getOutletItemByRegency(
                                    controller
                                        .getAllRegencyOfOutletList()[index],
                                  )[secondIndex],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.getOutletList();
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
