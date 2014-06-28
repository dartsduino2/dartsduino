(function() {
  'use strict';
  Polymer('game-time-attack', {
    MAX_COUNT: 30,
    MAX_PRECOUNT: 3,
    score: null,
    timer: null,
    count: null,
    preTimer: null,
    preCount: null,
    initialize: function() {
      return this.title = 'タイムアタック';
    },
    start: function() {
      this.score = 0;
      this.count = this.MAX_COUNT;
      this.tick();
      this.preCount = this.MAX_PRECOUNT;
      return this.preTimer = setInterval((function(_this) {
        return function() {
          _this.preCount--;
          _this.tick();
          if (_this.preCount === 0) {
            _this.preCount = '';
            clearInterval(_this.preTimer);
            _this.preTimer = null;
            return _this.doStart();
          }
        };
      })(this), 1000);
    },
    tick: function() {
      this.$.precount.classList.remove('tick');
      return setTimeout((function(_this) {
        return function() {
          return _this.$.precount.classList.add('tick');
        };
      })(this), 100);
    },
    doStart: function() {
      return this.timer = setInterval((function(_this) {
        return function() {
          _this.count--;
          if (_this.count === 3) {
            return _this.$.count.classList.add('alert');
          } else if (_this.count === 0) {
            return _this.over();
          }
        };
      })(this), 1000);
    },
    onHit: function(event) {
      var point, ratio;
      if (this.timer === null) {
        return;
      }
      point = parseInt(event.detail.point);
      ratio = parseInt(event.detail.ratio);
      return this.score += point * ratio;
    },
    over: function() {
      clearInterval(this.timer);
      return this.timer = null;
    }
  });

}).call(this);
