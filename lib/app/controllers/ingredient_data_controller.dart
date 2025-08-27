import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../data/models/Ingredient.dart';
import '../data/models/IngredientHistory.dart';
import '../data/models/RawRecipe.dart';
import '../data/models/Recipe.dart';
import '../data/repositories/ingredient_repository.dart';
import '../utils/helpers/text_helper.dart';
import '../routes/app_pages.dart';
import '../shared/alert_snackbar.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';

class IngredientDataController extends GetxController {
  IngredientDataController({required this.repository});
  final IngredientRepository repository;

  final RxList<Ingredient> ingredients = <Ingredient>[].obs;
  final Rx<Ingredient?> selectedIngredient = Rx<Ingredient?>(null);

  final RxList<IngredientHistory?> selectedIngredientHistory =
      <IngredientHistory>[].obs;

  final Rx<DateTime?> latestSync = (null as DateTime?).obs;

  final RxBool isLoading = false.obs;
  Timer? _syncTimer;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    syncData();
    setLatestSync();
    _startAutoSync();
  }

  @override
  void onClose() {
    super.onClose();
    _stopAutoSync();
  }

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_INGREDIENT_DATA_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_INGREDIENT_DATA_LATEST),
      );
    }
    return time;
  }

  Future<void> fetchIngredientHistory() async {
    try {
      if (selectedIngredient.value != null) {
        final response = await repository.getIngredientHistory(
          selectedIngredient.value!.id,
        );

        if (response.isNotEmpty) {
          selectedIngredientHistory.assignAll(response);
          LoggerHelper.logInfo('Success fetching ingredient history');
          return;
        }
      }
      selectedIngredientHistory.clear();
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  void setLatestSync() {
    latestSync.value = latestSyncTime;
    latestSync.refresh();
  }

  void _startAutoSync() {
    if (AppConstants.RUN_SYNC_TIMER) {
      LoggerHelper.logInfo('Ingredients AutoSync started...');
      _syncTimer = Timer.periodic(Duration(seconds: AppConstants.SYNC_TIMER), (
        timer,
      ) async {
        await syncData();
      });
    }
  }

  void _stopAutoSync() {
    if (_syncTimer != null) {
      _syncTimer!.cancel();
      _syncTimer = null;
      LoggerHelper.logInfo('Ingredients AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  Future<void> syncData({bool? refresh}) async {
    isLoading.value = true;
    try {
      final file = await getLocalFile(AppConstants.FILENAME_INGREDIENT_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial ingredient data from local data');
        final List<Ingredient> ingredientList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map(
                  (json) => Ingredient.fromJson(json as Map<String, dynamic>),
                )
                .toList();
        ingredientList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        ingredients.assignAll(ingredientList);
      } else {
        if (await file.exists() && refresh != null && refresh == true)
          await file.delete();
        LoggerHelper.logInfo('Set initial ingredient data from server');

        final List<Ingredient> fetchedIngredients = await repository
            .getIngredients();
        if (fetchedIngredients.isNotEmpty) {
          ingredients.assignAll(fetchedIngredients);
        } else {
          ingredients.clear();
        }

        await file.writeAsString(
          ingredients
              .map((ingredient) => json.encode(ingredient.toJson()))
              .toList()
              .toString(),
        );
        await box.setValue(
          AppConstants.KEY_INGREDIENT_DATA_LATEST,
          DateTime.now().toUtc().toLocal().millisecondsSinceEpoch,
        );
        setLatestSync();
      }
      await fetchIngredientHistory();
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  List<Recipe> getRecipeFromRawRecipe(List<RawRecipe> rawRecipe) {
    List<Recipe> newList = [];
    for (var raw in rawRecipe) {
      if (getIngredient(raw.ingredientId) != null) {
        newList.add(
          Recipe(ingredient: getIngredient(raw.ingredientId)!, qty: raw.qty),
        );
      }
    }
    return newList;
  }

  Ingredient? getIngredient(String id) {
    return ingredients.firstWhereOrNull((e) => e.id == id);
  }

  Future<void> createIngredient(dynamic data) async {
    isLoading.value = true;
    try {
      final response = await repository.createIngredient(data);
      switch (response['statusCode']) {
        case 201:
          successSnackbar(response['message']);
          await syncData(refresh: true);
          Get.offNamed(Routes.INGREDIENT_LIST);
          break;
        default:
          successSnackbar(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeStatus() async {
    isLoading.value = true;
    try {
      final bool targetStatus = !selectedIngredient.value!.isActive;
      await updateIngredient(data: json.encode({'isActive': targetStatus}));
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateIngredient({dynamic data, String? backRoute}) async {
    isLoading.value = true;
    try {
      if (selectedIngredient.value != null) {
        final response = await repository.updateIngredient(
          selectedIngredient.value!.id,
          data,
        );
        switch (response['statusCode']) {
          case 200:
            await syncData(refresh: true);
            selectedIngredient.value = response['ingredient'] as Ingredient;
            selectedIngredient.refresh();
            if (backRoute != null) Get.toNamed(backRoute);
            customSuccessAlertDialog(response['message']);
            break;
          default:
            customAlertDialog(response['message']);
        }
      } else {
        customAlertDialog('Data Pengguna gagal dimuat');
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteConfirmation() async {
    customDeleteAlertDialog(
      'Yakin menghapus ${normalizeName(selectedIngredient.value!.name)}?',
      () {
        deleteIngredient();
      },
    );
  }

  Future<void> deleteIngredient() async {
    isLoading.value = true;
    try {
      if (selectedIngredient.value != null) {
        final response = await repository.deleteIngredient(
          selectedIngredient.value!.id,
        );
        switch (response['statusCode']) {
          case 200:
            await syncData(refresh: true);
            selectedIngredient.value = null as Ingredient?;
            Get.offNamed(Routes.INGREDIENT_LIST);
            customSuccessAlertDialog(response['message']);
            break;
          default:
            customAlertDialog(response['message']);
        }
      } else {
        customAlertDialog('Data Pengguna gagal dimuat');
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
