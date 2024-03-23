import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

import '../../user/controller/user_controller.dart';

class HeartCount extends StatelessWidget {
  const HeartCount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return Padding(
        padding: EdgeInsets.only(right: Responsive.height16 / 2),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Icon(
              Icons.favorite,
              color: userController.user.heartCount == 0
                  ? Colors.white.withOpacity(0.3)
                  : Colors.red,
              size: Responsive.height10 * 4.5,
            ),
            Text(
              userController.user.isPremieum
                  ? ''
                  : userController.user.heartCount.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.height10 * 1.2,
              ),
            )
          ],
        ),
      );
    });
  }
}
