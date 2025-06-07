import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/controllers/address_data_controller.dart';
import 'package:project428app/app/modules/gerai/controllers/add_outlet_controller.dart';
import '../../../../style.dart';
import '../../../../shared/widgets/text_header.dart';

class AddOutletView extends GetView {
  const AddOutletView({super.key});
  @override
  Widget build(BuildContext context) {
    AddressDataController addressC = Get.put(
      AddressDataController(),
      tag: 'add_outlet',
    );
    AddOutletController c = Get.put(AddOutletController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Gerai',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Obx(
                () => Column(
                  children: [
                    SizedBox(height: 20),
                    // outlet indentification
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
                            // panel title
                            Row(
                              children: [
                                Text(
                                  'Data Gerai',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextTitle(text: 'Kode'),
                                      SizedBox(height: 5),
                                      Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(8),
                                        child: TextField(
                                          controller: c.codeC,
                                          onChanged: (value) {
                                            c.isCodeError.value = false;
                                          },
                                          decoration: TextFieldDecoration2(
                                            c.isCodeError.value,
                                            null,
                                            null,
                                          ),
                                        ),
                                      ),

                                      // code field error text
                                      TextFieldErrorText(false, ""),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextTitle(text: 'Status'),
                                      SizedBox(height: 5),
                                      Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(8),
                                        child: DropdownButtonFormField<bool>(
                                          value: c.status.value,
                                          decoration: TextFieldDecoration2(
                                            false,
                                            null,
                                            null,
                                          ),
                                          items: [
                                            DropdownMenuItem(
                                              value: true,

                                              child: Text('Aktif'),
                                            ),
                                            DropdownMenuItem(
                                              value: false,

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
                                controller: c.nameC,
                                onChanged: (value) {
                                  c.isNameError.value = false;
                                },
                                decoration: TextFieldDecoration2(
                                  c.isNameError.value,
                                  null,
                                  null,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // outlet address
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
                            // select province
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // panel title
                                Row(
                                  children: [
                                    Text(
                                      'Alamat Gerai',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextTitle(text: 'Provinsi'),
                                          SizedBox(height: 5),
                                          Material(
                                            elevation: 2,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              value: null,
                                              decoration: TextFieldDecoration2(
                                                c.isProvinceError.value,
                                                null,
                                                null,
                                              ),

                                              items: [
                                                ...List.generate(
                                                  addressC.provinces.length,
                                                  (index) => DropdownMenuItem(
                                                    value:
                                                        addressC
                                                            .provinces[index]['id'],
                                                    onTap: () {
                                                      addressC
                                                          .selectedProvince
                                                          .value = addressC
                                                              .provinces[index]['name'];
                                                      addressC.fetchRegency(
                                                        addressC
                                                            .provinces[index]['id'],
                                                      );
                                                      c.isProvinceError.value =
                                                          false;
                                                    },
                                                    child: Text(
                                                      addressC
                                                          .provinces[index]['name'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
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
                                addressC.regencies.isEmpty
                                    ? SizedBox(height: 5)
                                    : SizedBox(height: 10),
                              ],
                            ),

                            // select regency
                            Column(
                              children: [
                                addressC.regencies.isEmpty
                                    ? SizedBox()
                                    : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextTitle(text: 'Kabupaten/Kota'),
                                              SizedBox(height: 5),
                                              Material(
                                                elevation: 2,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: DropdownButtonFormField<
                                                  String
                                                >(
                                                  value: null,
                                                  decoration:
                                                      TextFieldDecoration2(
                                                        c.isRegencyError.value,
                                                        null,
                                                        null,
                                                      ),
                                                  items: [
                                                    ...List.generate(
                                                      addressC.regencies.length,
                                                      (
                                                        index,
                                                      ) => DropdownMenuItem(
                                                        value:
                                                            addressC
                                                                .regencies[index]['id'],
                                                        onTap: () {
                                                          addressC
                                                              .selectedRegency
                                                              .value = addressC
                                                                  .regencies[index]['name'];
                                                          addressC.fetchDistrict(
                                                            addressC
                                                                .regencies[index]['id'],
                                                          );
                                                          c
                                                              .isRegencyError
                                                              .value = false;
                                                        },
                                                        child: Text(
                                                          addressC
                                                              .regencies[index]['name'],
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ),
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
                                addressC.regencies.isEmpty
                                    ? SizedBox()
                                    : SizedBox(height: 10),
                              ],
                            ),

                            // select district
                            Column(
                              children: [
                                addressC.districts.isEmpty
                                    ? SizedBox()
                                    : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextTitle(text: 'Kecamatan'),
                                              SizedBox(height: 5),
                                              Material(
                                                elevation: 2,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: DropdownButtonFormField<
                                                  String
                                                >(
                                                  value: null,
                                                  decoration:
                                                      TextFieldDecoration2(
                                                        c.isDistrictError.value,
                                                        null,
                                                        null,
                                                      ),
                                                  items: [
                                                    ...List.generate(
                                                      addressC.districts.length,
                                                      (
                                                        index,
                                                      ) => DropdownMenuItem(
                                                        value:
                                                            addressC
                                                                .districts[index]['id'],
                                                        onTap: () {
                                                          addressC
                                                              .selectedDistrict
                                                              .value = addressC
                                                                  .districts[index]['name'];
                                                          addressC.fetchVillage(
                                                            addressC
                                                                .districts[index]['id'],
                                                          );
                                                          c
                                                              .isDistrictError
                                                              .value = false;
                                                        },
                                                        child: Text(
                                                          addressC
                                                              .districts[index]['name'],
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ),
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
                                addressC.districts.isEmpty
                                    ? SizedBox()
                                    : SizedBox(height: 10),
                              ],
                            ),

                            // select village
                            Column(
                              children: [
                                addressC.villages.isEmpty
                                    ? SizedBox()
                                    : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextTitle(
                                                text: 'Keluarahan/Desa',
                                              ),
                                              SizedBox(height: 5),
                                              Material(
                                                elevation: 2,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: DropdownButtonFormField<
                                                  String
                                                >(
                                                  value: null,
                                                  decoration:
                                                      TextFieldDecoration2(
                                                        c.isVillageError.value,
                                                        null,
                                                        null,
                                                      ),
                                                  items: [
                                                    ...List.generate(
                                                      addressC.villages.length,
                                                      (
                                                        index,
                                                      ) => DropdownMenuItem(
                                                        value:
                                                            addressC
                                                                .villages[index]['id'],
                                                        onTap: () {
                                                          addressC
                                                              .selectedVillage
                                                              .value = addressC
                                                                  .villages[index]['name'];
                                                          c
                                                              .isVillageError
                                                              .value = false;
                                                        },
                                                        child: Text(
                                                          addressC
                                                              .villages[index]['name'],
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ),
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
                                addressC.villages.isEmpty
                                    ? SizedBox()
                                    : SizedBox(height: 10),

                                addressC.selectedVillage.isEmpty
                                    ? SizedBox()
                                    : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextTitle(text: 'Nama Jalan'),
                                        Material(
                                          elevation: 2,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: TextField(
                                            controller: c.streetC,
                                            onChanged: (value) {
                                              c.isStreetError.value = false;
                                            },
                                            decoration: TextFieldDecoration2(
                                              c.isStreetError.value,
                                              null,
                                              null,
                                            ),
                                          ),
                                        ),
                                        TextFieldErrorText(false, ""),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // back and condfirm button
            Container(
              alignment: Alignment.bottomCenter,
              height: double.infinity,
              padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
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
                        Get.back();
                      },
                      child: Text('Kembali', style: TextStyle(fontSize: 16)),
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
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {
                        c.errorCheck();
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
          ],
        ),
      ),
    );
  }

  Widget TextFieldErrorText(bool isError, String text) {
    return isError
        ? Text(text, style: TextStyle(fontSize: 12, color: Colors.red))
        : SizedBox();
  }
}
