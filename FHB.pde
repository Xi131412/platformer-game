class FHammerBro extends FGameObject {

  int direction;
  int speed = 50;
  int frame = 0;

  FHammerBro(float x, float y) {
    super();
    setPosition(x, y);
    setName("hbro");
    setRotatable(false);
    attachImage(hbro[frameCount%2]);
    direction = R;
  }

  void act() {
    animate();
    move();
    collide();
  }

  void animate() {
    if (frame>= hbro.length) frame=0;
    if (frameCount % 10 == 0) {
      if (direction == R) attachImage(hbro[frame]);
      if (direction == L)  attachImage(reverseImage(hbro[frame]));
      frame++;
    }
  }



  void collide() {
    if (isTouching("wall")) {
      throwHammer();
      direction = direction*-1;
      setPosition(getX()+ direction*5, getY());
    }

    if (isTouching("plr")) {
      if (plr.getY() < getY()-gridSize/2) {

        world.remove(this);
        enemies.remove(this);
        plr.setVelocity(plr.getVelocityX(), -500);
      } else {
        live-- ;

        plr.setPosition(0, 0);
      }
    }
  }

  void move() {
    float vy=getVelocityY();
    setVelocity(direction*speed, vy);
  }

  void throwHammer() {
    FBox ham = new FBox(gridSize, gridSize);
    ham.attachImage(hammer);
    ham.setPosition(getX(), getY());
    ham.setVelocity(random(-500, 500), -500);
    ham.setAngularVelocity(random(-500, 500));
    ham.setName("ham");
    ham.setSensor(true);
    world.add(ham);
  }
}
