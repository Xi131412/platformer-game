class FThwomp extends FGameObject {

  boolean isAwake;

  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    attachImage(closedtwamp);
    isAwake = false;
    setStatic(true);
    setDensity(100);
  }


  void act() {
    if (getX() + getWidth() < plr.getX()) {
      wakeUp();
    }
    if (isTouching("plr")) {
      live --;
      plr.setPosition(100, 0);
    }
  }



  void wakeUp() {
    isAwake = true;
    attachImage(opentwamp);
    setStatic(false);
  }

  void sleep() {
    isAwake = false;
    attachImage(opentwamp);
    setStatic(true);
  }
}
