import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class HidenScreen extends StatefulWidget {
  const HidenScreen({super.key});

  @override
  State<HidenScreen> createState() => _HidenScreenState();
}

class _HidenScreenState extends State<HidenScreen> {
  UserController userController = Get.find<UserController>();

  final formKey = GlobalKey<FormState>();
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> textEditControllers =
      List.generate(4, (index) => TextEditingController());
  int curCurs = 0;

  String correctCode = '3859';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hidden Screen'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Enter the Code to change an authority.'),
              ),
              Form(
                key: formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(focusNodes.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: curCurs == index
                                ? Colors.greenAccent
                                : Colors.grey.shade100,
                            width: 2,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: textEditControllers[index],
                          maxLength: 1,
                          cursorColor: Colors.transparent,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                          keyboardType: TextInputType.number,
                          autofocus: index == 0 ? true : false,
                          focusNode: focusNodes[index],
                          onChanged: (v) {
                            if (textEditControllers[index].text.isEmpty) {
                              if (index != 0) {
                                focusNodes[index - 1].requestFocus();
                              }
                            }

                            curCurs = index;
                            setState(() {});
                            if (formKey.currentState!.validate()) {
                              if (index != 3) {
                                focusNodes[index + 1].requestFocus();
                              } else {
                                FocusManager.instance.primaryFocus?.unfocus();

                                String inputedCode = '';
                                for (TextEditingController textEditController
                                    in textEditControllers) {
                                  inputedCode += textEditController.text;
                                }
                                if (inputedCode == correctCode) {
                                  userController.changeuserPremieum(true);
                                  // Get.dialog(
                                  //   AlertDialog(
                                  //     title: Text('Success'),
                                  //     content: Container(
                                  //         child: Text('Granted authority.')),
                                  //   ),
                                  // );
                                  Get.back();
                                  Get.showSnackbar(
                                    const GetSnackBar(
                                      title: 'Success',
                                      message: 'Changed authority',
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                } else {
                                  Get.dialog(
                                    AlertDialog(
                                      content: Container(child: Text('Wrong')),
                                    ),
                                  );
                                  for (TextEditingController textEditController
                                      in textEditControllers) {
                                    textEditController.clear();
                                  }

                                  focusNodes[0].requestFocus();
                                  curCurs = 0;
                                  setState(() {});
                                }
                              }
                            }
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}
