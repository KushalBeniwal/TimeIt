class Templates{
  int id;
  String temps;

  tempMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['temps'] = temps;

    return mapping;
  }
}
