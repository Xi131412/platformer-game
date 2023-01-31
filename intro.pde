
void intro() {
  noStroke();
  background(bkg);
  rect(0, 0, width, height);
  intro.show();
  textFont(hiro);
  fill(org);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("Super Mario 13", 500, 100);
  // song.play();




  if (space) {
    mode = PLAY;
  }
}
