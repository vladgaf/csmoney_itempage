// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'api/item_context.dart';
import 'api/loadcontext.dart';
import 'dart:convert';
import 'dart:io';

class ItemPage extends StatelessWidget {
  //За это можно бить по рукам, я пока не понимаю,
  //как в ItemPage засунуть контекст извне, но я пытаюсь

  //ItemContext context = getContext();

  static const itemImageLink =
      "https://community.cloudflare.steamstatic.com/economy/image/-9a81dlWLwJ2UUGcVs_nsVtzdOEdtWwKGZZLQHTxDZ7I56KU0Zwwo4NUX4oFJZEHLbXH5ApeO4YmlhxYQknCRvCo04DEVlxkKgpoor-mcjhnwMzcdD4b08-jhIWZlP_1IbzUklRc7cF4n-T--Y3nj1H6_RFkMGz6IY-TdQQ7aFiEqFnvx-q-0J65tJTOwHJh7HQr5n7VmUe00wYMMLLLYPenqg/360fx360f";
  static const itemStickerLink =
      "https://community.cloudflare.steamstatic.com/economy/image/-9a81dlWLwJ2UUGcVs_nsVtzdOEdtWwKGZZLQHTxDZ7I56KU0Zwwo4NUX4oFJZEHLbXQ9QVcJY8gulRYQV_bRvCiwMbQVg8kdFAYu6O2Pw5r7PvHfTJ94N2kk4XFz6byMujUwz9UvMQpib_F9t6h21bn_xdrNj_xddCRcgY6aQyF_lPvwPCv28FW6D4Bsg/360fx360f";
  static const stickersValue = "4";
  static const stickerOverpay = "+ ¥ 500.22";
  static const itemPrice = "¥ 2284.10";
  static const itemOverPricePercent = "+2234.5%";
  static const itemFloatValue = 0.322045205429;
  static const itemPattern = 870;
  static const itemRarity = "Засекреченное";
  static const itemCollectionImage =
      "https://wiki.cs.money/images/collections/the-gamma-2-collection.png";
  static const itemCaseImage =
      "https://steamcommunity-a.akamaihd.net/economy/image/-9a81dlWLwJ2UUGcVs_nsVtzdOEdtWwKGZZLQHTxDZ7I56KU0Zwwo4NUX4oFJZEHLbXU5A1PIYQNqhpOSV-fRPasw8rsVFx5KAVo5PSkKV4xhfGfKTgVvIXlxNPSwaOmMLiGwzgJvJMniO-Zoo_z2wXg-EVvfSmtc78HsNoy";
  static const itemCollection = "The Gamma 2 Collection";
  static const itemCase = "Gamma 2 Case";
  static const lastSold = "¥ 3.10";
  static const itemTotalOverpay = "+ ¥ 2000.88";
  static const compilationLink =
      "https://sun1-90.userapi.com/s/v1/ig2/5QEN9ktOWfUJM_9kwSAxMBJ14TiS3IdepQZ182iBb06EYqGnd4F1FuA9DnBRV6fRuf5B8oimvFL6Qu-4FfmMPOeI.jpg?size=200x200&quality=96&crop=0,0,1080,1080&ava=1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _ItemAppBar(),
        bottomSheet: _BottomItemBar(),
        body: _ItemCardBody(itemImageLink: itemImageLink));
  }
}

class _ItemAppBar extends StatelessWidget with PreferredSizeWidget {
  const _ItemAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () {},
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: const Icon(Icons.threed_rotation),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: const Icon(Icons.more_horiz),
            color: Colors.black,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}

class _ItemCardBody extends StatelessWidget {
  const _ItemCardBody({
    Key? key,
    required this.itemImageLink,
  }) : super(key: key);

  final String itemImageLink;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _itemImage(itemImage: ItemPage.itemImageLink),
          Container(
            transform: Matrix4.translationValues(0.0, -20.0, 0.0),
            child: _ItemInfo(),
          ),
        ],
      ),
    );
  }
}

class _ItemInfo extends StatelessWidget {
  const _ItemInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(34, 33, 38, 1),
          border: Border.all(
            color: Color.fromRGBO(34, 33, 38, 1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _itemNameWrapper(),
        _ItemDetailsBadges(),
        _ItemStickersWrapper(),
        _ItemFloatValueWrapper(),
        _ItemMiscInformation(),
        _ItemCollectionWrapper(),
        _ItemOverpayWrapper(),
        //График в процессе, тот что получился изначально не понравился, поэтому пока placeholder
        _ItemPriceGraph(),
        _ItemCompilatonWrapper(),
        //За это можно бить по рукам, я хз как заставить SingleChildScrollView заставить листаться дальше
        // на 125 пикселей чем контент, чтобы боттом бар подборки не закрывал
        Container(
          height: 125,
          margin: EdgeInsets.only(top: 30),
        )
      ]),
    );
  }
}

class _ItemCompilatonWrapper extends StatelessWidget {
  const _ItemCompilatonWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Подборки с этим скином",
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 253, 1),
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(46, 45, 51, 1),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Image(
                  image: NetworkImage(ItemPage.compilationLink),
                  width: 90,
                  height: 90,
                ),
                Padding(padding: EdgeInsets.only(right: 10)),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Car Set",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 253, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          'Автомобили бывают на любой вкус: комфортные, дорогие...',
                          style: TextStyle(
                              color: Color.fromRGBO(194, 193, 198, 1),
                              fontSize: 16),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                )

                // Container(
                //   height: 200,
                //   child: Text(
                //       "Автомобили есть на любой вкус: комфортные, дорогие...",
                //       style: TextStyle(
                //           color: Color.fromRGBO(194, 193, 198, 1),
                //           fontSize: 16),
                //       softWrap: true),
                // )
              ],
            ))
      ]),
    );
  }
}

class _ItemOverpayWrapper extends StatelessWidget {
  const _ItemOverpayWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(46, 45, 51, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Редкие стикеры:",
              style: TextStyle(
                  color: Color.fromRGBO(194, 193, 198, 1), fontSize: 16),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Text(ItemPage.itemTotalOverpay,
                      style: TextStyle(
                        color: Color.fromRGBO(171, 160, 229, 1),
                        fontSize: 16,
                      )),
                  IconButton(
                    onPressed: () {},
                    icon: QuestionMarkRoundedIcon(),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class _itemNameWrapper extends StatelessWidget {
  const _itemNameWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tec-9 / После полевых испытаний",
          style:
              TextStyle(color: Color.fromRGBO(194, 193, 198, 1), fontSize: 16),
        ),
        Row(
          children: [
            Text(
              "Fuel Injector",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 253, 1),
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _ItemStickersWrapper extends StatelessWidget {
  const _ItemStickersWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(46, 45, 51, 1),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Стикеры",
                    style: TextStyle(
                        color: Color.fromRGBO(191, 190, 196, 1), fontSize: 16)),
                Padding(padding: EdgeInsets.only(right: 200)),
                Text(ItemPage.stickersValue,
                    style: TextStyle(
                        color: Color.fromRGBO(191, 190, 196, 1), fontSize: 16))
              ],
            ),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  _ItemSticker(),
                  _ItemSticker(),
                  _ItemSticker(),
                  _ItemSticker(),
                ],
              )),
        ],
      ),
    );
  }
}

class _ItemFloatValueWrapper extends StatelessWidget {
  const _ItemFloatValueWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Color.fromRGBO(46, 45, 51, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: double.infinity,
      height: 140,
      child: Column(children: [
        _ItemFloatValueNumber(),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: ItemPage.itemFloatValue * 300.0),
          child: Icon(
            Icons.arrow_drop_down,
            size: 40,
            color: Color.fromRGBO(27, 27, 29, 1),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -15.0, 0.0),
          width: 300,
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          height: 10,
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color.fromRGBO(60, 130, 142, 1)),
              width: 21,
            ),
            Container(width: 24, color: Color.fromRGBO(66, 112, 3, 1)),
            Container(width: 75, color: Color.fromRGBO(87, 71, 12, 1)),
            Container(width: 30, color: Color.fromRGBO(165, 72, 2, 1)),
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(218, 69, 73, 1)),
              width: 150,
            ),
          ]),
        )
      ]),
    );
  }
}

class _ItemMiscInformation extends StatelessWidget {
  const _ItemMiscInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(46, 45, 51, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Паттерн:",
                  style: TextStyle(
                      color: Color.fromRGBO(194, 193, 198, 1), fontSize: 16),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Text(
                        ItemPage.itemPattern.toString(),
                        style: TextStyle(
                            color: Color.fromRGBO(194, 193, 198, 1),
                            fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: QuestionMarkRoundedIcon(),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Редкость:",
                  style: TextStyle(
                      color: Color.fromRGBO(194, 193, 198, 1), fontSize: 16),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Text(
                        ItemPage.itemRarity,
                        style: TextStyle(
                            color: Color.fromRGBO(194, 193, 198, 1),
                            fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: QuestionMarkRoundedIcon(),
                      )
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemCollectionWrapper extends StatelessWidget {
  const _ItemCollectionWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Color.fromRGBO(46, 45, 51, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(children: [
        Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image(
              image: NetworkImage(ItemPage.itemCollectionImage),
              width: 30,
              height: 30,
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              ItemPage.itemCollection,
              style: TextStyle(
                  color: Color.fromRGBO(194, 193, 198, 1), fontSize: 16),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image(
              image: NetworkImage(ItemPage.itemCaseImage),
              width: 30,
              height: 30,
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              ItemPage.itemCase,
              style: TextStyle(
                  color: Color.fromRGBO(194, 193, 198, 1), fontSize: 16),
            ),
          ],
        )
      ]),
    );
  }
}

class _ItemPriceGraph extends StatelessWidget {
  const _ItemPriceGraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Изменения цены",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 253, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Padding(padding: EdgeInsets.only(right: 20)),
                Text(
                  "Последняя продажа",
                  style: TextStyle(
                      color: Color.fromRGBO(145, 144, 149, 1),
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Text(
                  ItemPage.lastSold,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 253, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 200,
              color: Color.fromRGBO(46, 45, 51, 1),
              child: Placeholder(
                color: Color.fromRGBO(145, 144, 149, 1),
              ),
            )
          ],
        ));
  }
}

class _BottomItemBar extends StatelessWidget {
  const _BottomItemBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Container(
      width: double.infinity,
      height: 125,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Color.fromRGBO(46, 45, 50, 1),
          border: Border.all(color: Color.fromRGBO(34, 33, 39, 1))),
      child: Column(children: [_ItemPriceBottom(), _ItemControlButtonsBar()]),
    ));
  }
}

class _ItemControlButtonsBar extends StatelessWidget {
  const _ItemControlButtonsBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: 270,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(132, 119, 211, 1)),
                onPressed: () {},
                child: Text("ДОБАВИТЬ К ОБМЕНУ"))),
        Padding(padding: EdgeInsets.only(right: 15)),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(53, 54, 59, 1)),
            onPressed: () {},
            child: Icon(
              Icons.favorite,
              color: Color.fromRGBO(39, 38, 44, 1),
            ))
      ],
    );
  }
}

class _ItemPriceBottom extends StatelessWidget {
  const _ItemPriceBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ItemPage.itemPrice,
          style: TextStyle(
              fontSize: 25,
              color: Color.fromRGBO(250, 250, 252, 1),
              fontWeight: FontWeight.w600),
        ),
        Container(
          height: 25,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(62, 53, 56, 1),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text(ItemPage.itemOverPricePercent,
              style: TextStyle(
                  color: Color.fromRGBO(243, 192, 16, 1), fontSize: 15)),
        )
      ],
    );
  }
}

class _ItemDetailsBadges extends StatelessWidget {
  const _ItemDetailsBadges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _RecommendedBanner(),
        _UnlockedBanner(),
      ],
    );
  }
}

class _ItemFloatValueNumber extends StatelessWidget {
  const _ItemFloatValueNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Float:",
            style: TextStyle(
                color: Color.fromRGBO(194, 193, 198, 1), fontSize: 16),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 50),
            child: Row(
              children: [
                Text(
                  ItemPage.itemFloatValue.toString(),
                  style: TextStyle(
                      color: Color.fromRGBO(194, 193, 198, 1), fontSize: 16),
                ),
                IconButton(
                  onPressed: () {},
                  icon: QuestionMarkRoundedIcon(),
                )
              ],
            ))
      ],
    );
  }
}

class QuestionMarkRoundedIcon extends StatelessWidget {
  const QuestionMarkRoundedIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(34, 33, 38, 1),
      ),
      child: Icon(
        Icons.question_mark,
        size: 13.0,
        color: Color.fromRGBO(113, 112, 118, 1),
      ),
    );
  }
}

class _ItemSticker extends StatelessWidget {
  const _ItemSticker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image2 = Image(
        image: NetworkImage(ItemPage.itemStickerLink), width: 75, height: 75);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color.fromRGBO(55, 54, 60, 1),
      ),
      width: 100,
      height: 100,
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          image2,
          Text(ItemPage.stickerOverpay,
              style: TextStyle(
                  color: Color.fromRGBO(171, 160, 229, 1),
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _RecommendedBanner extends StatelessWidget {
  const _RecommendedBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      height: 30,
      width: 150,
      decoration: BoxDecoration(
          color: Color.fromRGBO(34, 40, 38, 1),
          border: Border.all(
            color: Color.fromRGBO(34, 40, 38, 1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.thumb_up,
              color: Color.fromRGBO(126, 191, 123, 1), size: 15.0),
          Padding(padding: EdgeInsets.only(right: 10)),
          Text(
            "Рекомендуем",
            style: TextStyle(color: Color.fromRGBO(126, 191, 123, 1)),
          )
        ],
      ),
    );
  }
}

class _UnlockedBanner extends StatelessWidget {
  const _UnlockedBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      height: 30,
      width: 180,
      decoration: BoxDecoration(
          color: Color.fromRGBO(34, 40, 38, 1),
          border: Border.all(
            color: Color.fromRGBO(34, 40, 38, 1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock, color: Color.fromRGBO(126, 191, 123, 1), size: 15.0),
          Padding(padding: EdgeInsets.only(right: 10)),
          Text(
            "Разблокирован",
            style: TextStyle(color: Color.fromRGBO(126, 191, 123, 1)),
          ),
          Padding(padding: EdgeInsets.only(right: 3)),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(34, 33, 38, 1),
            ),
            child: Icon(
              Icons.question_mark,
              size: 13.0,
              color: Color.fromRGBO(126, 191, 123, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _itemImage extends StatelessWidget {
  const _itemImage({
    Key? key,
    required this.itemImage,
  }) : super(key: key);

  final String itemImage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
            0,
            1
          ],
              colors: const [
            Color.fromRGBO(74, 31, 77, 1),
            Color.fromRGBO(26, 21, 27, 1)
          ])),
      //child:
      child: Column(children: [
        Padding(padding: EdgeInsets.only(top: 30)),
        Image(image: NetworkImage(itemImage))
      ]),
    ));
  }
}
