part of database;

class UserModel {
  static const int _ID_LENGTH = 30;

  String name, id, firstClusterId;
  int imageCount;
  int imageRemovalCount;
  int maxImageIndex;
  List<String> imageIds;

  UserModel({
    this.id,
    this.name,
    this.imageCount = 0,
    this.imageRemovalCount = 0,
    this.maxImageIndex = 0,
    this.firstClusterId,
    this.imageIds,
  }){
    this.id ??= getRandomString(_ID_LENGTH);
    this.imageIds ??= List();
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "id": this.id,
      "imageCount": this.imageCount,
      "imageRemovalCount": this.imageRemovalCount,
      "maxImageIndex": this.maxImageIndex,
      "firstClusterId": this.firstClusterId,
      "imageIds": this.imageIds,
    };
  }

  static UserModel fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map["name"] as String,
      id: map["id"] as String,
      imageCount: map["imageCount"] as int,
      imageRemovalCount: map["imageRemovalCount"] as int,
      maxImageIndex: map["maxImageIndex"] as int,
      firstClusterId: map["firstClusterId"] as String,
      imageIds: (map["imageIds"] as List<dynamic>)?.cast<String>() ?? List(),
    );
  }

  static UserModel fromString(String input) {
    if (input == null || input.length <= 3){
      return null;
    }
    Map map = Map.castFrom(json.decode(input)).cast<String, dynamic>();
    return fromJson(map);
  }

  @override
  String toString() {
    // DateTime now = DateTime.now();
    return jsonEncode(toJson());
  }
}
