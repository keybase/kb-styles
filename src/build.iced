gulp       = require 'gulp'
sass       = require 'node-sass'
{make_esc} = require 'iced-error'
fs         = require 'fs'
colors     = require './colors.iced'
{exec}     = require 'child_process'

config =
  dir:
    bootstrap: './bower_components/bootstrap-sass'
    public:    './public'

# --------------------------------------------------------------------------------------

build_sass_colors = (_, cb) ->
  esc = make_esc cb
  res = ""
  for color_name, c of colors.colors
    res += "$#{color_name}: rgba(#{c.getR()},#{c.getG()},#{c.getB()},#{c.getA()})\n"
  res += "\n"
  await fs.writeFile "./public/css/kb_colors.scss", res, esc defer()

# --------------------------------------------------------------------------------------

build_bootstrap = (_, cb) ->
  esc = make_esc cb
  await sass.render {
    file: './src/kb_bootstrap.scss'
    includePaths:["#{config.dir.bootstrap}/assets/stylesheets"]
  }, esc defer bootstrap_css

  # write css file
  await fs.writeFile "./public/css/kb_bootstrap.css", bootstrap_css.css, {encoding:'utf-8'}, esc defer()

  # cp JS and font files
  await exec "cp #{config.dir.bootstrap}/assets/javascripts/bootstrap.min.js ./public/js/", esc defer stdout, stderr
  await exec "cp #{config.dir.bootstrap}/assets/fonts/* ./public/bootstrap/fonts/", esc defer stdout, stderr
  cb null

# --------------------------------------------------------------------------------------

cb_done = (err, res) ->
  if err
    console.log err
    process.exit 1
  else
    console.log "Success!"
    process.exit 0

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

main_esc = make_esc cb_done
await build_sass_colors null, main_esc, defer()
await build_bootstrap null, main_esc defer()
