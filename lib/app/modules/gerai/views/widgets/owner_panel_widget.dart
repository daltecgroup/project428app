import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/core/constants/constants.dart';
import 'package:project428app/app/modules/gerai/controllers/outlet_detail_controller.dart';
import 'package:project428app/app/services/auth_service.dart';
import 'package:project428app/app/shared/widgets/text_header.dart';
import 'package:project428app/app/shared/widgets/users/user_roles.dart';

class OwnerPanelWidget extends StatelessWidget {
  const OwnerPanelWidget({super.key, required this.c});

  final OutletDetailController c;

  @override
  Widget build(BuildContext context) {
    AuthService AuthS = Get.find<AuthService>();
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
                  TextTitle(text: 'Pemilik'),
                  TextButton(
                    onPressed: () {
                      c.outlet.value.owner.isEmpty
                          ? c.addPersonToOutlet('franchisee')
                          : c.isOwnerEditable.toggle();
                    },
                    child:
                        c.outlet.value.owner.isEmpty
                            ? Text('Tambah Pemilik')
                            : Text(
                              c.isOwnerEditable.value ? 'Selesai' : 'Ubah',
                            ),
                  ),
                ],
              ),
              c.outlet.value.owner.isEmpty
                  ? SizedBox()
                  : Column(
                    children: List.generate(
                      c.outlet.value.owner.length,
                      (index) => Column(
                        children: [
                          Card(
                            elevation: 1,
                            color: Colors.grey[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: kAssetLoading,
                                    image:
                                        '${AuthS.mainServerUrl.value}/api/v1/uploads/${c.outlet.value.owner[index]['imgUrl']}',
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 12,
                              ),
                              title: Text(c.outlet.value.owner[index]['name']),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: UserRoles(
                                    role: c.outlet.value.owner[index]['role'],
                                    status: true,
                                    alignment: MainAxisAlignment.start,
                                  ),
                                ),
                              ),
                              trailing:
                                  c.isOwnerEditable.value
                                      ? IconButton(
                                        onPressed: () {
                                          c.deletePersonFromOutlet(
                                            'franchisee',
                                            c.outlet.value.owner[index]['_id'],
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
              c.isOwnerEditable.value && c.outlet.value.owner.isNotEmpty
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          c.addPersonToOutlet('franchisee');
                        },
                        child: Text('Tambah Pemilik'),
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
