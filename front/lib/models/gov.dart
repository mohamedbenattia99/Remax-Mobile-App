class Gov {
  int id ;
  String name ;
   List _munics = [] ;
  List<Municipality> munics = [] ;
  Gov.fromJson(Map<String,dynamic> json){
    id = json["id"];
    name = json["name"];
    _munics = json["municipalities"];
    _munics.forEach((munic){
      munics.add(Municipality.fromJson(munic));
    });
  }
   @override
  String toString() {
  return this.name;
   }
}

class Municipality {
  String name ;
  int id ;
  int gov_id ;
    Municipality.fromJson(Map<String,dynamic> json){
    id = json["id"];
    name = json["name"];
    gov_id = json["governorate_id"];
  }
  @override
  String toString() {
    return name;
  }

}