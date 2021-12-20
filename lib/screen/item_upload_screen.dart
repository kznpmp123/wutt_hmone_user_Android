import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/controller/upload_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/model/item.dart';

class UploadItem extends StatefulWidget {
  const UploadItem({Key? key}) : super(key: key);

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  final UploadController controller = Get.find();
  final HomeController homecontroller = Get.find();

  @override
  void dispose() {
    homecontroller.setEditItem(
      ItemModel(
        photo: '',
        name: '',
        price: 0,
        desc: '',
        color: '',
        size: '',
        star: 0,
        category: '',
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text("Wutt Hmone Myanmar Online Store", style: TextStyle(color: Colors.black, fontSize: 14),),
        elevation: 5,
        backgroundColor: detailBackgroundColor,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: appBarTitleColor,
          ),
        ),
      ),
      body: Form(
        key: controller.form,
        child: ListView(
          children: [
            // GestureDetector(
            //   onTap: controller.pickImage,
            //   child: Container(
            //     width: double.infinity,
            //     height: 200,
            //     margin: EdgeInsets.only(
            //       left: 20,
            //       right: 20,
            //       top: 20,
            //     ),
            //     child: Card(
            //       child: Obx(
            //         () => controller.filePath.isEmpty
            //             ? Center(
            //                 child: Icon(
            //                   Icons.image,
            //                 ),
            //               )
            //             : ClipRRect(
            //                 borderRadius: BorderRadius.all(
            //                   Radius.circular(7),
            //                 ),
            //                 child: Image.file(
            //                   File(
            //                     controller.filePath.value,
            //                   ),
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.photoController,
                validator: controller.validator,
                decoration: InputDecoration(
                  hintText: 'Photo Link',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.nameController,
                validator: controller.validator,
                decoration: InputDecoration(
                  hintText: 'Product အမည်',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                // textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: null,

                controller: controller.desc,
                validator: controller.validator,
                decoration: InputDecoration(
                  hintText: 'အသေးစိတ်ဖော်ပြချက်',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.priceController,
                validator: controller.validator,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'စျေးနှုန်း',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.colorController,
                validator: controller.validator,
                decoration: InputDecoration(
                  hintText: 'အရောင်',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.sizeController,
                validator: controller.validator,
                decoration: InputDecoration(
                  hintText: 'အရွယ်အစား',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.starController,
                validator: controller.validator,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Star',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.categoryController,
                validator: controller.validator,
                decoration: InputDecoration(
                  hintText: 'အမျိုးအစား',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: controller.upload,
                child: Obx(
                  () => controller.isUploading.value
                      ? CircularProgressIndicator(
                          color: scaffoldBackground,
                        )
                      : Text(homecontroller.editItem.value.id != null
                          ? "Edit"
                          : "upload"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
