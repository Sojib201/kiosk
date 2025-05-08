
import 'package:flutter/material.dart';

import '../../../../data/models/order_model.dart';
import '../../../../data/models/user_model.dart';

class ImageToPaper {}

class PrintDesign extends StatelessWidget {
  OrderSingleton ordermodel;
  User user;
  PrintDesign({super.key, required this.ordermodel, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
