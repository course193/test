class contactmodel {
  // int id;
  String avatar;
  String address;
  String email;
  String name;
  String phone;
  String title;

  contactmodel({ this.avatar, this.address,  this.email,
    this.name, this.phone, this.title});

  contactmodel.fromJSON(Map data) {
    //if (data.containsKey("id")) id = data["id"];
    if (data.containsKey("avatar")) avatar = data["avatar"];
    if (data.containsKey("address")) address = data["address"];
    if (data.containsKey("email")) email = data["email"];
    if (data.containsKey("name")) name = data["name"];
    if (data.containsKey("phone")) phone = data["phone"];
    if (data.containsKey("title")) title = data["title"];
  }
}
