import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'world_collidable.dart';


class Player extends SpriteAnimationComponent with HasGameRef, Hitbox,
    Collidable {
  Player()
      : super(
    size: Vector2.all(50.0),
  ) {
    addHitbox(HitboxRectangle());
  }
  final double _playerSpeed = 300.0;
  Direction direction = Direction.none;
  double _animationSpeed = 0.15;
  SpriteAnimation?  _runDownAnimation;
  SpriteAnimation? _runLeftAnimation;
  SpriteAnimation? _runUpAnimation;
  SpriteAnimation? _runRightAnimation;
  SpriteAnimation? _standingAnimation;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;



  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0)
    );
    final idleSheet = SpriteSheet(
        image: await gameRef.images.load('Idle.png'),
        srcSize: Vector2(29.0, 32.0)
    );

    // TODO down animation
    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    // TODO left animation
    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    _runUpAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);

    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    _standingAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 1);

  }


  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(-delta * _playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }

  void moveUp(double delta) {
    position.add(Vector2(0, -delta * _playerSpeed));
  }
  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if(canPlayerMoveUp()) {
          animation = _runUpAnimation;
          moveUp(delta);
        }
        break;
      case Direction.down:
        if(canPlayerMoveDown()) {
          animation = _runDownAnimation;
          moveDown(delta);
        }
        break;
      case Direction.left:
        if(canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if(canPlayerMoveRight()) {
          animation = _runRightAnimation;
          moveRight(delta);
        }
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
    }
    @override
    void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
      // TODO 1
      if (other is WorldCollidable) {
        if (!_hasCollided) {
          _hasCollided = true;
          _collisionDirection = direction;
        }
      }

    }


    @override
    void onCollisionEnd(Collidable other) {
      // TODO 2
      _hasCollided = false;

    }

  }
  @override
  Future<void> onLoad() async {
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

}
