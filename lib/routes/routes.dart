import 'package:get/route_manager.dart';
import 'package:kozarni_ecome/binding/manage_binding.dart';
import 'package:kozarni_ecome/binding/upload_binding.dart';
import 'package:kozarni_ecome/screen/check_out_screen.dart';
import 'package:kozarni_ecome/screen/detail_screen.dart';
import 'package:kozarni_ecome/screen/home_screen.dart';
import 'package:kozarni_ecome/screen/item_upload_screen.dart';
import 'package:kozarni_ecome/screen/manage_item.dart';
import 'package:kozarni_ecome/screen/purchase_screen.dart';

const String homeScreen = '/home';
const String checkOutScreen = '/checkout';
const String detailScreen = '/detail';
const String uploadItemScreen = '/uploadItemScreen';
const String mangeItemScreen = '/manage-item';
const String purchaseScreen = '/purchase-screen';


List<GetPage> routes = [
  GetPage(
    name: homeScreen,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: checkOutScreen,
    page: () => CheckOutScreen(),
  ),
  GetPage(
    name: detailScreen,
    page: () => DetailScreen(),
  ),
  GetPage(
    name: uploadItemScreen,
    page: () => UploadItem(),
    binding: UploadBinding(),
  ),
  GetPage(
    name: mangeItemScreen,
    page: () => ManageItem(),
    binding: ManageBinding(),
  ),
  GetPage(
    name: purchaseScreen,
    page: () => PurchaseScreen(),
  ),

];
