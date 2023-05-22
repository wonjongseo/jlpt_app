// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:japanese_voca/common/skeleton.dart';

// class NetworkImageWithLoader extends StatelessWidget {
//   const NetworkImageWithLoader(
//     this.src, {
//     super.key,
//     this.radius = 16,
//     this.fit = BoxFit.cover,
//     this.borderRadius,
//   });
//   final BoxFit fit;
//   final String src;
//   final double radius;
//   final BorderRadius? borderRadius;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
//       child: CachedNetworkImage(
//         fit: fit,
//         imageUrl: src,
//         placeholder: (context, url) => const Skeleton(),
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//         imageBuilder: (context, imageProvider) => Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(image: imageProvider, fit: fit),
//           ),
//         ),
//       ),
//     );
//   }
// }
