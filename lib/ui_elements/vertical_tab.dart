import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

/// Detect TabBar Status, isOnTap = is to check TabBar is on Tap or not, isOnTapIndex = is on Tap Index
class VerticalScrollableTabBarStatus {
  static bool isOnTap = false;
  static int isOnTapIndex = 0;

  static void setIndex(int index) {
    VerticalScrollableTabBarStatus.isOnTap = true;
    VerticalScrollableTabBarStatus.isOnTapIndex = index;
  }
}

/// VerticalScrollPosition = is ann Animation style from scroll_to_index plugin's preferPosition,
/// It's show the item position in listView.builder
enum VerticalScrollPosition { begin, middle, end }

class VerticalScrollableTabView extends StatefulWidget {
  /// TabBar Controller to let widget listening TabBar changed
  final TabController _tabController;

  /// Required a List<dynamic> Type，you can put your data that you wanna put in item
  final List<dynamic> _listItemData;

  /// A callback that return an Object inside _listItemData and the index of ListView.Builder
  final Widget Function(dynamic aaa, int index) _eachItemChild;

  /// VerticalScrollPosition = is ann Animation style from scroll_to_index,
  /// It's show the item position in listView.builder
  final VerticalScrollPosition _verticalScrollPosition;

   const VerticalScrollableTabView(
      {Key? key,
        required TabController tabController,
        required List<dynamic> listItemData,
        required Widget Function(dynamic aaa, int index) eachItemChild,
        VerticalScrollPosition verticalScrollPosition =
            VerticalScrollPosition.begin})
      :_tabController = tabController,
        _listItemData = listItemData,
        _eachItemChild = eachItemChild,
        _verticalScrollPosition = verticalScrollPosition,
         super(key: key);

  @override
  _VerticalScrollableTabViewState createState() =>
      _VerticalScrollableTabViewState();
}

class _VerticalScrollableTabViewState extends State<VerticalScrollableTabView>
    with SingleTickerProviderStateMixin {
  /// Instantiate scroll_to_index
  late AutoScrollController scrollController;

  /// When the animation is started, need to pause onScrollNotification to calculate Rect
  bool pauseRectGetterIndex = false;

  /// Instantiate RectGetter
  final listViewKey = RectGetter.createGlobalKey();

  /// To save the item's Rect
  Map<int, dynamic> itemsKeys = {};

  @override
  void initState() {
    widget._tabController.addListener(() {
      // will call two times, because 2 notifyListeners()
      // https://stackoverflow.com/questions/60252355/tabcontroller-listener-called-multiple-times-how-does-indexischanging-work
      if (VerticalScrollableTabBarStatus.isOnTap) {
        animateAndScrollTo(VerticalScrollableTabBarStatus.isOnTapIndex);
        VerticalScrollableTabBarStatus.isOnTap = false;
      }
    });
    scrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    widget._tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RectGetter(
      key: listViewKey,
      // NotificationListener
      // ScrollNotification => https://www.jianshu.com/p/d80545454944
      child: NotificationListener<ScrollNotification>(
        child: buildScrollView(),
        onNotification: onScrollNotification,
      ),
    );
  }

  Widget buildScrollView() {
    return ListView.builder(
      controller: scrollController,
      itemCount: widget._listItemData.length,
      itemBuilder: (BuildContext context, int index) {
        /// Initial Key of itemKeys
        itemsKeys[index] = RectGetter.createGlobalKey();
        return Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: buildItem(index),
        );
      },
    );
  }

  Widget buildItem(int index) {
    dynamic category = widget._listItemData[index];
    return RectGetter(
      /// when announce GlobalKey，we can use RectGetter.getRectFromKey(key) to get Rect
      key: itemsKeys[index],
      child: AutoScrollTag(
        key: ValueKey(index),
        index: index,
        controller: scrollController,
        child: widget._eachItemChild(category, index),
      ),
    );
  }
  /// Animation Function for tabBarListener
  /// This need to put inside TabBar onTap, but in this case we put inside tabBarListener
  void animateAndScrollTo(int index) async {
    // Scroll index begin pauseRectGetterIndex false ScrollNotification
    pauseRectGetterIndex = true;
    widget._tabController.animateTo(index);
    switch (widget._verticalScrollPosition) {
      case VerticalScrollPosition.begin:
        scrollController
            .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
            .then((value) => pauseRectGetterIndex = false);
        break;
      case VerticalScrollPosition.middle:
        scrollController
            .scrollToIndex(index, preferPosition: AutoScrollPosition.middle)
            .then((value) => pauseRectGetterIndex = false);
        break;
      case VerticalScrollPosition.end:
        scrollController
            .scrollToIndex(index, preferPosition: AutoScrollPosition.end)
            .then((value) => pauseRectGetterIndex = false);
        break;
    }
  }

  /// onScrollNotification of NotificationListener
  bool onScrollNotification(ScrollNotification notification) {
    if (pauseRectGetterIndex) return true;
    /// get tabBar index
    int lastTabIndex = widget._tabController.length - 1;

    List<int> visibleItems = getVisibleItemsIndex();
    /// define what is reachLastTabIndex
    bool reachLastTabIndex = visibleItems.isNotEmpty &&
        visibleItems.length <= 2 &&
        visibleItems.last == lastTabIndex;
    /// if reachLastTabIndex, then scroll to last index
    if (reachLastTabIndex) {
      widget._tabController.animateTo(lastTabIndex);
    } else {
      int sumIndex = visibleItems.reduce((value, element) => value + element);
      // 5 ~/ 2 = 2  => Result is an int
      int middleIndex = sumIndex ~/ visibleItems.length;
      if (widget._tabController.index != middleIndex) {
        widget._tabController.animateTo(middleIndex);
      }
    }
    return false;
  }
  /// getVisibleItemsIndex on Screen
  List<int> getVisibleItemsIndex() {
    // get ListView Rect
    Rect? rect = RectGetter.getRectFromKey(listViewKey);
    List<int> items = [];
    if (rect == null) return items;
    itemsKeys.forEach((index, key) {
      Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      // bottom meaning => The offset of the bottom edge of this widget from the y axis.
      // top meaning => The offset of the top edge of this widget from the y axis.
      if (itemRect.top > rect.bottom) return;
      if (itemRect.bottom < rect.top) return;
      items.add(index);
    });
    return items;
  }
}