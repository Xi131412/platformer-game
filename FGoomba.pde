class FGoomba extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);
    attachImage(goomba[frameCount%2]);
  }

  void act() {
    animate();
    move();
    collide();
  }

  void animate() {
    if (frame>=goomba.length) frame=0;
    if (frameCount % 10 == 0) {
      if (direction==R) attachImage(goomba[frame]);
      if (direction==L)  attachImage(reverseImage(goomba[frame]));
      frame++;
    }
  }


  void collide() {
    if (isTouching("wall")) {
      direction = direction*-1;
      speed = speed*-1;
      setPosition(getX()+ speed/25, getY());
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
    setVelocity(speed, vy);
  }
}
