(function() {
  'use strict';
  Polymer('game-cricket', {
    POINTS: [20, 19, 18, 17, 16, 15, 'Bull'],
    MARKS: [[''], ['／'], ['／', '＼'], ['／', '＼', '◯']],
    MAX_ROUND: 20,
    MAX_SCORE: 3,
    totalScores: {},
    scores: {},
    closedPoint: {},
    round: null,
    count: null,
    initialize: function() {
      return this.title = 'Cricket';
    },
    start: function() {
      var player, point, _i, _j, _len, _len1, _ref, _ref1;
      this.totalScores = {};
      this.scores = {};
      _ref = this.playerList;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        this.totalScores[player.id] = 0;
        this.scores[player.id] = {};
        _ref1 = this.POINTS;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          point = _ref1[_j];
          this.scores[player.id][point] = 0;
        }
      }
      this.round = 1;
      return this.count = 1;
    },
    onHit: function(event) {
      var id, isNextRound, point, ratio, score;
      id = this.currentPlayer.id;
      point = parseInt(event.detail.point);
      ratio = parseInt(event.detail.ratio);
      if (point >= 15) {
        score = point * ratio;
        if (point === 25) {
          point = 'Bull';
        }
        if (this.scores[id][point] >= this.MAX_SCORE) {
          if (this.closedPoint[point] == null) {
            this.totalScores[id] += score;
          }
        } else {
          this.scores[id][point] += ratio;
          if (this.scores[id][point] >= this.MAX_SCORE) {
            this.scores[id][point] = this.MAX_SCORE;
            if (this.scores[1 - id][point] >= this.MAX_SCORE) {
              this.closedPoint[point] = true;
              if (Object.keys(this.closedPoint).length === this.POINTS.length) {
                this.over();
              }
            }
          }
        }
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
    over: function() {
      var player, score, winner, _i, _len, _ref;
      winner = [];
      score = -1;
      _ref = this.playerList;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        if (score === this.totalScores[player.id]) {
          winner.push(player);
        } else if (score < this.totalScores[player.id]) {
          winner = [player];
          score = this.totalScores[player.id];
        }
      }
      winner = winner.length > 1 ? null : winner[0];
      return this.finish({
        player: winner,
        score: score
      });
    }
  });

}).call(this);
