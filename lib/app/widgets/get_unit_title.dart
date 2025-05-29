String getUnitTitle(String unit, bool bigUnit) {
  String result = '';

  switch (unit) {
    case 'weight':
      if (bigUnit) {
        result = 'Kg';
      } else {
        result = 'g';
      }
      break;
    case 'volume':
      if (bigUnit) {
        result = 'Liter';
      } else {
        result = 'ml';
      }
      break;
    default:
      result = 'Pcs';
  }
  return result;
}
