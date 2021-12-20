import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  final HomeController controller = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        leading: Container(
          margin: EdgeInsets.only(
            top: 7,
            bottom: 10,
            left: 7,
          ),
          width: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              alignment: Alignment.center,
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              overlayColor: MaterialStateProperty.all(Colors.black12),
            ),
            onPressed: Get.back,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextFormField(
                controller: nameController,
                validator: (e) =>
                    e?.isEmpty == true ? "Name is required" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'အမည်',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextFormField(
                controller: emailController,
                validator: (e) => e?.isEmpty == true
                    ? "Email is required"
                    : e?.isEmail == true
                        ? null
                        : "Invalid email",
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextFormField(
                controller: phoneController,
                validator: (e) =>
                    e?.isEmpty == true ? "Phone is required" : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ဆက်သွယ်ရန် ဖုန်းနံပါတ်',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: TextFormField(
                controller: addressController,
                validator: (e) =>
                    e?.isEmpty == true ? "Address is required" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ပို့ဆောင်ပေးရမည့် လိပ်စာ',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () async {
                  if (_form.currentState?.validate() == true) {
                    await controller.proceedToPay(
                      name: nameController.text,
                      email: emailController.text,
                      phone: int.parse(phoneController.text),
                      address: addressController.text,
                    );
                    _form.currentState?.reset();
                    Get.back();

                    Get.snackbar("လူကြီးမင်း Order တင်ခြင်း", 'အောင်မြင်ပါသည်');
                  }
                },
                child: Obx(
                  () => controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 0.5,
                        )
                      : Text('Order တင်ရန် နှိပ်ပါ'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
