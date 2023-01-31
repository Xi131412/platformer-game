class FLava extends FGameObject {
  FLava(float x, float y) {
    super();
    setPosition(x, y);
    attachImage(lava [frameCount%5]);
    setName("lava");
    setStatic(true);
  }

  void act() {
    attachImage(lava [frameCount%5]);
    if (isTouching("plr")) {
      plr.setPosition(100, 0);
      plr.setVelocity(0, 0);     
      live-- ;
    }
  }
}
