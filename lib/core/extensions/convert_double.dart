double toDouble(dynamic value) {
  if (value is int) {
    return double.parse(value.toString());
  } else {
    return value;
  }
}
