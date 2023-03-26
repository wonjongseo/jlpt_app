// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jongseo_toeic/repository/word_api_datasource.dart';


// const  String EXAMPLE_PATH = '/example';
// class ExampleScreen extends StatefulWidget {
//   const ExampleScreen({super.key, required this.word});
  
//   final String word;

//   @override
//   State<ExampleScreen> createState() => _ExampleScreenState();
// }

// class _ExampleScreenState extends State<ExampleScreen> {

  
//   String examples = '';
//   String examplesMean = '';
//   late WordApiDatasource wordApiDatasource;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     wordApiDatasource =  WordApiDatasource();
//  }

//   @override
//   Widget build(BuildContext context) {
   

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.word),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(widget.word),
//               ElevatedButton(onPressed: () async {
//                  String tmp = await  wordApiDatasource.getWordExample(widget.word);
//                  setState(() {
//                    examples = tmp;
//                  });

//               }, child: Row(
//                 children:const [
//                    Text('Show Example'),
//                    Icon(Icons.search),
//                 ],
//               )),

//               if(examples != '')
//               Text(examples),

//               if(examples != '')
//               ElevatedButton(onPressed: ()  async{
//                 String tmp = await  wordApiDatasource.getWordMean(examples);
//                 setState(() {
//                   examplesMean = tmp;
//                 });
//               }, child: Row(
//                 children:const [
//                    Text('Show '),
//                   Icon(Icons.search),
//                 ],
//               )),
//               if(examplesMean !='') 
//               Text(examplesMean)

//             ],
//           ),
//         ),
    
//       ),
//     );
//   }
// }