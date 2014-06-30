(function() {
  'use strict';
  Polymer('game-group', {
    activeGame: null,
    publish: {
      games: {
        value: '',
        reflect: true
      },
      state: {
        value: '',
        reflect: true
      }
    },
    domReady: function() {
      var game, games, _i, _len, _ref;
      games = [];
      _ref = this.$.games.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        game = _ref[_i];
        games.push(game.title);
      }
      return this.games = games.join(',');
    },
    stateChanged: function(oldValue, newValue) {
      var players, title, _ref;
      if (newValue != null) {
        _ref = newValue.split(','), title = _ref[0], players = _ref[1];
        return this.activateGame(title, players);
      } else {
        return this.deactivateGame();
      }
    },
    activateGame: function(title, players) {
      var index;
      index = this.games.split(',').indexOf(title);
      this.activeGame = this.$.games.children[index];
      this.activeGame.setAttribute('players', players);
      return this.activeGame.setAttribute('active', '');
    },
    deactivateGame: function() {
      return this.activeGame.removeAttribute('active');
    }
  });

}).call(this);
