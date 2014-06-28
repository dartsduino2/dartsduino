(function() {
  'use strict';
  Polymer('game-base', {
    State: {
      NOT_STARTED: 0,
      PLAYING: 1,
      FINISHED: 2
    },
    dartsUi: null,
    state: null,
    listeners: [],
    title: '',
    playerList: null,
    currentPlayer: null,
    currentPlayerIndex: null,
    ready: function() {
      this.dartsUi = document.querySelector('darts-ui');
      this.state = this.State.NOT_STARTED;
      if (typeof this.initialize === "function") {
        this.initialize();
      }
      return this.setVisibility(false);
    },
    activeChanged: function(oldValue, newValue) {
      if (newValue !== null) {
        return this.activate();
      } else {
        return this.deactivate();
      }
    },
    activate: function() {
      var i, player, _i, _ref;
      this.addEventListener('hit', this.onHit.bind(this));
      this.dartsUi.setAttribute('focuses', '');
      this.playerList = [];
      for (i = _i = 1, _ref = this.players || 1; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
        player = {
          id: i - 1,
          name: 'Player ' + i
        };
        this.playerList.push(player);
      }
      this.currentPlayerIndex = 0;
      this.currentPlayer = this.playerList[this.currentPlayerIndex];
      if (typeof this.start === "function") {
        this.start();
      }
      this.state = this.State.PLAYING;
      return this.setVisibility(true);
    },
    deactivate: function() {
      this.removeEventListener();
      this.state = this.State.NOT_STARTED;
      return this.setVisibility(false);
    },
    setVisibility: function(isVisible) {
      if (isVisible) {
        return this.style.visibility = 'visible';
      } else {
        return this.style.visibility = 'hidden';
      }
    },
    onHit: function(event) {
      var point, ratio, _ref;
      _ref = event.detail, point = _ref.point, ratio = _ref.ratio;
      return console.log(point + ' * ' + ratio + ' = ' + point * ratio);
    },
    finish: function(result) {
      this.removeEventListener();
      this.state = this.State.FINISHED;
      return this.fire('finish', result);
    },
    addEventListener: function(event, listener) {
      this.dartsUi.addEventListener(event, listener);
      return this.listeners.push({
        event: event,
        listener: listener
      });
    },
    removeEventListener: function() {
      var event, listener, _i, _len, _ref, _ref1;
      _ref = this.listeners;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        _ref1 = _ref[_i], event = _ref1.event, listener = _ref1.listener;
        this.dartsUi.removeEventListener(event, listener);
      }
    },
    nextPlayer: function() {
      var isNext;
      isNext = false;
      this.currentPlayerIndex++;
      if (this.currentPlayerIndex >= this.playerList.length) {
        this.currentPlayerIndex = 0;
        isNext = true;
      }
      this.currentPlayer = this.playerList[this.currentPlayerIndex];
      return isNext;
    }
  });

}).call(this);
