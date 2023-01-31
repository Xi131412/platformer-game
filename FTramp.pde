class Ftramp extends FGameObject {
  Ftramp(float x, float y) {
    super();
    setPosition(x, y);
    setName("tramp");
    attachImage(trampo);
    setStatic(true);
  }
  void act() {
    if (isTouching("plr")) {
      plr.setVelocity(plr.getVelocityX(), -1000);
    }
  }
}
