import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/widgets/operator/operator_appbar.dart';
import 'package:project428app/app/widgets/operator/operator_drawer.dart';

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              child: Column(
                children: [
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 1,
                    child: ListTile(
                      selected: true,
                      selectedTileColor: Colors.grey[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: FadeInImage.assetNetwork(
                          placeholder: kAssetLoading,
                          image: controller.c.userdata.imgUrl,
                          // webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                        ),
                      ),
                      title: Text(
                        controller.c.userdata.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        'ID ${controller.c.userdata.userId}',
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: IconButton(
                        color: Colors.red[700],
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                        ),
                        onPressed: () {
                          Get.offNamed('/login-as');
                        },
                        icon: Icon(Icons.change_circle_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
