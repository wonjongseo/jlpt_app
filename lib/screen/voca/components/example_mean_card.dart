import 'package:flutter/material.dart';

class ExampleMeanCard extends StatefulWidget {
  ExampleMeanCard({
    Key? key,
    required this.example,
    required this.exampleList,
    required this.exampleIndex,
    required this.index,
  }) : super(key: key);

  // final WordApiDatasource wordApiDatasource = WordApiDatasource();
  final String example;
  final List<String> exampleList;
  final int exampleIndex;
  final int index;

  @override
  State<ExampleMeanCard> createState() => _ExampleMeanCardState();
}

class _ExampleMeanCardState extends State<ExampleMeanCard> {
  late Widget meanText = Text('');
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () async {
            setState(() {
              meanText = SizedBox(
                width: MediaQuery.of(context).size.width - 150,
                child: const LinearProgressIndicator(),
              );
            });
            String tmp = 'tmp';
            //     await widget.wordApiDatasource.getWordMean(widget.example);
            setState(() {
              meanText =
                  Text(tmp, style: Theme.of(context).textTheme.bodySmall);
            });
          },
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: List.generate(
                    widget.exampleList.length,
                    (index) => index == widget.exampleIndex
                        ? TextSpan(
                            text: '${widget.exampleList[index]} ',
                            style: const TextStyle(color: Colors.redAccent),
                          )
                        : TextSpan(
                            text: '${widget.exampleList[index]} ',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        meanText,
        const SizedBox(height: 15),
      ],
    );
  }
}
