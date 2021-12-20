import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'package:get/get.dart';

class HomePickUp extends StatelessWidget {
  const HomePickUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Container(
      width: double.infinity,
      height: 245,
      child: Obx(
        () => controller.pickUp().isEmpty
            ? Container()
            : ListView.builder(
                padding: EdgeInsets.only(right: 20, top: 20),
                scrollDirection: Axis.horizontal,
                itemCount: controller.pickUp().length > 5
                    ? 5
                    : controller.pickUp().length,
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () {
                    controller.setSelectedItem(controller.pickUp()[i]);
                    Get.toNamed(detailScreen);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width - 40,
                    height: 210,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: CachedNetworkImage(
                            imageUrl: controller.pickUp()[i].photo,
                            // '$baseUrl$itemUrl${controller.pickUp()[i].photo}/get',
                            width: MediaQuery.of(context).size.width - 40,
                            height: 210,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 20,
                          child: SizedBox(
                            // width: 40,
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                controller.pickUp().length > 5
                                    ? 5
                                    : controller.pickUp().length,
                                (index) => Container(
                                  margin: EdgeInsets.only(right: 5),
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: index == i
                                        ? homeIndicatorColor
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
