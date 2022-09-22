import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:minecraft/global/global_game_references.dart';

import '../resources/blocks.dart';
import 'constants.dart';

class GameMethods {
  static GameMethods get instance {
    return GameMethods();
  }

  Vector2 get blockSize {
    // return Vector2.all(getScreenSize().width / chunkWidth);
    return Vector2.all(30);
  }

  int get freeArea {
    return (chunkHeight * 0.2).toInt();
  }

  int get maxSecondarySoilExtend {
    return freeArea + 6;
  }

  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  Future<SpriteSheet> getBlockSpriteSheet() async {
    return SpriteSheet(
        image: await Flame.images
            .load("sprite_sheets/blocks/block_sprite_sheet.png"),
        srcSize: Vector2.all(60));
  }

  Future<Sprite> getSpriteFromBlock(Blocks block) async {
    SpriteSheet spriteSheet = await getBlockSpriteSheet();
    return spriteSheet.getSprite(0, block.index);
  }

  void addChunkToRightWorldChunks(List<List<Blocks?>> chunk) {
    chunk.asMap().forEach((int yIndex, List<Blocks?> value) {
      GlobalGameReference
          .instance.gameRefernce.worldData.rightWorldChunks[yIndex]
          .addAll(value);
    });
  }

  List<List<Blocks?>> getChunk(int chunkIndex) {
    List<List<Blocks?>> chunk = [];
    GlobalGameReference.instance.gameRefernce.worldData.rightWorldChunks
        .asMap()
        .forEach((int index, List<Blocks?> rowOfBlocks) {
      chunk.add(
        rowOfBlocks.sublist(
            chunkWidth * chunkIndex, chunkWidth * (chunkIndex + 1)),
      );
    });
    return chunk;
  }
}
