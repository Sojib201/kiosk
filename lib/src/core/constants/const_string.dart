import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class ImagerUrl {
  static const String logo = "assets/images/app_logo/app_logo.png";
  static const String tableIcon = "assets/images/icons/table.png";
  static const String pizzaIcon = "assets/images/icons/pizza.png";
  static const String defaultFoodIcon = "assets/images/icons/defaultfood.png";
  static const String filterIcon = "assets/images/icons/filter_icon.png";
  static const String cuisin = "assets/images/icons/cuisin.png";
  static const String category = "assets/images/icons/category.png";
  static const String done = "assets/animation/done_animation.json";
  static const String orderConfirm = "assets/animation/order_confirmed.json";
  static const String thankYou = "assets/animation/thankyou_like.json";

}

List<Map<String, dynamic>> tableStatuses = [
  {"color": ColorUtils.availabeTableColor, "text": "Free", "seatNumber": "0"},
  {"color": ColorUtils.reservedTableColor, "text": "Seated", "seatNumber": "0"},
  {"color": ColorUtils.orderedTableColor, "text": "Ordered", "seatNumber": "0"},
  {"color": ColorUtils.paid, "text": "Paid", "seatNumber": "0"},
  {"color": ColorUtils.cooking, "text": "Cooking", "seatNumber": "0"},
  {"color": ColorUtils.foodReady, "text": "ReadyToServe", "seatNumber": "0"},
  {"color": ColorUtils.served, "text": "Served", "seatNumber": "0"},
];
