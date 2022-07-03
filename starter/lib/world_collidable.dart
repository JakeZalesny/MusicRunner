import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'helpers/map_loader.dart';

class WorldCollidable extends PositionComponent
    with HasGameRef, Hitbox, Collidable {
  WorldCollidable() {
    addHitbox(HitboxRectangle());
  }

  void addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

}
