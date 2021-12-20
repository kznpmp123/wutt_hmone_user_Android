import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/model/item.dart';
import 'package:kozarni_ecome/model/purchase.dart';
import 'package:kozarni_ecome/model/user.dart';
import 'package:kozarni_ecome/service/api.dart';
import 'package:kozarni_ecome/service/auth.dart';
import 'package:kozarni_ecome/service/database.dart';

class HomeController extends GetxController {
  final Auth _auth = Auth();
  final Database _database = Database();
  final Api _api = Api();
  final ImagePicker _imagePicker = ImagePicker();

  final RxBool authorized = false.obs;
  final Rx<AuthUser> user = AuthUser().obs;

  final RxBool phoneState = false.obs;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verificationController = TextEditingController();

  final RxString _codeSentId = ''.obs;
  final RxInt _codeSentToken = 0.obs;

  final RxList<PurchaseItem> myCart = <PurchaseItem>[].obs;

  void addToCart(ItemModel itemModel, String color, String size) {
    try {
      final PurchaseItem _item = myCart.firstWhere(
            (item) =>
        item.id == itemModel.id && item.color == color && item.size == size,
      );
      myCart.value = myCart.map((element) {
        if (_item.id == element.id) {
          return PurchaseItem(
            element.id,
            element.count + 1,
            element.size,
            element.color,
          );
        }
        return element;
      }).toList();
    } catch (e) {
      myCart.add(PurchaseItem(itemModel.id!, 1, size, color));
    }
  }

  final RxList<ItemModel> items = <ItemModel>[].obs;

  final RxList<ItemModel> searchitems = <ItemModel>[].obs;

  final Rx<ItemModel> selectedItem = ItemModel(
      photo: '',
      name: '',
      price: 0,
      color: '',
      desc: '',
      size: '',
      star: 0,
      category: '')
      .obs;

  void setSelectedItem(ItemModel item) {
    selectedItem.value = item;
  }

  final Rx<ItemModel> editItem = ItemModel(
    photo: '',
    name: '',
    price: 0,
    color: '',
    desc: '',
    size: '',
    star: 0,
    category: '',
  ).obs;

  void setEditItem(ItemModel itemModel) {
    editItem.value = itemModel;
  }

  ItemModel getItem(String id) {
    try {
      return items.firstWhere((e) => e.id == id);
    } catch (e) {
      return ItemModel(
          photo: '',
          name: 'Stock Out',
          price: 0,
          color: '',
          desc: '',
          size: '',
          star: 0,
          category: '');
    }
  }

  List<ItemModel> getItems() => category.value == 'All'
      ? items
      : items.where((e) => e.category == category.value).toList();

  List<String> categoryList() {
    final List<String> _data = [
      'All',
    ];

    for (var i = 0; i < items.length; i++) {
      if (!_data.contains(items[i].category)) {
        _data.add(items[i].category);
      }
    }

    if (items.isEmpty) {
      _data.clear();
    }
    return _data;
  }

  List<ItemModel> pickUp() =>
      items.where((e) => e.category == 'New Products').toList();

  List<ItemModel> hot() => items.where((e) => e.category == 'Hot Sales').toList();

  void removeItem(String id) => items.removeWhere((item) => item.id == id);

  int shipping() => myCart.isEmpty ? 0 : 2500;

  void addCount(PurchaseItem p) {
    myCart.value = myCart.map((element) {
      if (element.id == p.id &&
          element.color == p.color &&
          element.size == p.size) {
        return PurchaseItem(
            element.id, element.count + 1, element.size, element.color);
      }
      return element;
    }).toList();
    update([myCart]);
  }

  void remove(PurchaseItem p) {
    bool needToRemove = false;
    myCart.value = myCart.map((element) {
      if (element.id == p.id &&
          element.color == p.color &&
          element.size == p.size) {
        if (element.count > 1) {
          return PurchaseItem(
              element.id, element.count - 1, element.size, element.color);
        }
        needToRemove = true;
        return element;
      }
      return element;
    }).toList();
    if (needToRemove) {
      myCart.removeWhere((element) =>
      element.id == p.id &&
          element.color == p.color &&
          element.size == p.size);
    }
  }

  int get subTotal {
    int price = 0;
    for (var i = 0; i < myCart.length; i++) {
      print(items.firstWhere((element) => element.id == myCart[i].id).price);
      price += items.firstWhere((element) => element.id == myCart[i].id).price *
          myCart[i].count;
    }

    return price;
  }

  final RxList<PurchaseModel> _purhcases = <PurchaseModel>[].obs;

  List<PurchaseModel> purhcases() {
    _purhcases.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
    return _purhcases;
  }

  final RxBool isLoading = false.obs;

  Future<void> proceedToPay({
    required String name,
    required String email,
    required int phone,
    required String address,
  }) async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final PurchaseModel _purchase = PurchaseModel(
        items: myCart
            .map(
                (cart) => "${cart.id},${cart.color},${cart.size},${cart.count}")
            .toList(),
        name: name,
        email: email,
        phone: phone,
        address: address,
      );

      await _database.write(
        purchaseCollection,
        data: _purchase.toJson(),
      );
      myCart.clear();
      navIndex.value = 0;
      update([myCart, navIndex]);
    } catch (e) {
      print("proceed to pay error $e");
    }
    isLoading.value = false;
  }

  Future<void> login() async {
    try {
      if (_codeSentId.value.isNotEmpty || phoneState.value) {
        await confirm();
        return;
      }
      await _auth.login(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (String verificationId, int? forceResendingToken) {
          _codeSentId.value = verificationId;
          _codeSentToken.value = forceResendingToken ?? 0;
          update([_codeSentId, _codeSentToken]);
        },
        verificationFailed: (FirebaseAuthException error) {},
      );
      phoneState.value = true;
    } catch (e) {
      print("login error $e");
    }
  }

  Future<void> confirm() async {
    try {
      await _auth.loginWithCerdential(PhoneAuthProvider.credential(
        verificationId: _codeSentId.value,
        smsCode: verificationController.text,
      ));
      _codeSentId.value = '';
      phoneState.value = false;
      phoneController.clear();
      verificationController.clear();
    } catch (e) {
      print("confirm error is $e");
    }
  }

  Future<void> logout() async {
    try {
      await _auth.logout();
    } catch (e) {
      print("logout error is $e");
    }
  }

  Future<void> uploadProfile() async {
    try {
      final XFile? _file =
      await _imagePicker.pickImage(source: ImageSource.gallery);

      if (_file != null) {
        await _api.uploadFile(
          _file.path,
          fileName: user.value.user?.uid,
          folder: profileUrl,
        );
        await _database.write(
          profileCollection,
          data: {
            'link': user.value.user?.uid,
          },
          path: user.value.user?.uid,
        );
        user.value.update(
          newProfileImage: '$baseUrl$profileUrl${user.value.user?.uid}',
        );
        update([user]);
      }
    } catch (e) {
      print("profile upload error $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    _database.watch(itemCollection).listen((event) {
      items.value =
          event.docs.map((e) => ItemModel.fromJson(e.data(), e.id)).toList();
    });
    _auth.onAuthChange().listen((_) async {
      user.value = AuthUser(user: _);
      if (_ == null) {
        authorized.value = false;
      } else {
        authorized.value = true;
        // await _database.write(
        //   userCollection,
        //   data: {
        //     'uid': _.uid,
        //     'phone': _.phoneNumber,
        //   },
        //   path: _.uid,
        // );
        final DocumentSnapshot<Map<String, dynamic>> _data =
        await _database.read(userCollection, path: _.uid);
        user.value = user.value.update(
          newIsAdmin: _data.exists,
        );
        final DocumentSnapshot<Map<String, dynamic>> _profile =
        await _database.read(profileCollection, path: _.uid);
        user.value = user.value.update(
          newProfileImage: _profile.data()?['link'],
        );
        if (user.value.isAdmin) {
          _database.watch(purchaseCollection).listen((event) {
            if (event.docs.isEmpty) {
              _purhcases.clear();
            } else {
              _purhcases.value = event.docs
                  .map((e) => PurchaseModel.fromJson(e.data(), e.id))
                  .toList();
            }
          });
        }
      }
    });
  }

  final RxInt navIndex = 0.obs;

  void changeNav(int i) {
    navIndex.value = i;
  }

  final RxString category = 'All'.obs;

  void changeCat(String name) {
    category.value = name;
  }

  final RxBool isSearch = false.obs;

  void search() => isSearch.value = !isSearch.value;

  void onSearch(String name) {
    isSearch.value = true;
    searchitems.value = items
        .where((p0) => p0.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  void clear() => isSearch.value = false;

  void searchItem(String name) {
    isSearch.value = !isSearch.value;
  }
}
