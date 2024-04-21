String addZeros(String dateTime, bool isClock) {
  if (isClock) {
    final parts = dateTime.split(':');
    return '${parts[0].length < 2 ? '0' : ''}${parts[0]}:${parts[1].length < 2 ? '0' : ''}${parts[1]}';
  } else {
    if (dateTime.contains('.')) {
      final parts = dateTime.split('.');
      return '${parts[0].length < 2 ? '0' : ''}${parts[0]}.${parts[1].length < 2 ? '0' : ''}${parts[1]}.${parts[2]}';
    }
    final parts = dateTime.split('-');
    return '${parts[0].length < 2 ? '0' : ''}${parts[0]}.${parts[1].length < 2 ? '0' : ''}${parts[1]}.${parts[2]}';
  }
}
