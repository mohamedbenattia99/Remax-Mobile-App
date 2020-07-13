class PrepStep {
  static int id = 1;

  String name;
  String shortDescription;
  String date;
  int number;
  bool isFinished;
  bool checkbox;

  PrepStep(String name, String shortDescription, String date, bool checkbox) {
    this.shortDescription = shortDescription;
    this.date = date;
    this.number = id++;
    this.isFinished = false;
    this.name = name;
    this.checkbox=checkbox;
  }
}