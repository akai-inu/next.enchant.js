var GAME_FPS, GAME_HEIGHT, GAME_WIDTH, SceneTest;

enchant('next');

GAME_WIDTH = 854;

GAME_HEIGHT = 480;

GAME_FPS = 20;

window.onload = function() {
  var game;
  game = new Game(GAME_WIDTH, GAME_HEIGHT);
  game.fps = GAME_FPS;
  game.onload = function() {
    return game.replaceScene(new SceneTest());
  };
  return game.start();
};

SceneTest = Class.create(Scene, {
  initialize: function() {
    var lab;
    Scene.call(this);
    this.time = new Time(this, GAME_FPS);
    lab = new Label();
    lab.text = 'Hello World.';
    lab.textAlign = 'center';
    lab.font = '30px Meiryo';
    lab.width = GAME_WIDTH;
    this.addChild(lab);
    return this.debugBox = new DebugBox(this);
  },
  onenterframe: function() {
    this.debugBox.addText('FPS : ' + this.time.averageFps);
    this.debugBox.addText('TEST' + this.age);
    return this.debugBox.addText('TESTAAAAAAAAAAAAAAAAAAAAAAAA');
  }
});
