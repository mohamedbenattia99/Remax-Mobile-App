
class Demande  {
  static int n=1;
  String id;
  dynamic code ;
  String cin;
  String first_name;
  String last_name;
  String phone;
  String email;
  String gender ;
  String adress;
  int phase ;
  String image;
  String type;
  int completed;
  String agent ;
  String affiliateName ;
  String created_at;
  String updated_at;
  double longitude ;
  double latitude ;
  String client_id;
  String parent_company_id;
  String affiliate_id;
  Demande.fromJson(Map<String,dynamic> json,{String name}){
   id =json["id"];
   cin = json["cin"];
   code = json["code"];
   agent = json["agent"];
   first_name = json["first_name"];
   last_name = json["last_name"];
   phone = json["phone"];
   affiliateName= json["affiliate"] !=null ?json["affiliate"]["affiliate_details"]["affiliate_name"] : "non assigné" ;
   email = json["email"];
  if(json["order_address"] != null ){
     adress = json["order_address"]["address"];
     this.longitude = json["order_address"]["longitude"];
     this.latitude = json["order_address"]["latitude"];
     }
    phase  =  json["phase"] is int ? json["phase"]:  int.parse(json["phase"]);
   image = json["image"];
   type = json["type"];
   gender = json["gender"];
   print(gender);
  completed = json["completed"] is int ? json["completed"]:  int.parse(json["completed"]);
   created_at = json["created_at"];
   updated_at = json["updated_at"];
   client_id = json["client_id"];
   parent_company_id = json["parent_company_id"];
   affiliate_id = json["affiliate_id"];
  }
  Demande(String cin, String name, String surname, String phoneNumber, String email, String adresse,String image,String type,String id){
    this.cin=cin;
    this.id = id ;
    this.first_name=name;
    this.last_name=surname;
    this.phone=phoneNumber;
    this.email=email;
    this.adress=adresse;
    this.phase=0;
    this.image=image;
    this.type=type;
  }

  int getStatus(){
    return this.phase;
  }

  @override
  String toString() {
    return created_at;
  }

  void setStatus(int phase){
    this.phase=phase;
  }
}
