void gameover () {

  if (live == 0) {
    gameover.show();
    textSize(50);
    textAlign(CENTER, CENTER);
    text("So Close", width/2, height/2);
    fill(#f4f6f0);
    textSize(30);
    text("Press space to try again", width/2, height/2+50);
    if (space) {
      reset();
    }
  } else if (live > 0) {
    winner.show();
    textSize(50);
    fill(black);
    text("Congrat, here's a cookie", width/2, height/2);
    text("press space to play again", width/4, height/4);
    if (space) {
      reset();
    }
  }
}

void reset() {
  world.clear();
  mode = INTRO;
  currentLevel = 1;
  live = 3;
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  setup();
  plr.setPosition(100, 0);
  plr.setVelocity(0, 0);
}
