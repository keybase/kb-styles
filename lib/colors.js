// Generated by IcedCoffeeScript 108.0.9
(function() {
  var Color, a, alpha, b, b2, bg, c, colors, fg, g, g2, pairs, r, r2, sass, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _ref3;

  sass = require('node-sass');

  Color = sass.types.Color;

  c = colors = {
    blue: new Color(0x33a0ff),
    blue2: new Color(0x66b8ff),
    blue3: new Color(0xa8d7ff),
    blue4: new Color(0xe6f3ff),
    orange: new Color(0xff6f21),
    yellow: new Color(0xfff75a),
    dark_blue: new Color(0x195080),
    dark_blue2: new Color(0x2470b3),
    dark_blue3: new Color(0x001b33),
    green: new Color(0x3dcc8e),
    green2: new Color(0x36b37c),
    red: new Color(0xff4d61),
    yellow_green: new Color(0x89a82c),
    light_grey: new Color(0xebebeb),
    light_grey2: new Color(0xf6f6f6),
    background_light_grey2: new Color(0xf6f6f6),
    background_white: new Color(0xffffff),
    white: new Color(0xffffff),
    black: new Color(0x000000),
    brown: new Color(71, 31, 17)
  };

  _ref = ['white', 'black', 'brown'];
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    fg = _ref[_i];
    _ref1 = [c[fg].getR(), c[fg].getG(), c[fg].getB()], r = _ref1[0], g = _ref1[1], b = _ref1[2];
    _ref2 = [10, 20, 40, 60, 75];
    for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
      alpha = _ref2[_j];
      a = alpha / 100;
      c["" + fg + alpha] = new Color(r, g, b, a);
      _ref3 = ['white', 'black', 'yellow', 'dark_blue'];
      for (_k = 0, _len2 = _ref3.length; _k < _len2; _k++) {
        bg = _ref3[_k];
        r2 = c[bg].getR() * (1 - a) + r * a;
        g2 = c[bg].getG() * (1 - a) + g * a;
        b2 = c[bg].getB() * (1 - a) + b * a;
        c["" + fg + alpha + "_on_" + bg] = new Color(r2, g2, b2);
      }
    }
  }

  pairs = {
    neutral_announcement: {
      fg: c.white,
      bg: c.blue
    },
    success_message: {
      fg: c.white,
      bg: c.green
    },
    to_be_noticed: {
      fg: c.brown60,
      bg: c.yellow
    },
    high_risk_alert: {
      fg: c.white,
      bg: c.red
    },
    documentation: {
      fg: c.white,
      bg: c.dark_blue
    },
    terminal: {
      bg: c.dark_blue3,
      fg: c.blue3
    }
  };

  module.exports = {
    colors: colors,
    pairs: pairs
  };

}).call(this);