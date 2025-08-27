import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ingredient_purchase_input_controller.dart';

class IngredientPurchaseInputView
    extends GetView<IngredientPurchaseInputController> {
  const IngredientPurchaseInputView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IngredientPurchaseInputView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'IngredientPurchaseInputView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
