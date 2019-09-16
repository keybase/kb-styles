sass    = require 'node-sass'
{Color} = sass.types

#
# TODO: Talk to nojima about how he wants these things named
#

c = colors =
  blue:                     new Color 0x4c8eff
  blue_dark:                new Color 0x3663ea   # previously dark_blue2 
  blue_darker:              new Color 0x1036ac   # previously dark_blue4
  blue_darker2:             new Color 0x182d6e   # previously dark_blue3
  blue_light:               new Color 0x73a6ff   # previously blue2
  blue_lighter:             new Color 0xa8ccff   # previously blue3
  blue_lighter2:            new Color 0xebf2fc   # previously blue4
  blue_lighter3:            new Color 0xf7f9fc   # previously blue5
# dark_blue:                new Color 0x2645a3   DITCHED (if used, replace with blueDark)
  orange:                   new Color 0xff6f21
  yellow:                   new Color 0xfff75a
  yellow_dark:              new Color 0xffb800   # previously yellow2
  yellow_light:             new Color 0xfffdcc   # previously yellow3
  green:                    new Color 0x37bd99
  green_dark:               new Color 0x189e7a   # previously green2
  green_darker:             new Color 0x12785d
  green_light:              new Color 0xb7eed9
  green_lighter:            new Color 0xe8faf6   # previously green3
  red:                      new Color 0xff4d61
  red_dark:                 new Color 0xeb253b
  red_darker:               new Color 0xbd0b1f
  red_light:                new Color 0xffcac1
  red_lighter:              new Color 0xfaf2ed   # previously beige
#  yellow_green:            new Color 0xa8cf36  # DITCHED
#  yellow_green2:           new Color 0x94b52f  # DITCHED
#  yellow_green3:           new Color 0xd2e697  # DITCHED
  grey_light:               new Color 0xf6f6f6   # previously light_grey
  grey:                     new Color 0xe6e6e6   # previously light_grey2
  grey_dark:                new Color 0xcccccc   # previously grey
  blue_grey:                new Color 0xf2f4f7
  blue_grey_dark:           new Color 0xe0e8f6
  purple:                   new Color 0x8852ff   # previously purple2
  purple_dark:              new Color 0x6d3fd1   # previously purple
  purple_light:             new Color 0x9d70ff   # previously purple3
  background_grey_light:    new Color 0xf6f6f6   # previously light_grey2
  background_white:         new Color 0xffffff
  white:                    new Color 0xffffff
  black:                    new Color 0x000000
  brown:                    new Color 71,31,18

for fg in ['white','black','brown','blue']
  [r,g,b] = [c[fg].getR(), c[fg].getG(), c[fg].getB()]
  for alpha in [5,10,20,50,63,85]
    a = alpha / 100
    c["#{fg}#{alpha}"] = new Color r, g, b, a             # this generates black70, etc.
    for bg in ['white','black','yellow','blue_darker2']
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
    bg: c.blue_darker2
  terminal:
    bg: c.blue_darker2
    fg: c.blue3
  encrypted:
    bg: c.blue_darker2
    fg: c.white
  public:
    bg: c.green
    fg: c.white
  stellar:
    bg: c.purple
    fg: c.white

module.exports = {colors, pairs}
