part of app;

class HomeViewModel {
  //
  // Private members
  //
  List<StreamSubscription> _listeners;

  //
  // Public Properties
  //
  Function onDataChanged;
  bool isLoading = true;
  DateTime date;

  RefreshController refreshController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  //
  // Getters
  //

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
        initialRefresh: false, initialRefreshStatus: RefreshStatus.completed);
    // await _getChores();

    this.isLoading = false;
    // print("Done with init");
    onDataChanged();
    refreshController.loadComplete();
    refreshController.refreshCompleted(resetFooterState: true);
  }

  void openSideMenuPressed(BuildContext context) {
    scaffoldKey.currentState.openEndDrawer();
  }

  void datePressed(BuildContext context) {

  }

  //
  // Private functions
  //
  void _attachListeners() {
    if (this._listeners == null) {
      this._listeners = [];
    }
  }



  //
  // Dispose
  //
  void dispose() {
    this._listeners?.forEach((_) => _.cancel());
  }


}
