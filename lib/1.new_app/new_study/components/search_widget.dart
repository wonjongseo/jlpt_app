import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class NewSearchWidget extends StatelessWidget {
  const NewSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return Stack(
      children: [
        Card(
          child: Form(
            child: SizedBox(
              height: 60,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: userController.textEditingController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: ' Looking for...',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          right: 60,
          child: Align(
            alignment: Alignment.centerRight,
            child: GetBuilder<UserController>(builder: (userController) {
              return DropdownButton(
                  value: userController.selectedDropDownItem,
                  items: const [
                    DropdownMenuItem(value: 'japanese', child: Text('일본어')),
                    DropdownMenuItem(value: 'kangi', child: Text('한자')),
                    DropdownMenuItem(value: 'grammar', child: Text('문법'))
                  ],
                  onChanged: (v) {
                    userController.changeDropDownButtonItme(v);
                  });
            }),
          ),
        ),
        Positioned.fill(
          right: 10,
          child: Align(
            alignment: Alignment.centerRight,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              color: Colors.cyan.shade700,
              child: InkWell(
                onTap: () {
                  userController.sendQuery();
                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
