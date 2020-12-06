part of app;

class HomeView extends StatefulWidget {
  final bool isHome;
  final DateTime date;

  HomeView({this.isHome = true, this.date});

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
    return Scaffold(
      key: vm.scaffoldKey,
      appBar: AppBar(
        title: Text("Photos"),
        backgroundColor: Colors.blueGrey,
      ),
      endDrawer: widget.isHome ? _getEndDrawer(context) : null,
      body: vm.isLoading ? Loading() : _getBody(),
    );
  }

  Widget _getBody() {
    int crossAxisMax = MediaQuery.of(context).size.width~/128;
    return Center(
      child: SmartRefresher(
        enablePullDown: true,
        controller: vm.refreshController,
        header: WaterDropHeader(),
        onRefresh: vm.init,
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisMax),
          itemCount: 7,
          itemBuilder: (context, index) {
            return RoundedCard(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  // width: MediaQuery.of(context).size.width / 5,
                  // height: MediaQuery.of(context).size.height / 5,
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://icdn5.digitaltrends.com/image/digitaltrends/fromsmallton-768x768.jpg",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            );
          },
        ),
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
            Text(
              "Hello",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
