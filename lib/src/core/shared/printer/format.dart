
import '../../../data/models/order_model.dart';

class ThermalPrinterFormatter {
  static const int _lineWidth = 45;
  static const int _qtyWidth = 3;
  static const int _priceWidth = 11;

  // Calculated automatically based on other values
  int get _nameWidth => _lineWidth - _qtyWidth - _priceWidth - 2;

  String formatItem(OrderDetail item) {
    final formattedLines = <String>[];

    final qty = _formatQuantity(item.quantity);
    final price = _formatPrice(item.totalTp);
    final nameLines = _wrapText(item.itemName);

    // First line: [QTY][ ][NAME..........][ ][PRICE]
    formattedLines.add(
        '$qty ${nameLines.first.padRight(_nameWidth)}$price'
    );

    // Subsequent lines: [    ][NAME.............]
    for (int i = 1; i < nameLines.length; i++) {
      formattedLines.add(
          '${' ' * (_qtyWidth + 1)}${nameLines[i]}'
      );
    }

    return formattedLines.join('\n') + '\n\n';
  }

  // Rest of the helper methods remain the same
  String _formatQuantity(int qty) {
    if (qty < 0) return ' # ';
    return qty.toString().padLeft(_qtyWidth).substring(0, _qtyWidth);
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(2).padLeft(_priceWidth);
  }

  List<String> _wrapText(String text) {
    final words = text.split(' ');
    final lines = <String>[];
    var currentLine = '';

    for (final word in words) {
      if (word.isEmpty) continue;

      final testLine = currentLine.isEmpty ? word : '$currentLine $word';

      if (testLine.length <= _nameWidth) {
        currentLine = testLine;
      } else {
        if (currentLine.isNotEmpty) lines.add(currentLine);
        currentLine = word.length > _nameWidth ? _splitWord(word) : word;
      }
    }

    if (currentLine.isNotEmpty) lines.add(currentLine);
    return lines;
  }

  String _splitWord(String word) {
    if (word.length <= _nameWidth) return word;
    return '${word.substring(0, _nameWidth - 1)}-${word.substring(_nameWidth - 1)}';
  }
}