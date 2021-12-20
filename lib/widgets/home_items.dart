import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/model/item.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'package:get/get.dart';

class HomeItems extends StatelessWidget {
  const HomeItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Obx(
          () => GridView.builder(
        padding: EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
          bottom: 5,
        ),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.68,
          // crossAxisSpacing: 5,
          // mainAxisSpacing: 5,
        ),
        itemCount: controller.getItems().length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            controller.setSelectedItem(controller.getItems()[i]);
            Get.toNamed(detailScreen);
          },
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                  Expanded(
                      child: Hero(
                        tag: controller.getItems()[i].photo,
                        child: CachedNetworkImage(
                          width: 160,
                          height: 90,
                          fit: BoxFit.cover,
                          imageUrl: controller.getItems()[i].photo,
                          // "$baseUrl$itemUrl${controller.getItems()[i].photo}/get",
                        ),
                      ),
                  ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.getItems()[i].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: List.generate(
                            5,
                                (index) => Icon(
                              Icons.star,
                              size: 10,
                              color: index <= controller.getItems()[i].star
                                  ? homeIndicatorColor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${controller.getItems()[i].price} Ks",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: homeIndicatorColor,
                              fontSize: 10
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 20,
                  margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(homeIndicatorColor),
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                        titlePadding: EdgeInsets.all(0),
                        contentPadding:
                        EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        radius: 0,
                        title: '',
                        content: AddToCart(
                          itemModel: controller.getItems()[i],
                        ),
                      );
                    },
                    child: Text('၀ယ်ယူရန်', style: TextStyle(fontSize: 10),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddToCart extends StatefulWidget {
  final ItemModel itemModel;
  const AddToCart({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  String? colorValue;
  String? sizeValue;
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          value: colorValue,
          hint: Text('Color', style: TextStyle(fontSize: 12)),
          onChanged: (String? e) {
            setState(() {
              colorValue = e;
            });
          },
          items: widget.itemModel.color
              .split(',')
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e, style: TextStyle(fontSize: 12)),
          ))
              .toList(),
        ),
        SizedBox(
          height: 20,
        ),
        DropdownButtonFormField(
          value: sizeValue,
          hint: Text("Size", style: TextStyle(fontSize: 12)),
          onChanged: (String? e) {
            setState(() {
              sizeValue = e;
            });
          },
          items: widget.itemModel.size
              .split(',')
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e, style: TextStyle(fontSize: 12)),
          ))
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              if (colorValue != null && sizeValue != null) {
                controller.addToCart(widget.itemModel, colorValue!, sizeValue!);
                Get.back();
              }
            },
            child: Text("၀ယ်ယူရန်"),
          ),
        )
      ],
    );
  }
}
