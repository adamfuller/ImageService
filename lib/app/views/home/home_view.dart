part of app;

class HomeView extends StatefulWidget {
  final bool isHome;
  final DateTime date;
  HomeView({this.isHome=true, this.date});
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel vm;

  @override
  void initState() {
    vm = HomeViewModel(() {
      setState(() {});
    }, date: widget.date);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String dateString = "";
    if (widget.date != null){
      dateString = " - " + DateFormat("d MMM y").format(widget.date);
    }
    return Scaffold(
      key: vm.scaffoldKey,
      appBar: AppBar(
        title: Text("Chores" + dateString),
        backgroundColor: Colors.blueGrey,
      ),
      endDrawer: widget.isHome ? _getEndDrawer(context) : null,
      body: vm.isLoading ? Loading() : _getBody(),
    );
  }

  Widget _getBody() {
    return Center(
      child: SmartRefresher(
        enablePullDown: true,
        controller: vm.refreshController,
        header: WaterDropHeader(),
        onRefresh: vm.init,
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return RoundedCard(
                child: ListTile(
                  title: Text("Test"),
                  subtitle: Text("Test"),
                  trailing: Text("Test"),
                ),
              );
            }),
      ),
    );
  }

  Widget _getEndDrawer(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 3 / 4,
      height: MediaQuery.of(context).size.height,
      color: Colors.white60,
      child: Center(
        child: ListView(
          children: [
            Text("Hello", textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

}
