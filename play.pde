void play() {
  background(bkg);
  drawWorld();
  actWorld();
  plr.act();
  showlife();
  ded();
}

void actWorld() {
  plr.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t =  terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}


void drawWorld() {
  pushMatrix();
  translate(-plr.getX()*zoom+width/2, -plr.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
void showlife() {
  textFont(hiro);
  textSize(50);
  fill(#FA5165);
  if (currentLevel == 1) {
    text("Level: 1", 100, 120);
  } else if (currentLevel == 2) {
    text("Level: 2", 100, 120);
  }
  if (live == 3) {
    image (xin, 30, 30, 50, 50);
    image (xin, 85, 30, 50, 50);
    image (xin, 140, 30, 50, 50);
  } else if (live == 2) {
    image (xin, 30, 30, 50, 50);
    image (xin, 85, 30, 50, 50);
    image (losexin, 140, 30, 50, 50);
  } else if (live == 1) {
    image (xin, 30, 30, 50, 50);
    image (losexin, 85, 30, 50, 50);
    image (losexin, 140, 30, 50, 50);
  } else if (live == 0) {
    image (losexin, 30, 30, 50, 50);
    image (losexin, 85, 30, 50, 50);
    image (losexin, 140, 30, 50, 50);
  }
}

void ded () {
  if (live <= 0) {
    mode = GAMEOVER;
  }
}
