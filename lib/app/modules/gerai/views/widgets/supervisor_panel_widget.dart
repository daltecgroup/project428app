import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/gerai/controllers/outlet_detail_controller.dart';
import 'package:project428app/app/widgets/text_header.dart';
import 'package:project428app/app/widgets/user_roles.dart';

class SupervisorPanelWidget extends StatelessWidget {
  const SupervisorPanelWidget({super.key, required this.c});

  final OutletDetailController c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextTitle(text: 'SPV Area'),
                  TextButton(
                    onPressed: () {
                      c.outlet.value.spvarea.isEmpty
                          ? c.addPersonToOutlet('spvarea')
                          : c.isSpvareaEditable.toggle();
                    },
                    child:
                        c.outlet.value.spvarea.isEmpty
                            ? Text('Tambah SPV Area')
                            : Text(
                              c.isSpvareaEditable.value ? 'Selesai' : 'Ubah',
                            ),
                  ),
                ],
              ),
              c.outlet.value.spvarea.isEmpty
                  ? SizedBox()
                  : Column(
                    children: List.generate(
                      c.outlet.value.spvarea.length,
                      (index) => Column(
                        children: [
                          Card(
                            elevation: 1,
                            color: Colors.grey[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: FadeInImage.assetNetwork(
                                  placeholder: kAssetLoading,
                                  image:
                                      c.outlet.value.spvarea[index]['imgUrl'],
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 12,
                              ),
                              title: Text(
                                c.outlet.value.spvarea[index]['name'],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: UserRoles(
                                    role: c.outlet.value.spvarea[index]['role'],
                                    status: true,
                                    alignment: MainAxisAlignment.start,
                                  ),
                                ),
                              ),
                              trailing:
                                  c.isSpvareaEditable.value
                                      ? IconButton(
                                        onPressed: () {
                                          c.deletePersonFromOutlet(
                                            'spvarea',
                                            c
                                                .outlet
                                                .value
                                                .spvarea[index]['_id'],
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.red[700],
                                        ),
                                      )
                                      : null,
                            ),
                          ),
                          index == 1 ? SizedBox() : SizedBox(height: 3),
                        ],
                      ),
                    ),
                  ),
              c.isSpvareaEditable.value && c.outlet.value.spvarea.isNotEmpty
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          c.addPersonToOutlet('spvarea');
                        },
                        child: Text('Tambah SPV Area'),
                      ),
                    ],
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
