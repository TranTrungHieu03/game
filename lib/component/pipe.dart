import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Pipe extends PositionComponent {
  Pipe({required this.isFlipped, required super.position});

  late Sprite _pipeSprite;
  final bool isFlipped;

  @override
  void onLoad() async {
    super.onLoad();
    _pipeSprite = await Sprite.load('pipe.png');
    anchor = Anchor.topCenter;
    final ratio = _pipeSprite.srcSize.y / _pipeSprite.srcSize.x;
    const width = 82.0;
    size = Vector2(width, width * ratio);
    if (isFlipped) {
      flipVertically();
    }

    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _pipeSprite.render(canvas, position: Vector2.zero(), size: size);
  }
}
