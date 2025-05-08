import '../../../data/models/order_model.dart';

class MyItemFormat {
  static const int _totalWidth = 48;
  static const int _qtyWidth = 3;
  static const int _priceWidth = 10;
  static const int _nameWidth = _totalWidth - _qtyWidth - _priceWidth;

  String formatItem(OrderDetail item) {
    final lines = <String>[];
    final qty = item.quantity.toString().padRight(_qtyWidth); // left aligned
    final price = item.totalTp.toStringAsFixed(2).padLeft(_priceWidth); // right aligned
    final nameLines = _wrapName(item.itemName);

    // First line
    lines.add('$qty${nameLines.first.padRight(_nameWidth)}$price');

    // Wrapped lines
    for (int i = 1; i < nameLines.length; i++) {
      lines.add('${' ' * _qtyWidth}${nameLines[i].padRight(_nameWidth)}');
    }

    return lines.join('\n') + '\n';
  }

  List<String> _wrapName(String name) {
    final lines = <String>[];
    while (name.length > _nameWidth) {
      lines.add(name.substring(0, _nameWidth));
      name = name.substring(_nameWidth);
    }
    if (name.isNotEmpty) lines.add(name);
    return lines;
  }
}
