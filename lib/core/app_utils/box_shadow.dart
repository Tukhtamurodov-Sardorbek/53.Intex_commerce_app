import 'package:flutter/material.dart';
import 'app_colors.dart';

BoxShadow appBoxShadowCard(){
  return BoxShadow(
    color: AppColors.black.withOpacity(0.25),
    spreadRadius: 0,
    blurRadius: 10,
    offset: const Offset(0, 5),
  );
}

BoxShadow appBoxShadowCardStatus(){
  return BoxShadow(
    color: AppColors.black.withOpacity(0.25),
    spreadRadius: 0,
    blurRadius: 6,
    offset: const Offset(0, 1),
  );
}

BoxShadow appBoxShadowCardOrder(){
  return BoxShadow(
    color: AppColors.black.withOpacity(0.25),
    spreadRadius: 0,
    blurRadius: 7,
    offset: const Offset(0, 1),
  );
}

BoxShadow appBoxShadowIcon(){
  return BoxShadow(
    color: AppColors.black.withOpacity(0.25),
    spreadRadius: 0,
    blurRadius: 10,
    offset: const Offset(0, 4),
  );
}

BoxShadow appBoxShadowTextField(){
  return BoxShadow(
    color: AppColors.black.withOpacity(0.25),
    spreadRadius: 0,
    blurRadius: 7,
    offset: const Offset(0, 0),
  );
}

BoxShadow appBoxShadowMap() {
  return BoxShadow(
    color: AppColors.black.withOpacity(0.25),
    spreadRadius: 0,
    blurRadius: 14,
    offset: const Offset(0, 0),
  );
}