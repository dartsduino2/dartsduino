(function() {
  'use strict';
  Polymer('game-501', {
    MAX_ROUND: 8,
    totalScores: null,
    scores: null,
    round: null,
    count: null,
    initialize: function() {
      return this.title = 501;
    },
    start: function() {
      var player, _i, _len, _ref;
      this.totalScores = {};
      this.scores = {};
      _ref = this.playerList;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        this.totalScores[player.id] = 501;
        this.scores[player.id] = [];
      }
      this.round = 1;
      return this.count = 1;
    },
    onHit: function(event) {
      var id, isNextRound, point, prevScore, ratio, score;
      id = this.currentPlayer.id;
      point = parseInt(event.detail.point);
      ratio = parseInt(event.detail.ratio);
      score = point * ratio;
      if (this.count === 1) {
        this.scores[id].push(score);
      } else {
        this.scores[id][this.scores[id].length - 1] += score;
      }
      prevScore = this.totalScores[id];
      this.totalScores[id] -= score;
      if (this.totalScores[id] < 0) {
        this.totalScores[id] = prevScore;
      } else if (this.totalScores[id] === 0) {
        this.over(this.currentPlayer);
        return;
      }
      this.count++;
      if (this.count > 3) {
        this.count = 1;
        isNextRound = this.nextPlayer();
        if (isNextRound) {
          if (this.round >= this.MAX_ROUND) {
            return this.over();
          } else {
            return this.round++;
          }
        }
      }
    },
    over: function(winner) {
      var player, score, _i, _len, _ref;
      if (winner == null) {
        winner = [];
        score = 1000;
        _ref = this.playerList;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          player = _ref[_i];
          if (score === this.totalScores[player.id]) {
            winner.push(player);
          } else if (score > this.totalScores[player.id]) {
            winner = [player];
            score = this.totalScores[player.id];
          }
        }
        winner = winner.length > 1 ? null : winner[0];
      }
      return this.finish({
        player: winner,
        score: score
      });
    }
  });

}).call(this);
