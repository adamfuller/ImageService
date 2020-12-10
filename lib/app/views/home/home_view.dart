part of app;

class HomeView extends StatefulWidget {
  final DateTime date;

  HomeView({this.date});

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
        actions: [
          _getUploadButton(),
        ],
      ),
      body: vm.isLoading ? Loading() : _getBody(),
    );
  }

  Widget _getUploadButton() {
    if (vm.isUploadingImage) {
      return Loading();
    }
    return IconButton(
        icon: Icon(Icons.cloud_upload_rounded),
        onPressed: () => vm.uploadPressed(context));
  }

  Widget _getBody() {
    if (vm.user == null || vm.user.imageCount == 0 || vm.images.length == 0) {
      return Center(child: Text("No Images"));
    }
    return Center(
      child: SmartRefresher(
        enablePullDown: true,
        controller: vm.refreshController,
        header: WaterDropHeader(),
        onRefresh: vm.getImages,
        child: _getImagesGrid(),
      ),
    );
  }

  Widget _getImagesGrid() {
    int crossAxisMax = MediaQuery.of(context).size.width ~/ 96;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisMax,
      ),
      itemCount: vm.user.imageIds.length,
      itemBuilder: (context, index) {
        return index >= vm.images.length
            ? RoundedCard(
                child: Loading(),
              )
            : _getImageCard(vm.images[index]);
      },
    );
  }

  Widget _getImageCard(ImageModel image){
    return RoundedCard(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          image.data,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}
