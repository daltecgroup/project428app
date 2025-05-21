import 'package:flutter/material.dart';

class TransactionPageWidget extends StatelessWidget {
  const TransactionPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Transaksi')),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
