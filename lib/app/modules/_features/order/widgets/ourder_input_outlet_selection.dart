import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';

import '../../../../data/models/Outlet.dart';
import '../../../../modules/_features/order/controllers/order_input_controller.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/vertical_sized_box.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OurderInputOutletSelection extends StatelessWidget {
  const OurderInputOutletSelection({super.key, required this.c});

  final OrderInputController c;

  @override
  Widget build(BuildContext context) {
    final BoxHelper box = BoxHelper();

    String? outletName;
    if (!box.isNull(AppConstants.KEY_CURRENT_OUTLET)) {
      final outlet = c.outletData.getOutletById(
        box.getValue(AppConstants.KEY_CURRENT_OUTLET),
      );
      if (outlet != null) {
        outletName = outlet.name;
      }
    }

    return CustomCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customInputTitleText(text: 'Outlet Tujuan'),
          const VerticalSizedBox(height: 0.7),
          Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(
              AppConstants.DEFAULT_BORDER_RADIUS,
            ),
            child: DropdownButtonFormField<Outlet>(
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.grey[50],
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                    AppConstants.DEFAULT_BORDER_RADIUS,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.DEFAULT_BORDER_RADIUS,
                  ),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                  ),
                ),
              ),
              value: c.selectedOutlet.value,
              items: c.outletData
                  .filteredOutlet(status: true, keyword: outletName)
                  .map(
                    (e) => DropdownMenuItem<Outlet>(
                      value: e,
                      child: SizedBox(
                        width: Get.width - (AppConstants.DEFAULT_PADDING * 7),
                        child: Text(
                          e.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                c.selectedOutlet.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
