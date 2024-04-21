num sumHistory(String name, List<dynamic> data) {
  num result = 0;
  for (var i = 0; i < data.length; i++) {
    result += data[i][name];
  }
  return result;
}
