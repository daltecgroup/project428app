import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/controllers/image_picker_controller.dart';
import 'package:project428app/app/modules/produk/controllers/produk_controller.dart';
import 'package:project428app/app/modules/produk/views/widgets/ingredients_item.dart';
import 'package:project428app/app/style.dart';
import 'package:project428app/app/widgets/field_error_widget.dart';
import 'package:project428app/app/widgets/text_header.dart';

import '../../../../constants.dart';

class AddMenuPageView extends GetView {
  const AddMenuPageView({super.key});
  @override
  Widget build(BuildContext context) {
    ProdukController c = Get.find<ProdukController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Produk',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            c.resetAddMenuField();
            Get.back();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Obx(
            () => Column(
              children: [
                SizedBox(height: 20),
                // Data Produk
                Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextTitle(text: 'Kode'),
                                  SizedBox(height: 5),
                                  Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(8),
                                    child: TextField(
                                      controller: c.productCode,
                                      onChanged:
                                          (value) =>
                                              c.isAddMenuCodeError.value =
                                                  false,
                                      decoration: TextFieldDecoration1(),
                                    ),
                                  ),
                                  // code field error text
                                  FieldErrorWidget(
                                    isError: c.isAddMenuCodeError.value,
                                    text: c.addMenuCodeErrorText.value,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextTitle(text: 'Status'),
                                  SizedBox(height: 5),
                                  Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(8),
                                    child: DropdownButtonFormField<bool>(
                                      value: c.addMenuStatus.value,
                                      decoration: TextFieldDecoration1(),
                                      items: [
                                        DropdownMenuItem(
                                          value: true,
                                          onTap:
                                              () =>
                                                  c.addMenuStatus.value = true,
                                          child: Text('Aktif'),
                                        ),
                                        DropdownMenuItem(
                                          value: false,
                                          onTap:
                                              () =>
                                                  c.addMenuStatus.value = false,
                                          child: Text('Tidak Aktif'),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextTitle(text: 'Nama'),
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(8),
                          child: TextField(
                            controller: c.productName,
                            onChanged:
                                (value) => c.isAddMenuNameError.value = false,
                            decoration: TextFieldDecoration1(),
                          ),
                        ),
                        FieldErrorWidget(
                          isError: c.isAddMenuNameError.value,
                          text: 'Nama tidak boleh kosong',
                        ),
                        SizedBox(height: 10),

                        // create a textfield with dropdown and the option is the list of category in c.categories
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTitle(text: 'Kategori'),
                            SizedBox(height: 5),
                            Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(8),
                              child: DropdownButtonFormField<String>(
                                value: c.addMenuCategoriId.value,
                                decoration: TextFieldDecoration1(),
                                items: [
                                  ...List.generate(
                                    c.categories.length,
                                    (index) => DropdownMenuItem(
                                      value: c.categories[index].id,
                                      onTap:
                                          () =>
                                              c.addMenuCategoriId.value =
                                                  c.categories[index].id,
                                      child: Text(c.categories[index].name),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextTitle(text: 'Harga'),
                                  SizedBox(height: 5),
                                  Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(8),
                                    child: TextField(
                                      controller: c.productPrice,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        c.isAddMenuPriceError.value = false;
                                        c.setAfterDiscountPrice();
                                      },
                                      decoration: TextFieldDecoration1(),
                                    ),
                                  ),
                                  FieldErrorWidget(
                                    isError: c.isAddMenuPriceError.value,
                                    text: 'Harga tidak boleh kosong',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextTitle(text: 'Diskon (%)'),
                                  SizedBox(height: 5),
                                  Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(8),
                                    child: TextField(
                                      controller: c.productDiscount,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        c.setAfterDiscountPrice();
                                        c.isAddMenuPriceError.value = false;
                                      },
                                      decoration: TextFieldDecoration1(),
                                    ),
                                  ),
                                  c.afterDiscountPrice.value.isEqual(0)
                                      ? SizedBox()
                                      : Row(
                                        children: [
                                          Text(
                                            'Setelah diskon: ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'IDR ${NumberFormat("#,##0", "id_ID").format(c.afterDiscountPrice.value)}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextTitle(text: 'Deskripsi'),
                        SizedBox(height: 5),
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(8),
                          child: TextField(
                            controller: c.productDescription,
                            decoration: TextFieldDecoration1(),
                          ),
                        ),
                        SizedBox(height: 10),

                        TextTitle(text: 'Gambar'),
                        SizedBox(height: 5),
                        c.imagePickerC.selectedImage.value == null
                            ? ElevatedButton(
                              onPressed: () {
                                c.imagePickerC.pickImage(ImageSource.gallery);
                              },
                              child: Text('Pilih Gambar'),
                            )
                            : SelectedImagePanel(c: c.imagePickerC),
                        SizedBox(height: 5),
                        c.imagePickerC.selectedImage.value == null
                            ? FieldErrorWidget(
                              isError: c.isAddMenuImageError.value,
                              text: 'Gambar tidak boleh kosong',
                            )
                            : SizedBox(),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Komposisi bahan
                Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextTitle(text: 'Komposisi Bahan'),
                              TextButton(
                                onPressed: () {
                                  c.addIngredients();
                                },
                                child: Text('Tambah'),
                              ),
                            ],
                          ),
                          c.addMenuIngredients.isEmpty
                              ? SizedBox()
                              : SizedBox(height: 5),
                          c.addMenuIngredients.isEmpty
                              ? SizedBox()
                              : Column(
                                children: List.generate(
                                  c.addMenuIngredients.length,
                                  (index) => IngredientsItem(
                                    c: c,
                                    stock: c.addMenuIngredients[index]['stock'],
                                    name: c.addMenuIngredients[index]['name'],
                                    qty: c.addMenuIngredients[index]['qty'],
                                    unit: c.addMenuIngredients[index]['unit'],
                                  ),
                                ),
                              ),
                          FieldErrorWidget(
                            isError: c.isAddMenuIngredientsError.value,
                            text: 'Bahan tidak boleh kosong',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 20, left: 0, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.grey[300],
                            ),
                          ),
                          onPressed: () {
                            c.resetAddMenuField();
                            Get.back();
                          },
                          child: Text(
                            'Kembali',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.blue,
                            ),
                          ),
                          onPressed: () {
                            c.createProduct();
                          },
                          child: Text(
                            'Simpan',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedImagePanel extends StatelessWidget {
  const SelectedImagePanel({super.key, required this.c});

  final ImagePickerController c;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: kMobileWidth * 0.45,
            width: double.infinity,
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(c.selectedImage.value!, fit: BoxFit.cover),
                // child: Image.network(
                //   fit: BoxFit.cover,
                //   'https://placebear.com/250/250',
                //   webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                // ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Container(
            height: kMobileWidth * 0.50,
            width: kMobileWidth * 0.50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama File',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(c.selectedImage.value!.path.split('\\').last),
                    // Text('gambar-produk.jpg'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ukuran',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${(c.selectedImage.value!.lengthSync() / 1024).toStringAsFixed(2)} Kb',
                      style: TextStyle(),
                    ),
                    // Text('56Kb'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tipe',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // get selected image file type
                    Text(
                      c.selectedImage.value!.path.split('.').last.toUpperCase(),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    c.pickImage(ImageSource.gallery);
                  },
                  child: Text('Ganti'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
