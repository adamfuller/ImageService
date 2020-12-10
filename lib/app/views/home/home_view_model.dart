part of app;

class HomeViewModel {
  //
  // Private members
  //
  List<StreamSubscription> _listeners;
  ImagePicker _picker = ImagePicker();

  //
  // Public Properties
  //
  Function onDataChanged;
  bool isLoading = true;
  DateTime date;
  Set<String> ids = Set();
  List<ImageModel> images = List();
  bool isUploadingImage = false;
  Stream<ImageModel> imageStream = Stream.empty();

  RefreshController refreshController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  UserModel user;

  //
  // Getters
  //
  bool get hasImages => !(images == null || images.length == 0);

  //
  // Constructor
  //
  HomeViewModel(this.onDataChanged, {this.date}) {
    init();
  }

  //
  // Public functions
  //
  void init() async {
    if (_listeners == null) _attachListeners();

    refreshController ??= RefreshController(
      initialRefresh: false,
      initialRefreshStatus: RefreshStatus.completed,
    );

    await _getUser();
    await getImages();

    this.isLoading = false;
    // print("Done with init");
    onDataChanged();
    refreshController.loadComplete();
    refreshController.refreshCompleted(resetFooterState: true);
  }

  void openSideMenuPressed(BuildContext context) {
    scaffoldKey.currentState.openEndDrawer();
  }

  void uploadPressed(BuildContext context) async {
    PickedFile file = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 58,
    );
    if (file == null) {
      return;
    }
    ImageModel image = await ImageModel.fromFile(File(file.path));
    isUploadingImage = true;
    onDataChanged();
    ImageService.saveImage(user, image).then((e) {
      images.add(image);
      isUploadingImage = false;
      onDataChanged();
    });
  }

  Future<void> getImages() async {
    imageStream = ImageService.getImageStream(
      user,
      start: images.length - 1,
      end: user.imageCount,
    );
    imageStream.listen((image) {
      if (!ids.contains(image.id)) {
        ids.add(image.id);
        images.add(image);
        // Sort them in order of upload date
        images.sort((a, b) => a.uploadDate.compareTo(b.uploadDate));
        onDataChanged();
      }
    }, onDone: () {
      onDataChanged();
      refreshController.loadComplete();
      refreshController.refreshCompleted(resetFooterState: true);
    });
  }

  //
  // Private functions
  //
  void _attachListeners() {
    if (this._listeners == null) {
      this._listeners = [];
    }
  }

  Future<void> _getUser() async {
    this.user = await UserService.getUser(UserService.currentUserId);
    if (user == null) {
      user = UserModel(
        id: UserService.currentUserId,
        name: "DEMO",
        imageCount: 0,
        firstClusterId: "demo_cluster",
      );
      UserService.saveUser(user);
    }
  }

  //
  // Dispose
  //
  void dispose() {
    this._listeners?.forEach((_) => _.cancel());
  }
}
