// // To parse this JSON data, do
// //
// //     final paymentModel = paymentModelFromJson(jsonString);

// import 'dart:convert';

// PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

// String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

// class PaymentModel {
//   List<PaymentMethod>? paymentMethod;

//   PaymentModel({
//     this.paymentMethod,
//   });

//   factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
//     paymentMethod: json["payment_method"] == null ? [] : List<PaymentMethod>.from(json["payment_method"]!.map((x) => PaymentMethod.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "payment_method": paymentMethod == null ? [] : List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
//   };
// }

// class PaymentMethod {
//   String? payMode;
//   List<String>? payMethods;

//   PaymentMethod({
//     this.payMode,
//     this.payMethods,
//   });

//   factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
//     payMode: json["pay_mode"],
//     payMethods: json["pay_methods"] == null ? [] : List<String>.from(json["pay_methods"]!.map((x) => x)),
//   );

//   Map<String, dynamic> toJson() => {
//     "pay_mode": payMode,
//     "pay_methods": payMethods == null ? [] : List<dynamic>.from(payMethods!.map((x) => x)),
//   };
// }


// Map<String,dynamic> payResponse = {
//   "payment_method": [
//     {
//       "pay_mode": "Cash",
//       "pay_methods": ["Cash"]
//     },
//     {
//       "pay_mode": "MPay",
//       "pay_methods": ["BKash", "Nagad"]
//     },
//     {
//       "pay_mode": "Card",
//       "pay_methods": ["Visa", "MasterCard"]
//     },
//     {
//       "pay_mode": "Mobile Banking",
//       "pay_methods": ["Rocket", "Upay"]
//     }
//   ]
// };