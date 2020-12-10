part of database;

class ImageClusterService{
  static const String _BASE_FOLDER = "/image_service/image_clusters/";
  // static const String _DEFINITIONS_ID = "definitions";
  // static const String _DEFINITION_SEPARATOR = "#%";

  // static Future<List<ChoreModel>> getAllChores({List<ChoreDefinition> definitions}) async {
  //   definitions ??= await ChoreDefinitionService.getAllChoreDefinitions();
  //   List<ChoreModel> output = List();
  //
  //   for (ChoreDefinition definition in definitions){
  //     output.add(ChoreModel.fromDefinition(definition));
  //   }
  //
  //   return output;
  // }

  static String _imageClusterFolder(UserModel user){
    return _BASE_FOLDER + user.id;
  }

  static Future<ImageClusterModel> getCluster(UserModel user, String id){
    Completer<ImageClusterModel> output = Completer();
    String folder =_imageClusterFolder(user);

    DatabaseService.getEntry(id, folder).then((value) {
      ImageClusterModel cluster = ImageClusterModel.fromString(value);
      output.complete(cluster);
    });

    return output.future;
  }

/// Get chores based on all chore definitions
// static Future<List<ChoreModel>> _getCurrentChores() async {
//   Completer<List<ChoreModel>> output = Completer();
//   String folder = _choreModelsFolder();
//
//   ChoreDefinitionService.getAllChoreDefinitions().then((choreDefinitions) async {
//     List<ChoreModel> chores = List();
//     for (ChoreDefinition definition in choreDefinitions){
//       String data = await DatabaseService.getEntry(definition.id, folder);
//       if (data.length <= 3){
//         chores.add(ChoreModel.fromDefinition(definition));
//         storeChore(chores.last); // store this one
//         continue;
//       }
//
//       ChoreModel chore = ChoreModel.fromString(data);
//
//       if (chore == null){
//         continue;
//       }
//
//       chores.add(ChoreModel.fromString(data));
//     }
//
//     output.complete(chores);
//   }, onError: (e){
//     print(e);
//     output.complete(List());
//   });
//
//   return output.future;
// }

// static Future<List<ChoreModel>> getChores(DateTime date){
//   Completer<List<ChoreModel>> output = Completer();
//   String folder = _dateFolder(date);
//
//   DatabaseService.getEntries(folder).then((values) {
//     List<ChoreModel> chores = values.map((v) => ChoreModel.fromString(v)).toList();
//     chores.removeWhere((_) => _ == null);
//     output.complete(chores);
//   }, onError: (e){
//     print(e);
//     output.complete(List<ChoreModel>());
//   });
//
//   return output.future;
// }

// static Future<List<ChoreModel>> getCurrentChores() async {
//   Completer<List<ChoreModel>> output = Completer();
//
//   getChores(DateTime.now()).then((chores){
//     print(chores);
//     if (chores == null || chores.length == 0){
//       print("Having to get from definitions");
//       output.complete(_getCurrentChores());
//       return;
//     }
//     output.complete(chores);
//   }, onError: (e){
//     print(e);
//     output.complete(List<ChoreModel>());
//   });
//
//   return output.future;
// }

/// Stores a chore for the current day.
// static Future<bool> storeChore(ChoreModel chore) async{
//   String folder = _todayFolder();
//   print("Storing Chore: ${chore.name}, $folder, ${chore.toString()}");
//   return DatabaseService.setEntry(chore.id, folder, chore.toString());
// }

/// Delete a chore for the current day.
// static Future<bool> deleteChore(ChoreModel chore) async{
//   String folder = _todayFolder();
//   print("Deleting Chore: ${chore.name}, $folder, ${chore.toString()}");
//   return DatabaseService.deleteEntry(chore.id, folder);
// }

}