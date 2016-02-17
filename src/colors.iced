sass    = require 'node-sass'
{Color} = sass.types

#
# TODO: Talk to nojima about how he wants these things named
#

c = colors =
  blue:                     new Color 0x33a0ff
  blue2:                    new Color 0x66b8ff
  blue3:                    new Color 0xa8d7ff
  blue4:                    new Color 0xe6f3ff
  orange:                   new Color 0xff6f21
  yellow:                   new Color 0xfff75a
  dark_blue:                new Color 0x195080
  dark_blue2:               new Color 0x2470b3
  dark_blue3:               new Color 0x001b33
  green:                    new Color 0x3dcc8e
  green2:                   new Color 0x36b37c
  red:                      new Color 0xff4d61
  yellow_green:             new Color 0x89a82c
  light_grey:               new Color 0xebebeb
  light_grey2:              new Color 0xf6f6f6
  background_light_grey2:   new Color 0xf6f6f6
  background_white:         new Color 0xffffff
  white:                    new Color 0xffffff
  black:                    new Color 0x000000
  brown:                    new Color 71,31,17

for fg in ['white','black','brown','blue']
  [r,g,b] = [c[fg].getR(), c[fg].getG(), c[fg].getB()]
  for alpha in [10,20,40,60,75]
    a = alpha / 100
    c["#{fg}#{alpha}"] = new Color r, g, b, a             # this generates black70, etc.
    for bg in ['white','black','yellow','dark_blue']
      r2 = c[bg].getR() * (1 - a) + r * a
      g2 = c[bg].getG() * (1 - a) + g * a
      b2 = c[bg].getB() * (1 - a) + b * a
      c["#{fg}#{alpha}_on_#{bg}"] = new Color r2,g2,b2    # and this generates black70_on_yellow, etc.


# let's build "brown60"
#  # these are official colors with opacities although we'll make
#  # some alpha-less ones below
#  brown60:                  new Color 71, 31, 17, 0.6
#  black75:                  new Color 0, 0, 0, 0.75
#  black60:                  new Color 0, 0, 0, 0.60
#  black40:                  new Color 0, 0, 0, 0.40
#  black20:                  new Color 0, 0, 0, 0.20
#  black10:                  new Color 0, 0, 0, 0.10
#  white75:                  new Color 255, 255, 255, 0.75
#  white40:                  new Color 255, 255, 255, 0.40


pairs =
  neutral_announcement:
    fg: c.white
    bg: c.blue
  success_message:
    fg: c.white
    bg: c.green
  to_be_noticed:
    fg: c.brown60
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

module.exports = {colors, pairs}
