class Fbridge extends FGameObject {

  Fbridge(float x, float y) {
    super();
    setPosition(x, y);
    setName("bridge");
    attachImage(bridge);
    setStatic(true);
    setFriction(4);
  }

  void act() {
    if (isTouching("plr")) {
      setStatic(false);
      setSensor(true);
    }
  }
}
