import '../../data/models/BundleCategory.dart';
import '../../data/models/Recipe.dart';

bool isSameRecipeList(List<Recipe> a, List<Recipe> b) {
  if (a.length != b.length) return false;
  return a.every(
    (ra) =>
        b.any((rb) => rb.ingredient.id == ra.ingredient.id && rb.qty == ra.qty),
  );
}

bool isSameBundleCategoryList(List<BundleCategory> a, List<BundleCategory> b) {
  if (a.length != b.length) return false;
  return a.every(
    (ra) => b.any(
      (rb) => rb.menuCategoryId == ra.menuCategoryId && rb.qty == ra.qty,
    ),
  );
}

bool allStrings(List<dynamic> list) {
  return list.every((item) => item is String);
}
