import 'package:flutter/material.dart';

class NewSearchWidget extends StatelessWidget {
  const NewSearchWidget(
      {super.key,
      required this.textEditingController,
      required this.onChanged});

  final TextEditingController textEditingController;

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Form(
            child: SizedBox(
              height: 60,
              child: TextFormField(
                onChanged: onChanged,
                keyboardType: TextInputType.text,
                controller: textEditingController,
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
                  print('aa');
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
