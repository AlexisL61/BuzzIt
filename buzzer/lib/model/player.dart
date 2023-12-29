class Player {
  String name = "";
  String image = "";

  Player(this.name, this.image);

  static Player fromJson(json) {
    return Player(json['name'], json['image']);
  }
}
