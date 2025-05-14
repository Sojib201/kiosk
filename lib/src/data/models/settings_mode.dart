// import 'dart:convert'; // For JSON encoding/decoding
//
// // Utility functions for JSON conversion
// AllSettings allSettingsFromJson(String str) => AllSettings.fromJson(json.decode(str));
// String allSettingsToJson(AllSettings data) => json.encode(data.toJson());
//
// class AllSettings {
//   String? status;
//   List<ItemList>? itemList;
//   List<Category>? category;
//   List<Cuisine>? cuisinesList;
//   List<Tag>? tagsList;
//   List<PaymentMethod>? paymentMethod;
//   BranchSettings? branchSettings;
//
//   AllSettings({this.status, this.itemList, this.category, this.cuisinesList, this.tagsList, this.paymentMethod, this.branchSettings});
//
//   factory AllSettings.fromJson(Map<String, dynamic> json) => AllSettings(
//         status: json["status"],
//         itemList: json["item_list"] == null ? [] : List<ItemList>.from(json["item_list"]!.map((x) => ItemList.fromJson(x))),
//         category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
//         cuisinesList: json["cuisines_list"] == null ? [] : List<Cuisine>.from(json["cuisines_list"]!.map((x) => Cuisine.fromJson(x))),
//         tagsList: json["tags_list"] == null ? [] : List<Tag>.from(json["tags_list"]!.map((x) => Tag.fromJson(x))),
//         paymentMethod: json["payment_method"] == null ? [] : List<PaymentMethod>.from(json["payment_method"]!.map((x) => PaymentMethod.fromJson(x))),
//         branchSettings: json["branch_settings"] == null ? null : BranchSettings.fromJson(json["branch_settings"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "item_list": itemList == null ? [] : List<dynamic>.from(itemList!.map((x) => x.toJson())),
//         "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
//         "cuisines_list": cuisinesList == null ? [] : List<dynamic>.from(cuisinesList!.map((x) => x.toJson())),
//         "tags_list": tagsList == null ? [] : List<dynamic>.from(tagsList!.map((x) => x.toJson())),
//         "payment_method": paymentMethod == null ? [] : List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
//         "branch_settings": branchSettings?.toJson(),
//       };
// }
//
// class ItemList {
//   String? foodId;
//   String? foodName;
//   String? foodDescription;
//   String? itemType;
//   String? webImageUrl;
//   String? imageUrl;
//   String? kioskImageUrl;
//   String? unitType;
//   double? unitPrice;
//   double? tax;
//   double? discount;
//   List<String>? categories;
//   List<String>? cuisines;
//   List<String>? tags;
//   List<FoodPortion>? foodPortions;
//   AvailableTime? availableTime;
//   AvailableDays? availableDays;
//   AvailableType? availableType;
//   List<Addon>? addonList;
//
//   ItemList({
//     this.foodId,
//     this.foodName,
//     this.foodDescription,
//     this.itemType,
//     this.webImageUrl,
//     this.imageUrl,
//     this.kioskImageUrl,
//     this.unitType,
//     this.unitPrice,
//     this.tax,
//     this.discount,
//     this.categories,
//     this.cuisines,
//     this.tags,
//     this.foodPortions,
//     this.availableTime,
//     this.availableDays,
//     this.availableType,
//     this.addonList,
//   });
//
//   factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
//         foodId: json["food_id"],
//         foodName: json["food_name"],
//         foodDescription: json["food_description"],
//         itemType: json["item_type"],
//         webImageUrl: json["web_image_url"],
//         imageUrl: json["image_url"],
//         kioskImageUrl: json["kiosk_image_url"],
//         unitType: json["unit_type"],
//         unitPrice: json["unit_price"]?.toDouble(),
//         tax: json["tax"]?.toDouble(),
//         discount: json["discount"]?.toDouble(),
//         categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
//         cuisines: json["cuisines"] == null ? [] : List<String>.from(json["cuisines"]!.map((x) => x)),
//         tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
//         foodPortions: json["food_portions"] == null ? [] : List<FoodPortion>.from(json["food_portions"]!.map((x) => FoodPortion.fromJson(x))),
//         availableTime: json["available_time"] == null ? null : AvailableTime.fromJson(json["available_time"]),
//         availableDays: json["available_days"] == null ? null : AvailableDays.fromJson(json["available_days"]),
//         availableType: json["available_type"] == null ? null : AvailableType.fromJson(json["available_type"]),
//         addonList: json["addon_list"] == null ? [] : List<Addon>.from(json["addon_list"]!.map((x) => Addon.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "food_id": foodId,
//         "food_name": foodName,
//         "food_description": foodDescription,
//         "item_type": itemType,
//         "web_image_url": webImageUrl,
//         "image_url": imageUrl,
//         "kiosk_image_url": kioskImageUrl,
//         "unit_type": unitType,
//         "unit_price": unitPrice,
//         "tax": tax,
//         "discount": discount,
//         "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
//         "cuisines": cuisines == null ? [] : List<dynamic>.from(cuisines!.map((x) => x)),
//         "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
//         "food_portions": foodPortions == null ? [] : List<dynamic>.from(foodPortions!.map((x) => x.toJson())),
//         "available_time": availableTime?.toJson(),
//         "available_days": availableDays?.toJson(),
//         "available_type": availableType?.toJson(),
//         "addon_list": addonList == null ? [] : List<dynamic>.from(addonList!.map((x) => x.toJson())),
//       };
// }
//
// class Addon {
//   String? addonId;
//   String? addonName;
//   String? addonDescription;
//   String? webImageUrl;
//   String? imageUrl;
//   String? kioskImageUrl;
//   String? unitType;
//   double? unitPrice;
//   double? tax;
//   double? discount;
//   AvailableTime? availableTime;
//   AvailableDays? availableDays;
//   AvailableType? availableType;
//
//   Addon({
//     this.addonId,
//     this.addonName,
//     this.addonDescription,
//     this.webImageUrl,
//     this.imageUrl,
//     this.kioskImageUrl,
//     this.unitType,
//     this.unitPrice,
//     this.tax,
//     this.discount,
//     this.availableTime,
//     this.availableDays,
//     this.availableType,
//   });
//
//   factory Addon.fromJson(Map<String, dynamic> json) => Addon(
//         addonId: json["addon_id"],
//         addonName: json["addon_name"],
//         addonDescription: json["addon_description"],
//         webImageUrl: json["web_image_url"],
//         imageUrl: json["image_url"],
//         kioskImageUrl: json["kiosk_image_url"],
//         unitType: json["unit_type"],
//         unitPrice: json["unit_price"]?.toDouble(),
//         tax: json["tax"]?.toDouble(),
//         discount: json["discount"]?.toDouble(),
//         availableTime: json["available_time"] == null ? null : AvailableTime.fromJson(json["available_time"]),
//         availableDays: json["available_days"] == null ? null : AvailableDays.fromJson(json["available_days"]),
//         availableType: json["available_type"] == null ? null : AvailableType.fromJson(json["available_type"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "addon_id": addonId,
//         "addon_name": addonName,
//         "addon_description": addonDescription,
//         "web_image_url": webImageUrl,
//         "image_url": imageUrl,
//         "kiosk_image_url": kioskImageUrl,
//         "unit_type": unitType,
//         "unit_price": unitPrice,
//         "tax": tax,
//         "discount": discount,
//         "available_time": availableTime?.toJson(),
//         "available_days": availableDays?.toJson(),
//         "available_type": availableType?.toJson(),
//       };
// }
//
// class FoodPortion {
//   String? portionSize;
//   double? portionPrice;
//   double? portionTax;
//   double? portionDiscount;
//
//   FoodPortion({
//     this.portionSize,
//     this.portionPrice,
//     this.portionTax,
//     this.portionDiscount,
//   });
//
//   factory FoodPortion.fromJson(Map<String, dynamic> json) => FoodPortion(
//         portionSize: json["portion_size"],
//         portionPrice: json["portion_price"]?.toDouble(),
//         portionTax: json["portion_tax"]?.toDouble(),
//         portionDiscount: json["portion_discount"]?.toDouble(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "portion_size": portionSize,
//         "portion_price": portionPrice,
//         "portion_tax": portionTax,
//         "portion_discount": portionDiscount,
//       };
// }
//
// class AvailableTime {
//   String? availableFrom;
//   String? availableTo;
//
//   AvailableTime({
//     this.availableFrom,
//     this.availableTo,
//   });
//
//   factory AvailableTime.fromJson(Map<String, dynamic> json) => AvailableTime(
//         availableFrom: json["available_from"],
//         availableTo: json["available_to"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "available_from": availableFrom,
//         "available_to": availableTo,
//       };
// }
//
// class AvailableDays {
//   bool? sun;
//   bool? mon;
//   bool? tue;
//   bool? wed;
//   bool? thu;
//   bool? fri;
//   bool? sat;
//
//   AvailableDays({
//     this.sun,
//     this.mon,
//     this.tue,
//     this.wed,
//     this.thu,
//     this.fri,
//     this.sat,
//   });
//
//   factory AvailableDays.fromJson(Map<String, dynamic> json) => AvailableDays(
//         sun: json["sun"],
//         mon: json["mon"],
//         tue: json["tue"],
//         wed: json["wed"],
//         thu: json["thu"],
//         fri: json["fri"],
//         sat: json["sat"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "sun": sun,
//         "mon": mon,
//         "tue": tue,
//         "wed": wed,
//         "thu": thu,
//         "fri": fri,
//         "sat": sat,
//       };
// }
//
// class AvailableType {
//   bool? dinein;
//   bool? delivery;
//   bool? takeaway;
//
//   AvailableType({
//     this.dinein,
//     this.delivery,
//     this.takeaway,
//   });
//
//   factory AvailableType.fromJson(Map<String, dynamic> json) => AvailableType(
//         dinein: json["dinein"],
//         delivery: json["delivery"],
//         takeaway: json["takeaway"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "dinein": dinein,
//         "delivery": delivery,
//         "takeaway": takeaway,
//       };
// }
//
// class Category {
//   String? categoryType;
//   List<CategoryList>? categoryList;
//
//   Category({
//     this.categoryType,
//     this.categoryList,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         categoryType: json["category_type"],
//         categoryList: json["category_list"] == null ? [] : List<CategoryList>.from(json["category_list"]!.map((x) => CategoryList.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "category_type": categoryType,
//         "category_list": categoryList == null ? [] : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
//       };
// }
//
// class CategoryList {
//   String? categoryName;
//   String? imageUrl;
//   int? sortOrder;
//   String? statusType;
//
//   CategoryList({
//     this.categoryName,
//     this.imageUrl,
//     this.sortOrder,
//     this.statusType,
//   });
//
//   factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
//         categoryName: json["category_name"],
//         imageUrl: json["image_url"],
//         sortOrder: json["sort_order"],
//         statusType: json["status_type"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "category_name": categoryName,
//         "image_url": imageUrl,
//         "sort_order": sortOrder,
//         "status_type": statusType,
//       };
// }
//
// class Cuisine {
//   String? cuisineName;
//   String? imageUrl;
//   int? sortOrder;
//   String? statusType;
//
//   Cuisine({
//     this.cuisineName,
//     this.imageUrl,
//     this.sortOrder,
//     this.statusType,
//   });
//
//   factory Cuisine.fromJson(Map<String, dynamic> json) => Cuisine(
//         cuisineName: json["cuisine_name"],
//         imageUrl: json["image_url"],
//         sortOrder: json["sort_order"],
//         statusType: json["status_type"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "cuisine_name": cuisineName,
//         "image_url": imageUrl,
//         "sort_order": sortOrder,
//         "status_type": statusType,
//       };
// }
//
// class Tag {
//   String? tagName;
//   String? statusType;
//
//   Tag({
//     this.tagName,
//     this.statusType,
//   });
//
//   factory Tag.fromJson(Map<String, dynamic> json) => Tag(
//         tagName: json["tag_name"],
//         statusType: json["status_type"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "tag_name": tagName,
//         "status_type": statusType,
//       };
// }
//
// class PaymentMethod {
//   String? payMode;
//   List<String>? payMethods;
//
//   PaymentMethod({
//     this.payMode,
//     this.payMethods,
//   });
//
//   factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
//         payMode: json["pay_mode"],
//         payMethods: json["pay_methods"] == null ? [] : List<String>.from(json["pay_methods"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "pay_mode": payMode,
//         "pay_methods": payMethods == null ? [] : List<dynamic>.from(payMethods!.map((x) => x)),
//       };
// }
//
// class BranchSettings {
//   bool? payFirstEnabled;
//   bool? guestPrintEnabled;
//   bool? kitchenPrintEnabled;
//
//   BranchSettings({
//     this.payFirstEnabled,
//     this.guestPrintEnabled,
//     this.kitchenPrintEnabled,
//   });
//
//   factory BranchSettings.fromJson(Map<String, dynamic> json) => BranchSettings(
//         payFirstEnabled: json["pay_first_enabled"],
//         guestPrintEnabled: json["guest_print_enabled"],
//         kitchenPrintEnabled: json["kitchen_print_enabled"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "pay_first_enabled": payFirstEnabled,
//         "guest_print_enabled": guestPrintEnabled,
//         "kitchen_print_enabled": kitchenPrintEnabled,
//       };
// }
//
// enum TableStatus { available, reserved, cooking, ReadyToServe, paid, ordered, selected }
//
// enum orderStatus { Draft, Confirmed, Preparing, Ready, Served, Cancel, Invoiced }


import 'dart:convert'; // For JSON encoding/decoding

// Utility functions for JSON conversion
AllSettings allSettingsFromJson(String str) => AllSettings.fromJson(json.decode(str));
String allSettingsToJson(AllSettings data) => json.encode(data.toJson());

class AllSettings {
  String? status;
  List<ItemList>? itemList;
  List<Category>? category;
  List<Cuisine>? cuisinesList;
  List<Tag>? tagsList;
  PaymentMethod? paymentMethod;
  BranchSettings? branchSettings;

  AllSettings({this.status, this.itemList, this.category, this.cuisinesList, this.tagsList, this.paymentMethod, this.branchSettings});

  factory AllSettings.fromJson(Map<String, dynamic> json) => AllSettings(
    status: json["status"],
    itemList: json["item_list"] == null ? [] : List<ItemList>.from(json["item_list"]!.map((x) => ItemList.fromJson(x))),
    category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
    cuisinesList: json["cuisines_list"] == null ? [] : List<Cuisine>.from(json["cuisines_list"]!.map((x) => Cuisine.fromJson(x))),
    tagsList: json["tags_list"] == null ? [] : List<Tag>.from(json["tags_list"]!.map((x) => Tag.fromJson(x))),
    paymentMethod: json["payment_method"] == null ? null : PaymentMethod.fromJson(json["payment_method"]),
    branchSettings: json["branch_settings"] == null ? null : BranchSettings.fromJson(json["branch_settings"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "item_list": itemList == null ? [] : List<dynamic>.from(itemList!.map((x) => x.toJson())),
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
    "cuisines_list": cuisinesList == null ? [] : List<dynamic>.from(cuisinesList!.map((x) => x.toJson())),
    "tags_list": tagsList == null ? [] : List<dynamic>.from(tagsList!.map((x) => x.toJson())),
    "payment_method": paymentMethod?.toJson(),
    "branch_settings": branchSettings?.toJson(),
  };
}

class ItemList {
  String? foodId;
  String? foodName;
  String? foodDescription;
  String? itemType;
  String? webImageUrl;
  String? imageUrl;
  String? kioskImageUrl;
  String? unitType;
  double? unitPrice;
  double? tax;
  double? discount;
  List<String>? categories;
  List<String>? cuisines;
  List<String>? tags;
  List<FoodPortion>? foodPortions;
  AvailableTime? availableTime;
  AvailableDays? availableDays;
  AvailableType? availableType;
  List<Addon>? addonList;

  ItemList({
    this.foodId,
    this.foodName,
    this.foodDescription,
    this.itemType,
    this.webImageUrl,
    this.imageUrl,
    this.kioskImageUrl,
    this.unitType,
    this.unitPrice,
    this.tax,
    this.discount,
    this.categories,
    this.cuisines,
    this.tags,
    this.foodPortions,
    this.availableTime,
    this.availableDays,
    this.availableType,
    this.addonList,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
    foodId: json["food_id"],
    foodName: json["food_name"],
    foodDescription: json["food_description"],
    itemType: json["item_type"],
    webImageUrl: json["web_image_url"],
    imageUrl: json["image_url"],
    kioskImageUrl: json["kiosk_image_url"],
    unitType: json["unit_type"],
    unitPrice: json["unit_price"]?.toDouble(),
    tax: json["tax"]?.toDouble(),
    discount: json["discount"]?.toDouble(),
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    cuisines: json["cuisines"] == null ? [] : List<String>.from(json["cuisines"]!.map((x) => x)),
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    foodPortions: json["food_portions"] == null ? [] : List<FoodPortion>.from(json["food_portions"]!.map((x) => FoodPortion.fromJson(x))),
    availableTime: json["available_time"] == null ? null : AvailableTime.fromJson(json["available_time"]),
    availableDays: json["available_days"] == null ? null : AvailableDays.fromJson(json["available_days"]),
    availableType: json["available_type"] == null ? null : AvailableType.fromJson(json["available_type"]),
    addonList: json["addon_list"] == null ? [] : List<Addon>.from(json["addon_list"]!.map((x) => Addon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "food_id": foodId,
    "food_name": foodName,
    "food_description": foodDescription,
    "item_type": itemType,
    "web_image_url": webImageUrl,
    "image_url": imageUrl,
    "kiosk_image_url": kioskImageUrl,
    "unit_type": unitType,
    "unit_price": unitPrice,
    "tax": tax,
    "discount": discount,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "cuisines": cuisines == null ? [] : List<dynamic>.from(cuisines!.map((x) => x)),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "food_portions": foodPortions == null ? [] : List<dynamic>.from(foodPortions!.map((x) => x.toJson())),
    "available_time": availableTime?.toJson(),
    "available_days": availableDays?.toJson(),
    "available_type": availableType?.toJson(),
    "addon_list": addonList == null ? [] : List<dynamic>.from(addonList!.map((x) => x.toJson())),
  };
}

class Addon {
  String? addonId;
  String? addonName;
  String? addonDescription;
  String? webImageUrl;
  String? imageUrl;
  String? kioskImageUrl;
  String? unitType;
  double? unitPrice;
  double? tax;
  double? discount;
  AvailableTime? availableTime;
  AvailableDays? availableDays;
  AvailableType? availableType;

  Addon({
    this.addonId,
    this.addonName,
    this.addonDescription,
    this.webImageUrl,
    this.imageUrl,
    this.kioskImageUrl,
    this.unitType,
    this.unitPrice,
    this.tax,
    this.discount,
    this.availableTime,
    this.availableDays,
    this.availableType,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
    addonId: json["addon_id"],
    addonName: json["addon_name"],
    addonDescription: json["addon_description"],
    webImageUrl: json["web_image_url"],
    imageUrl: json["image_url"],
    kioskImageUrl: json["kiosk_image_url"],
    unitType: json["unit_type"],
    unitPrice: json["unit_price"]?.toDouble(),
    tax: json["tax"]?.toDouble(),
    discount: json["discount"]?.toDouble(),
    availableTime: json["available_time"] == null ? null : AvailableTime.fromJson(json["available_time"]),
    availableDays: json["available_days"] == null ? null : AvailableDays.fromJson(json["available_days"]),
    availableType: json["available_type"] == null ? null : AvailableType.fromJson(json["available_type"]),
  );

  Map<String, dynamic> toJson() => {
    "addon_id": addonId,
    "addon_name": addonName,
    "addon_description": addonDescription,
    "web_image_url": webImageUrl,
    "image_url": imageUrl,
    "kiosk_image_url": kioskImageUrl,
    "unit_type": unitType,
    "unit_price": unitPrice,
    "tax": tax,
    "discount": discount,
    "available_time": availableTime?.toJson(),
    "available_days": availableDays?.toJson(),
    "available_type": availableType?.toJson(),
  };
}

class FoodPortion {
  String? portionSize;
  double? portionPrice;
  double? portionTax;
  double? portionDiscount;

  FoodPortion({
    this.portionSize,
    this.portionPrice,
    this.portionTax,
    this.portionDiscount,
  });

  factory FoodPortion.fromJson(Map<String, dynamic> json) => FoodPortion(
    portionSize: json["portion_size"],
    portionPrice: json["portion_price"]?.toDouble(),
    portionTax: json["portion_tax"]?.toDouble(),
    portionDiscount: json["portion_discount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "portion_size": portionSize,
    "portion_price": portionPrice,
    "portion_tax": portionTax,
    "portion_discount": portionDiscount,
  };
}

class AvailableTime {
  String? availableFrom;
  String? availableTo;

  AvailableTime({
    this.availableFrom,
    this.availableTo,
  });

  factory AvailableTime.fromJson(Map<String, dynamic> json) => AvailableTime(
    availableFrom: json["available_from"],
    availableTo: json["available_to"],
  );

  Map<String, dynamic> toJson() => {
    "available_from": availableFrom,
    "available_to": availableTo,
  };
}

class AvailableDays {
  bool? sun;
  bool? mon;
  bool? tue;
  bool? wed;
  bool? thu;
  bool? fri;
  bool? sat;

  AvailableDays({
    this.sun,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
  });

  factory AvailableDays.fromJson(Map<String, dynamic> json) => AvailableDays(
    sun: json["sun"],
    mon: json["mon"],
    tue: json["tue"],
    wed: json["wed"],
    thu: json["thu"],
    fri: json["fri"],
    sat: json["sat"],
  );

  Map<String, dynamic> toJson() => {
    "sun": sun,
    "mon": mon,
    "tue": tue,
    "wed": wed,
    "thu": thu,
    "fri": fri,
    "sat": sat,
  };
}

class AvailableType {
  bool? dinein;
  bool? delivery;
  bool? takeaway;

  AvailableType({
    this.dinein,
    this.delivery,
    this.takeaway,
  });

  factory AvailableType.fromJson(Map<String, dynamic> json) => AvailableType(
    dinein: json["dinein"],
    delivery: json["delivery"],
    takeaway: json["takeaway"],
  );

  Map<String, dynamic> toJson() => {
    "dinein": dinein,
    "delivery": delivery,
    "takeaway": takeaway,
  };
}

class Category {
  String? categoryType;
  List<CategoryList>? categoryList;

  Category({
    this.categoryType,
    this.categoryList,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryType: json["category_type"],
    categoryList: json["category_list"] == null ? [] : List<CategoryList>.from(json["category_list"]!.map((x) => CategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_type": categoryType,
    "category_list": categoryList == null ? [] : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
  };
}

class CategoryList {
  String? categoryName;
  String? imageUrl;
  int? sortOrder;
  String? statusType;

  CategoryList({
    this.categoryName,
    this.imageUrl,
    this.sortOrder,
    this.statusType,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    categoryName: json["category_name"],
    imageUrl: json["image_url"],
    sortOrder: json["sort_order"],
    statusType: json["status_type"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "image_url": imageUrl,
    "sort_order": sortOrder,
    "status_type": statusType,
  };
}

class Cuisine {
  String? cuisineName;
  String? imageUrl;
  int? sortOrder;
  String? statusType;

  Cuisine({
    this.cuisineName,
    this.imageUrl,
    this.sortOrder,
    this.statusType,
  });

  factory Cuisine.fromJson(Map<String, dynamic> json) => Cuisine(
    cuisineName: json["cuisine_name"],
    imageUrl: json["image_url"],
    sortOrder: json["sort_order"],
    statusType: json["status_type"],
  );

  Map<String, dynamic> toJson() => {
    "cuisine_name": cuisineName,
    "image_url": imageUrl,
    "sort_order": sortOrder,
    "status_type": statusType,
  };
}

class Tag {
  String? tagName;
  String? statusType;

  Tag({
    this.tagName,
    this.statusType,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    tagName: json["tag_name"],
    statusType: json["status_type"],
  );

  Map<String, dynamic> toJson() => {
    "tag_name": tagName,
    "status_type": statusType,
  };
}
class PaymentMethod {
  List<String>? payMode;
  List<String>? othersMethod;

  PaymentMethod({
    this.payMode,
    this.othersMethod,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    payMode: json["pay_mode"] == null ? [] : List<String>.from(json["pay_mode"]!.map((x) => x)),
    othersMethod: json["others_method"] == null ? [] : List<String>.from(json["others_method"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "pay_mode": payMode == null ? [] : List<dynamic>.from(payMode!.map((x) => x)),
    "others_method": othersMethod == null ? [] : List<dynamic>.from(othersMethod!.map((x) => x)),
  };
}


// class PaymentMethod {
//   String? payMode;
//   List<String>? payMethods;
//
//   PaymentMethod({
//     this.payMode,
//     this.payMethods,
//   });
//
//   factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
//         payMode: json["pay_mode"],
//         payMethods: json["pay_methods"] == null ? [] : List<String>.from(json["pay_methods"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "pay_mode": payMode,
//         "pay_methods": payMethods == null ? [] : List<dynamic>.from(payMethods!.map((x) => x)),
//       };
// }

class BranchSettings {
  bool? payFirstEnabled;
  bool? guestPrintEnabled;
  bool? kitchenPrintEnabled;

  BranchSettings({
    this.payFirstEnabled,
    this.guestPrintEnabled,
    this.kitchenPrintEnabled,
  });

  factory BranchSettings.fromJson(Map<String, dynamic> json) => BranchSettings(
    payFirstEnabled: json["pay_first_enabled"],
    guestPrintEnabled: json["guest_print_enabled"],
    kitchenPrintEnabled: json["kitchen_print_enabled"],
  );

  Map<String, dynamic> toJson() => {
    "pay_first_enabled": payFirstEnabled,
    "guest_print_enabled": guestPrintEnabled,
    "kitchen_print_enabled": kitchenPrintEnabled,
  };
}

enum TableStatus { available, reserved, cooking, ReadyToServe, paid, ordered, selected }

enum orderStatus { Draft, Confirmed, Preparing, Ready, Served, Cancel, Invoiced }