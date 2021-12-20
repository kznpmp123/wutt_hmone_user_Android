import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/controller/manage_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/routes/routes.dart';

class ManageItem extends StatefulWidget {
  const ManageItem({Key? key}) : super(key: key);

  @override
  State<ManageItem> createState() => _ManageItemState();
}

class _ManageItemState extends State<ManageItem> {
  final TextEditingController editingController = TextEditingController();
  final HomeController homeController = Get.find();
  final MangeController mangeController = Get.find();
  @override
  void dispose() {
    homeController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text("Wutt Hmone Myanmar Online Store",
          style: TextStyle(color: Colors.black,
              fontSize: 14),),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: editingController,
              onChanged: homeController.onSearch,
              // onSubmitted: homeController.searchItem,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search",
                  suffixIcon: IconButton(
                    onPressed: () {
                      editingController.clear();
                      homeController.clear();
                    },
                    icon: Icon(Icons.clear),
                  )),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: homeController.isSearch.value
                    ? homeController.searchitems.length
                    : homeController.items.length,
                itemBuilder: (_, i) => SwipeActionCell(
                  key: ValueKey(homeController.isSearch.value
                      ? homeController.searchitems.length
                      : homeController.items[i].id),
                  trailingActions: [
                    SwipeAction(
                      onTap: (CompletionHandler _) async {
                        await _(true);
                        await mangeController.delete(
                            homeController.isSearch.value
                                ? homeController.searchitems[i].id!
                                : homeController.items[i].id!);
                        setState(() {});
                      },
                      title: 'Delete',
                    ),
                    SwipeAction(
                      color: Colors.grey,
                      onTap: (CompletionHandler _) async {
                        await _(false);
                        homeController.setEditItem(homeController.isSearch.value
                            ? homeController.searchitems[i]
                            : homeController.items[i]);
                        Get.toNamed(uploadItemScreen);
                        setState(() {});
                      },
                      title: 'Edit',
                    ),
                  ],
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 140,
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: homeController.isSearch.value
                                ? homeController.searchitems[i].photo
                                : homeController.items[i].photo,
                            width: 100,
                            height: 125,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homeController.isSearch.value
                                      ? homeController.searchitems[i].name
                                      : homeController.items[i].name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  homeController.isSearch.value
                                      ? homeController.searchitems[i].color
                                      : homeController.items[i].color
                                          .replaceAll(',', ', '),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    wordSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  homeController.isSearch.value
                                      ? homeController.searchitems[i].size
                                      : homeController.items[i].size
                                          .replaceAll(',', ', '),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    wordSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${homeController.isSearch.value ? homeController.searchitems[i].price : homeController.items[i].price}Ks",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
