extension StringExtension on String {
  String capitalized() {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toUpperCase();
      default:
        return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    }
  }
}
