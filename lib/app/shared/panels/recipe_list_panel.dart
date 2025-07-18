import 'package:flutter/material.dart';
import '../../data/models/Recipe.dart';
import '../../shared/custom_card.dart';
import '../../shared/vertical_sized_box.dart';
import '../../utils/helpers/number_helper.dart';
import '../../utils/helpers/text_helper.dart';
import '../../utils/theme/custom_text.dart';

class RecipeListPanel extends StatelessWidget {
  const RecipeListPanel({super.key, required this.recipeList});

  final List<Recipe> recipeList;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      content: Column(
        children: [
          if (recipeList.isEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Bahan Baku Kosong')],
            ),
          if (recipeList.isNotEmpty)
            Row(
              mainAxisAlignment: recipeList.isNotEmpty
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [customLabelText(text: 'Bahan')],
            ),
          if (recipeList.isNotEmpty) const VerticalSizedBox(height: 0.7),
          ...List.generate(
            recipeList.length,
            (index) => Column(
              children: [
                CustomCard(
                  padding: 12,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(normalizeName(recipeList[index].ingredient.name)),
                      Text('${inLocalNumber(recipeList[index].qty)} gram'),
                    ],
                  ),
                ),
                if (recipeList.length - 1 != index) VerticalSizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
