sass    = require 'node-sass'
{Color} = sass.types

#
# TODO: Talk to nojima about how he wants these things named
#

c = colors =
  blue:                     new Color 0x4c8eff
  blue2:                    new Color 0x73a6ff
  blue3:                    new Color 0xa8ccff
  blue4:                    new Color 0xebf2fc
  blue5:                    new Color 0xf7f9fc
  orange:                   new Color 0xff6f21
  yellow:                   new Color 0xfff75a
  yellow2:                  new Color 0xdbd22a
  yellow3:                  new Color 0xfffdcc
  dark_blue:                new Color 0x2645a3
  dark_blue2:               new Color 0x3663ea
  dark_blue3:               new Color 0x182d6e
  dark_blue4:               new Color 0x1036ac
  green:                    new Color 0x37bd99
  green2:                   new Color 0x289a72
  green3:                   new Color 0xe8faf6
  red:                      new Color 0xff4d61
  yellow_green:             new Color 0xa8cf36
  yellow_green2:            new Color 0x94b52f
  yellow_green3:            new Color 0xd2e697
  light_grey:               new Color 0xf6f6f6
  light_grey2:              new Color 0xe6e6e6
  grey:                     new Color 0xcccccc
  beige:                    new Color 0xfaf2ed
  purple:                   new Color 0x704eba
  purple2:                  new Color 0x845cdb
  purple3:                  new Color 0x9f7bec
  background_light_grey2:   new Color 0xf6f6f6
  background_white:         new Color 0xffffff
  white:                    new Color 0xffffff
  black:                    new Color 0x000000
  brown:                    new Color 71,31,18

for fg in ['white','black','brown','blue']
  [r,g,b] = [c[fg].getR(), c[fg].getG(), c[fg].getB()]
  for alpha in [5,10,20,50,63,85]
    a = alpha / 100
    c["#{fg}#{alpha}"] = new Color r, g, b, a             # this generates black70, etc.
    for bg in ['white','black','yellow','dark_blue']
      r2 = c[bg].getR() * (1 - a) + r * a
      g2 = c[bg].getG() * (1 - a) + g * a
      b2 = c[bg].getB() * (1 - a) + b * a
      c["#{fg}#{alpha}_on_#{bg}"] = new Color r2,g2,b2    # and this generates black70_on_yellow, etc.

pairs =
  neutral_announcement:
    fg: c.white
    bg: c.blue
  success_message:
    fg: c.white
    bg: c.green
  to_be_noticed:
    fg: c.brown85
    bg: c.yellow
  high_risk_alert:
    fg: c.white
    bg: c.red
  documentation:
    fg: c.white
    bg: c.dark_blue
  terminal:
    bg: c.dark_blue3
    fg: c.blue3
  encrypted:
    bg: c.dark_blue
    fg: c.white
  public:
    bg: c.yellow_green
    fg: c.white

module.exports = {colors, pairs}
