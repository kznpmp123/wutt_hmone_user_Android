import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
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
      body: ListView.builder(
        itemCount: controller.purhcases().length,
        itemBuilder: (_, i) => ListTile(
          title: Text(
              "${controller.purhcases()[i].name} 0${controller.purhcases()[i].phone}"
              ),
          subtitle: Text("${controller.purhcases()[i].dateTime?.day}/${controller.purhcases()[i].dateTime?.month}/${controller.purhcases()[i].dateTime?.year}"
              ),
          trailing: IconButton(
            onPressed: () {
              int total = 0;
              int shipping = 2500;

              for (var item in controller.purhcases()[i].items) {
                total += controller
                    .getItem(
                  item.toString().split(',')[0],
                )
                    .price *
                    int.parse(item.toString().split(',').last);
              }

              print(controller.purhcases()[i].items.length);
              Get.defaultDialog(
                  title: "Customer ၀ယ်ယူခဲ့သော အချက်အလက်များ",
                  titleStyle: TextStyle(fontSize: 12),
                  radius: 5,
                  content: Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Invoice Id"),
                      //     Text("${controller.purhcases()[i].id}"),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text("Purchase Date"),
                          Text("၀ယ်ယူခဲ့သော နေ့ရက် - ${controller.purhcases()[i].dateTime?.day}/${controller.purhcases()[i].dateTime?.month}/${controller.purhcases()[i].dateTime?.year}",
                            style: TextStyle(
                                fontSize: 14
                            ),),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text("Name"),
                          Text(controller.purhcases()[i].name,
                            style: TextStyle(
                                fontSize: 14
                            ),),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text("Ph No."),
                          Text("0${controller.purhcases()[i].phone}",
                            style: TextStyle(
                                fontSize: 14
                            ),),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text("Email"),
                          Text(controller.purhcases()[i].email,
                            style: TextStyle(
                                fontSize: 14
                            ),),
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text("Address"),
                          Expanded(child: Text(controller.purhcases()[i].address,
                            style: TextStyle(
                                fontSize: 14
                            ),)),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 400,
                        height: 150,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: controller.purhcases()[i].items.length,
                          itemBuilder: (_, o) => Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${o + 1}. ${controller.getItem(
                                  controller
                                      .purhcases()[i]
                                      .items[o]
                                      .toString()
                                      .split(',')[0],
                                ).name}", style: TextStyle(
                                    fontSize: 12
                                ),


                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${controller.purhcases()[i].items[o].toString().split(',')[1]}", style: TextStyle(
                                          fontSize: 10
                                      ),),

                                      Text(
                                          "${controller.purhcases()[i].items[o].toString().split(',')[2]}", style: TextStyle(
                                          fontSize: 10
                                      ),)
                                    ],
                                  ),
                                ),
                                Text(
                                  "${controller.getItem(
                                    controller
                                        .purhcases()[i]
                                        .items[o]
                                        .toString()
                                        .split(',')[0],
                                  ).price} x ${controller.purhcases()[i].items[o].toString().split(',').last} ခု",
                                  style: TextStyle(
                                      fontSize: 10
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("စုစုပေါင်း", style: TextStyle(
                              fontSize: 14
                          ),),
                          Text("$total + Deli $shipping Ks", style: TextStyle(
                              fontSize: 14
                          ),),
                        ],
                      ),
                    ],
                  ));
            },
            icon: Icon(Icons.info),
          ),
        ),
      ),
    );
  }
}