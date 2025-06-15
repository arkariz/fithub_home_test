import 'package:fithub_home_test/core/network/flavor/network_flavor.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DImage extends StatelessWidget {
  const DImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.scale = 1,
    this.fit,
  });

  final String path;
  final double? width;
  final double? height;
  final double scale;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      GetIt.I<NetworkFlavor>().imageBaseUrl + path,
      width: width,
      height: height,
      scale: scale,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Image.asset('assets/no-image.png'),
    );
  }
}
