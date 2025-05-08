enum BLTextSize {
  medium, //normal size text
  bold, //only bold text
  boldMedium, //bold with medium
  boldLarge, //bold with large
  extraLarge //extra large
}

enum BLTextAlign {
  left, //ESC_ALIGN_LEFT
  center, //ESC_ALIGN_CENTER
  right, //ESC_ALIGN_RIGHT
}

extension PrintSize on BLTextSize {
  int get val {
    switch (this) {
      case BLTextSize.medium:
        return 0;
      case BLTextSize.bold:
        return 1;
      case BLTextSize.boldMedium:
        return 2;
      case BLTextSize.boldLarge:
        return 3;
      case BLTextSize.extraLarge:
        return 4;
      default:
        return 0;
    }
  }
}

extension PrintAlign on BLTextAlign {
  int get val {
    switch (this) {
      case BLTextAlign.left:
        return 0;
      case BLTextAlign.center:
        return 1;
      case BLTextAlign.right:
        return 2;
      default:
        return 0;
    }
  }
}
