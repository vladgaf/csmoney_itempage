import 'dart:convert';
import 'dart:io';

class ItemContext {
  ItemContext({
    required this.itemWeaponLabel,
    required this.itemNameLabel,
    required this.stickersCount,
    required this.itemStickerLink,
    required this.itemStickerOverpay,
    required this.itemPrice,
    required this.itemOverPricePercent,
    required this.itemFloatValue,
    required this.itemPattern,
    required this.itemRarity,
  });

  final String itemWeaponLabel;
  final String itemNameLabel;
  final int stickersCount;
  final String itemStickerLink;
  final String itemStickerOverpay;
  final String itemPrice;
  final String itemOverPricePercent;
  final double itemFloatValue;
  final int itemPattern;
  final String itemRarity;

  factory ItemContext.fromJson(Map<String, dynamic> data) {
    // note the explicit cast to String
    // this is required if robust lint rules are enabled
    final weaponLabel = data['itemWeaponLabel'] as String;
    final nameLabel = data['itemNameLabel'] as String;
    final stickers = data['stickersCount'] as int;
    final stickerLink = data['itemStickerLink'] as String;
    final stickerOverpay = data['itemStickerOverpay'] as String;
    final price = data['itemPrice'] as String;
    final overPricePercent = data['itemOverPricePercent'] as String;
    final floatValue = data['itemFloatValue'] as double;
    final pattern = data['itemPattern'] as int;
    final rarity = data['itemRarity'] as String;

    return ItemContext(
        itemWeaponLabel: weaponLabel,
        itemNameLabel: nameLabel,
        stickersCount: stickers,
        itemStickerLink: stickerLink,
        itemStickerOverpay: stickerOverpay,
        itemPrice: price,
        itemOverPricePercent: overPricePercent,
        itemFloatValue: floatValue,
        itemPattern: pattern,
        itemRarity: rarity);
  }
}
