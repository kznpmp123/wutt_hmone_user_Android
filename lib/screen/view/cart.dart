import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/routes/routes.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Column(
      children: [
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: controller.myCart.length,
              itemBuilder: (_, i) => Card(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            controller.getItem(controller.myCart[i].id).photo,
                        // "$baseUrl$itemUrl${controller.getItem(controller.myCart[i].id).photo}/get",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.getItem(controller.myCart[i].id).name,
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          SizedBox(height: 5),
                          Text("${controller.myCart[i].color}",
                              style: TextStyle(fontSize: 12),),
                          SizedBox(height: 5),
                          Text("${controller.myCart[i].size}",
                            style: TextStyle(fontSize: 12),),
                          SizedBox(height: 5),
                          Text(
                            "${controller.getItem(controller.myCart[i].id).price} ကျပ်",
                            style: TextStyle(fontSize: 12),),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.remove(controller.myCart[i]);
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text(controller.myCart[i].count.toString()),
                          IconButton(
                            onPressed: () {
                              controller.addCount(controller.myCart[i]);
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 150,
          child: Card(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ကုန်ပစ္စည်းအတွက် ကျသင့်ငွေ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${controller.subTotal} ကျပ်",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "အိမ်အရောက် ပို့ဆောင်စရိတ်",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          " ${controller.shipping()} ကျပ်",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(25, 25, 25, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "စုစုပေါင်း ကျသင့်ငွေ   =  ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${controller.subTotal + controller.shipping()} ကျပ်",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 45,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(homeIndicatorColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              if (controller.myCart.isNotEmpty) {
                Get.toNamed(checkOutScreen);
              } else {
                Get.snackbar('Error', "Cart is empty");
              }
            },
            child: Text("Order တင်ရန် နှိပ်ပါ"),
          ),
        )
      ],
    );
  }
}
