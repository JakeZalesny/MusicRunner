import 'package:flame/game.dart';
import 'player.dart';
import '../helpers/direction.dart';
import 'world.dart';
import 'world_collidable.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';
import 'helpers/map_loader.dart';
import 'package:flame/components.dart';




class RayWorldGame extends FlameGame with HasCollidables {
  Player _player = Player();
  final World _world = World();
  final worldCollision = WorldCollidable();
  @override
  Future<void> onLoad() async {
    await add(_world);
    add(_player);
    worldCollision.addWorldCollision();
  }
  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

}
