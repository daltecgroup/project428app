import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/modules/pengguna/controllers/pengguna_controller.dart';
import 'package:project428app/app/widgets/format_waktu.dart';

Widget PenggunaItem(
  String userId,
  String name,
  List role,
  bool status,
  String imgUrl,
  int index,
  String createdAt,
) {
  imgUrl = "https://i.pravatar.cc/150?img=${index + 1}";
  PenggunaController userC = Get.find<PenggunaController>();

  return Card(
    margin: const EdgeInsets.only(bottom: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    child: InkWell(
      onTap: () {
        userC.setCurrentUserDetail(userId);
        Get.toNamed('/detail-pengguna');
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              imgUrl,
              webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text("$name ($userId)", overflow: TextOverflow.ellipsis),
              ),
              status
                  ? Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Aktif",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 12, color: Colors.green),
                      ),
                    ),
                  )
                  : Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Nonaktif",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 12, color: Colors.red[200]),
                      ),
                    ),
                  ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  role.contains('admin')
                      ? Container(
                        margin: const EdgeInsets.only(right: 3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Admin",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      )
                      : SizedBox(),
                  role.contains('franchisee')
                      ? Container(
                        margin: const EdgeInsets.only(right: 3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Franchisee",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      )
                      : SizedBox(),
                  role.contains('spvarea')
                      ? Container(
                        margin: const EdgeInsets.only(right: 3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "SPV Area",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      )
                      : SizedBox(),
                  role.contains('operator')
                      ? Container(
                        margin: const EdgeInsets.only(right: 3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Operator",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 5),
              Text(FormatWaktu(createdAt), style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    ),
  );
}
