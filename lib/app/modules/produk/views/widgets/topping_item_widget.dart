import 'package:flutter/material.dart';

class ToppingItemWidget extends StatelessWidget {
  const ToppingItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10, left: 0, right: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 12),
            height: 90,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.network(
                fit: BoxFit.cover,
                'https://placebear.com/250/250',
                webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 0,
                right: 10,
                bottom: 10,
                top: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Susu Coklat',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      PopupMenuButton(
                        color: Colors.white,
                        icon: Icon(Icons.more_horiz),
                        itemBuilder:
                            (context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                child: const Text('Sesuaikan Harga'),
                                onTap: () => print('tapOne'),
                              ),
                              PopupMenuItem(child: Text('Nonaktifkan')),
                              PopupMenuDivider(height: 1),
                              PopupMenuItem(
                                child: Text(
                                  'Hapus',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kode',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'TP01',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Harga',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'IDR 3.000',
                              style: TextStyle(fontWeight: FontWeight.w500),
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
        ],
      ),
    );
  }
}
