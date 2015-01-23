(function() {
  'use strict';
  Polymer('game-time-attack', {
    INTERVAL_DURATION: 1000,
    COUNT: 30,
    PRECOUNT: 3,
    NO_COUNT: 3,
    score: null,
    timer: null,
    count: null,
    initialize: function() {
      return this.title = 'タイムアタック';
    },
    start: function() {
      this.score = 0;
      this.maxScore = localStorage['time-attack'] || 0;
      this.timeLeft = this.COUNT;
      this.count = this.COUNT + this.PRECOUNT + this.NO_COUNT + 1;
      return this.timer = setInterval((function(_this) {
        return function() {
          var _ref;
          _this.tick();
          _this.count--;
          if (_this.count > _this.COUNT + _this.PRECOUNT) {

          } else if ((_this.COUNT + _this.PRECOUNT >= (_ref = _this.count) && _ref > _this.COUNT)) {
            _this.jumbotext = _this.count - _this.COUNT;
            return window.sound.play('click');
          } else if (_this.count === _this.COUNT) {
            return _this.jumbotext = '';
          } else {
            _this.timeLeft = _this.count;
            if (_this.count <= 5) {
              window.sound.play('click');
            }
            if (_this.count <= 0) {
              return _this.over();
            }
          }
        };
      })(this), this.INTERVAL_DURATION);
    },
    tick: function() {
      this.jumbotextClass = '';
      return setTimeout((function(_this) {
        return function() {
          return _this.jumbotextClass = 'tick';
        };
      })(this), 0);
    },
    stop: function() {
      if (this.timer != null) {
        clearInterval(this.timer);
        return this.timer = null;
      }
    },
    onHit: function(event) {
      var point, ratio;
      if (this.timer == null) {
        return;
      }
      point = parseInt(event.detail.point);
      ratio = parseInt(event.detail.ratio);
      return this.score += point * ratio;
    },
    over: function() {
      var isMaxScore;
      this.stop();
      isMaxScore = this.score > this.maxScore;
      if (isMaxScore) {
        this.maxScore = this.score;
        localStorage['time-attack'] = this.score;
      }
      return this.finish({
        message: ("得点 : " + this.score) + (isMaxScore ? '　★本日の最高得点!★' : '')
      });
    }
  });

}).call(this);
