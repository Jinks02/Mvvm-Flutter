import 'package:flutter/material.dart';

import '../app_colors.dart';


class RoundButton extends StatelessWidget {
  late final String title;
  late final bool loading;
  late final VoidCallback onPressed;

  RoundButton(
      {required this.title, this.loading = false, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        width: 200,
        child: Center(
          child: loading
              ? CircularProgressIndicator()
              : Text(
                  title,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
        ),
      ),
    );
  }
}
