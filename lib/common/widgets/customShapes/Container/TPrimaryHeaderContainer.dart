import 'package:ecomapp/common/widgets/customShapes/Container/TCircularContainer.dart';
import 'package:ecomapp/common/widgets/customShapes/curved_edges/curve_edges_widget.dart';
import 'package:ecomapp/features/authentication/screens/home/home_appbar.dart';
import 'package:ecomapp/utils/constants/colors.dart';
import 'package:ecomapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainerWidget extends StatelessWidget {
  const TPrimaryHeaderContainerWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                  backgroundColor: TColors.white.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                  backgroundColor: TColors.white.withOpacity(0.1),
                  // Comments Added
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  THomeAppBar(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
