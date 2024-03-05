import 'package:ecomapp/common/widgets/appBar/appbar.dart';
import 'package:ecomapp/common/widgets/products/cart_menu_icon.dart';
import 'package:ecomapp/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .apply(color: Colors.grey),
          ),
          Text(
            TTexts.homeAppbarSubTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: Colors.white),
          )
        ],
      ),
      actions: [
        TCartCounterIcon(
          onPressed: () {},
        )
      ],
    );
  }
}
