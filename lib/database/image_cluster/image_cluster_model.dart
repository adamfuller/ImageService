part of database;

class ImageClusterModel {
  String owner, id, nextClusterId;
  int index;
  List<String> imageIds;

  ImageClusterModel({
    this.id,
    this.owner,
    this.nextClusterId,
    this.index,
    this.imageIds,
  });

  Map<String, dynamic> toJson() {
    return {
      "owner": this.owner,
      "id": this.id,
      "index": this.index,
      "nextClusterId": this.nextClusterId,
      "imageIds": this.imageIds,
    };
  }

  static ImageClusterModel fromJson(Map<String, dynamic> map) {
    return ImageClusterModel(
      owner: map["owner"] as String,
      id: map["id"] as String,
      index: map["index"] as int,
      nextClusterId: map["nextClusterId"] as String,
      imageIds: (map["imageIds"] as List<dynamic>)?.cast<String>() ?? List(),
    );
  }

  static ImageClusterModel fromString(String input) {
    Map map = Map.castFrom(json.decode(input)).cast<String, dynamic>();
    return fromJson(map);
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
