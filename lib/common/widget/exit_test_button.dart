import 'package:flutter/material.dart';

import '../common.dart';
import 'dimentions.dart';

class ExitTestButton extends StatelessWidget {
  const ExitTestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width90,
      height: Responsive.height60,
      child: ElevatedButton(
        child: Text(
          '나가기',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.width16,
          ),
        ),
        onPressed: () => getBacks(3),
      ),
    );
  }
}
