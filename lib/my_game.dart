import 'package:color_switch_game/circle_rotator.dart';
import 'package:color_switch_game/ground.dart';
import 'package:color_switch_game/player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame with TapCallbacks {
  late Player myPlayer;
  List<Color> gameColors;

  MyGame(
      {this.gameColors = const [
        Colors.redAccent,
        Colors.purpleAccent,
        Colors.blueAccent,
        Colors.yellowAccent,
      ]})
      : super(
            camera:
                CameraComponent.withFixedResolution(width: 600, height: 1000));

  @override
  Color backgroundColor() => const Color(0xff222222);

  @override
  void onMount() {
    world.add(Ground(position: Vector2(0, 400)));
    world.add(myPlayer = Player(position: Vector2(0, 250)));
    generateGameComponents();
    super.onMount();
  }

  @override
  void update(double dt) {
    final cameraY = camera.viewfinder.position.y;
    final playerY = myPlayer.position.y;
    if (playerY < cameraY) {
      camera.viewfinder.position = Vector2(0, playerY);
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }

  void generateGameComponents() {
    world
        .add(CircleRotator(position: Vector2(0, 100), size: Vector2(200, 200)));
  }
}
