import 'package:flutter/material.dart';

import '../../const/colors.dart';
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
