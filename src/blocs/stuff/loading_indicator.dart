import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../splash/index.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: FlipLoader(
            loaderBackground: MainColors.PRIMARY,
            iconColor: MainColors.SECONDARY,
            icon: Icons.score,
            animationType: "full_flip"),
      );
}
