part of database;

class ImageModel {
  static const int _ID_LENGTH = 30;

  String owner, id;
  DateTime uploadDate;
  Uint8List data;


  ImageModel({
    this.id,
    this.owner,
    this.data,
    this.uploadDate,
  }){
    this.id ??= getRandomString(_ID_LENGTH);
  }

  static Future<ImageModel> fromFile(File file) async {
    return file?.readAsBytes()?.then<ImageModel>((bytes){
      String userId = UserService.currentUserId;
      return ImageModel(
        owner:userId,
        data: bytes,
        uploadDate: DateTime.now(),
      );
    });
  }

  Map<String, dynamic> toJson() {
    return {
      "owner": this.owner,
      "id": this.id,
      "data": this.data.toList(),
      "uploadDate": this.uploadDate.toIso8601String(),
    };
  }

  static ImageModel fromJson(Map<String, dynamic> map) {
    Uint8List data = Uint8List.fromList((map["data"] as List<dynamic>)?.cast<int>());
    return ImageModel(
      owner: map["owner"] as String,
      id: map["id"] as String,
      data: data,
      uploadDate: DateTime.parse(map["uploadDate"]),
    );
  }

  static ImageModel fromString(String input) {
    if (input == null || input.length == 0){
      return null;
    }
    Map map = Map.castFrom(json.decode(input)).cast<String, dynamic>();
    return fromJson(map);
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
