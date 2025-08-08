import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String? text;
  Color? bgColor;
  VoidCallback? ontap;
  BoxBorder? border;
  BorderRadiusGeometry? borderRadius;
  double? height;
  double? width;
  Widget? child;
  RxBool isLoading;
  Gradient? gradient;
  CustomButton({
    super.key,
    this.text,
    this.bgColor,
    this.ontap,
    this.border,
    this.borderRadius,
    this.height,
    this.width,
    this.child,
    required this.isLoading,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height ?? 55,
        alignment: Alignment.center,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          color: bgColor ?? AppColors.primaryColor,
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Obx(() {
          return isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : child ?? Text(text.toString(), style: Get.textTheme.bodyMedium);
        }),
      ),
    );
  }
}
