class Fplr extends FGameObject {

  int frame, direction, lives;
  int timer = 0;
  int interval;
  PImage fi;

  Fplr() {
    super();
    frame = 0;
    direction = R;
    setPosition(100, 0);
    setName("plr");
    setRotatable(false);
    setFillColor(lavared);
  }

  void act() {
    handleInput();
    collision();
    animate();
  }

  void handleInput() {
    float vy=getVelocityY();
    float vx=getVelocityX();
    if (abs(vy) < 0.1) action = idle;

    if (akey) {
      action=run;
      setVelocity(-200, vy);
      direction=L;
    }
    if (dkey) {
      action=run;
      setVelocity(200, vy);
      direction=R;
    }
    ArrayList<FContact> contacts = plr.getContacts();
    if (wkey && contacts.size() > 0) plr.setVelocity(plr.getVelocityX(), -400);
    if (abs(vy) > 0.1) action=jump;
    if (skey)setVelocity(vx, 100);
    //space key jump
    if (space && contacts.size() > 0) plr.setVelocity(plr.getVelocityX(), -400);
    if (abs(vy) > 0.1) action=jump;
    if (skey)setVelocity(vx, 100);
  }



  void collision() {
    if (isTouching("spike")) {
      setPosition(0, 0);
      setVelocity(0, 0);
      live-- ;
    }
    if (isTouching("lava")) {
      setPosition(0, 0);
      setVelocity(0, 0);
      live-- ;
    }
    if (isTouching("ham")) {
      live-- ;
      plr.setPosition(0, 0);
      plr.setVelocity(0, 0);
    }
    if (isTouching("ti")) {
      currentLevel = 2;
      loadWorld();
      text("Level: 2", 35, 130);
      plr.setPosition(0, 0);
      plr.setVelocity(0, 0);
    }
    if (isTouching("tao")) {
      mode = GAMEOVER;
    }
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount%5==0) {
      attachImage(action[frame]);
      if (direction == R) attachImage(action[frame]);
      if (direction==L)  attachImage(reverseImage(action[frame]));
      frame++;
    }
  }
}
