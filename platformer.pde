import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import fisica.*;

//Kelvin Xi
//Platformer game

final int INTRO =0;
final int PLAY = 1;
final int GAMEOVER = 3;
int mode = INTRO;
int f;
int live = 3;
PFont hiro;
FWorld world;

color white = #FFFFFF;
color black = #000000;
color blue = #71BEFF;
color red = #ED1619;
color green = #76a112;
color icecyan = #00b7ef;
color brown = #9c5a3c;
color cream  = #FFEEAA;
color spikepurp = #6f3198;
color pink = #ffa3b1;
color gray = #464646;
color yellow = #fff200;
color thwampred = #ed1c24;
color lavared = #990030;
color trampgreen = #22b14c;
color hbrocolor = #ab448a;
color flagc = #4bfa00;
color peachc = #9dc90e;
color bkg = #52DCFC;
color org = #F58A25;
color iviwall = #e68787;



PImage ice, treetrunk, stone, treeEndEast, treeEndWest, treeIntersect, treeMiddle, spike, bridge, closedtwamp, opentwamp, trampo, xin, losexin, hammer;
PImage flag, peach;
PImage map1;
PImage map2;
Gif intro, side, gameover, winner;
int gridSize = 32;
float zoom = 2;
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey, space;
Fplr plr;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

int currentLevel = 1;
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;
PImage[] lava = new PImage[6];
PImage[] hbro = new PImage[2];


Minim minim;
AudioPlayer song;

void setup() {
  size(1000, 1000);
  Fisica.init(this);
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  loadImages();
  loadWorld();
  loadplr();

  minim = new Minim(this);
  song = minim.loadFile("song.mp3");
}
void loadplr() {
  plr = new Fplr();
  world.add(plr);
}
void loadImages() {
  map1 = loadImage("pixil-frame-0.png");
  map2 = loadImage("pixil-frame-1.png");
  ice = loadImage("ice.png");
  treetrunk = loadImage("trunk.png");
  ice.resize(32, 32);
  stone = loadImage("stone.png");
  treeEndEast = loadImage("rightleaf.png");
  treeEndWest = loadImage("leftleaf.png");
  treeMiddle = loadImage("middleleaf.png");
  treeIntersect = loadImage("middle trunk.png");
  spike = loadImage("spike.png");
  bridge = loadImage("bridge.png");
  hiro = createFont("aAsianHiro.otf", 200);
  closedtwamp = loadImage ("thwomp0.png");
  opentwamp = loadImage ("thwomp1.png");
  trampo = loadImage("trampoline.png");
  xin = loadImage("xin.png");
  losexin = loadImage("losexin.png");
  hammer = loadImage("hammer.png");
  flag = loadImage("flag.png");
  flag.resize(54, 70);
  peach = loadImage("peach.png");
  peach.resize(54, 70);

  idle = new PImage [2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump= new PImage[1];
  jump[0] = loadImage("jump.png");

  run = new PImage[3];
  run[0] = loadImage("run.png");
  run[1] = loadImage("run1.png");
  run[2] = loadImage("run2.png");
  action = idle;
  //enemies --------------------------------------
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  lava[0] = loadImage("lava1.png");
  lava[1] = loadImage("lava2.png");
  lava[2] = loadImage("lava3.png");
  lava[3] = loadImage("lava4.png");
  lava[4] = loadImage("lava5.png");
  lava[5] = loadImage("lava0.png");

  hbro = new PImage[2];
  hbro[0] = loadImage("hammerbro0.png");
  hbro[0].resize(gridSize, gridSize);
  hbro[1] = loadImage("hammerbro1.png");
  hbro[1].resize(gridSize, gridSize);
  //gif
  intro = new Gif("intro/frame_", "_delay-0.1s.gif", 11, 1, 0, 0, width, height);
  gameover =  new Gif("gameover/frame_", "_delay-0.05s.gif", 56, 1, 0, 0, width, height);
 // winner =  new Gif("winner/frame_", "_delay-0.03s.gif", 105, 1,0, 0, width, height);
}

void loadLevel(PImage img) {
  world = new FWorld (-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);   //color of current pixel
      color s = img.get(x, y+1); // color below current pixes
      color w = img.get(x-1, y); //color west of current pixel
      color e = img.get(x+1, y); //color east of current pixel
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == black) {//stone block
        b.attachImage(stone);
        b.setFriction(4);
        b.setName("stone");
        world.add(b);
      }
      if (c == pink) {
        b.attachImage(stone);
        b.setName("wall");
        world.add(b);
      } else if (c == icecyan) { //iceblock
        b.setFriction(0);
        b.attachImage(ice);
        b.setName("ice");
        world.add(b);
      } else if (c == brown) { //treetrunk
        b.attachImage(treetrunk);
        b.setSensor(true);
        b.setName("treetrunk");
        world.add(b);
      } else if (c == green && s==brown) { //intersection
        b.setFriction(4);
        b.attachImage(treeIntersect);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && w == green & e == green) { //mid piece
        b.setFriction(4);
        b.attachImage(treeMiddle);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && w != green) { //west endcap
        b.setFriction(4);
        b.attachImage(treeEndWest);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && e != green ) {//east endcap
        b.setFriction(4);
        b.attachImage(treeEndEast);
        b.setName("treetop");
        world.add(b);
      } else if (c == spikepurp) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      } else if (c == gray) {
        Fbridge br = new Fbridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
        b.setName("bridge");
      } else if (c == yellow) {
        FGoomba gmb = new FGoomba (x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == lavared) {
        FLava la =new FLava(x*gridSize, y*gridSize);
        terrain.add(la);
        world.add(la);
      } else if (c == trampgreen) {
        Ftramp tra = new Ftramp(x*gridSize, y*gridSize);
        terrain.add(tra);
        world.add(tra);
      } else if (c == thwampred) {
        FThwomp twa = new FThwomp(x*gridSize, y*gridSize);
        enemies.add(twa);
        world.add(twa);
      } else if  (c == hbrocolor) {
        FHammerBro hbro = new FHammerBro(x*gridSize, y*gridSize);
        enemies.add(hbro);
        world.add(hbro);
      }
      if (c == flagc) {
        b.attachImage(flag);
        b.setName("ti");
        world.add(b);
        b.setGroupIndex(2);
      }
      if (c == peachc) {
        b.attachImage(peach);
        b.setName("tao");
        world.add(b);
        b.setGroupIndex(2);
      }
      if (c == iviwall) {
        b.attachImage(stone);
        b.setSensor(true);
        b.setName("wall");
        world.add(b);
      }
    }
  }
}

void loadWorld() {
  world = new FWorld(-2000, -2000, 2000, 2000);

  if (currentLevel == 1) {
    world.setGravity(0, 900);
    loadLevel(map1);
  } else if (currentLevel == 2) {
    world.setGravity(0, 900);
    loadLevel(map2);
    loadplr();
  }
}

void draw() {

  if (mode == INTRO) {
    intro();
  } else if (mode == PLAY) {
    play();
  } else if (mode == GAMEOVER) {
    gameover();
  }
}
