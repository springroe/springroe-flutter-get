import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_get/generated/l10n.dart';
import 'package:test_get/model/goods_entity.dart';
import 'package:test_get/ui/cart/controller/cart_controller.dart';
import 'package:test_get/ui/home/controller/home_controller.dart';
import 'package:test_get/ui/navigator/model/tab_item.dart';
import 'package:test_get/utils/number_util.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();

  HomePage({Key? key}) : super(key: key);

  _onRefresh() {
    Future.delayed(const Duration(seconds: 1), () {
      HomeController.instance.fetchData();
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    });
  }

  _onLoading() {
    if (HomeController.instance.currentPage < 10) {
      HomeController.instance.loadMore();
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    _scrollController.addListener(() {
      if (_scrollController.offset >
          HomeController.instance.currentPage * height) {
        _onLoading();
      }
    });
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullUp: true,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          return mode == LoadStatus.noMore
              ? SizedBox(
                  height: 55.0,
                  child: Center(
                    child: Text(
                      S.current.hintListNoMore,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Container();
        },
      ),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(child: _header(context)),
          Obx(
            () => SliverWaterfallFlow(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _item(HomeController.instance.goods[index]);
              }, childCount: HomeController.instance.goods.length),
              gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  lastChildLayoutTypeBuilder: (index) =>
                      LastChildLayoutType.none),
            ),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 6,
          left: 16,
          right: 16,
          bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 4, color: Colors.grey[300]!),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(45),
              ),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: S.current.hintSearch,
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.grey)),
              maxLines: 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16),
            height: 200,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  HomeController.instance.bannerImages[index],
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.pink,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                _popularItem(
                  TabItem('assets/goods/ic_goods_discount.png',
                      S.current.itemDiscount),
                  () {},
                ),
                _popularItem(
                  TabItem('assets/goods/ic_goods_preference.png',
                      S.current.itemPreference),
                  () {},
                ),
                _popularItem(
                  TabItem(
                    'assets/goods/ic_goods_boutique.png',
                    S.current.itemBoutique,
                  ),
                  () {},
                ),
                _popularItem(
                  TabItem(
                    'assets/goods/ic_goods_import.png',
                    S.current.itemImport,
                  ),
                  () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _item(GoodsEntity item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              item.picture,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              item.name,
              style: const TextStyle(
                  color: Colors.pink, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Text(
              item.desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/ic_dollar.png',
                        color: Colors.pink,
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        NumberUtil.priceFormat(item.price),
                        style: const TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    CartController.instance.addCommodity(item);
                  },
                  icon: Image.asset(
                    'assets/goods/ic_cart_add.png',
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _popularItem(TabItem item, VoidCallback onTap) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            item.icon,
            width: 40,
            height: 40,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            item.name,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      ),
    ));
  }
}
