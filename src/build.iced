gulp       = require 'gulp'
sass       = require 'node-sass'
{make_esc} = require 'iced-error'
fs         = require 'fs'
colors     = require './colors.iced'
{exec}     = require 'child_process'

config =
  dir:
    bootstrap_in:  './bower_components/bootstrap-sass'
    bootstrap_out: './public/bootstrap'
    public:        './public'

# --------------------------------------------------------------------------------------

build_sass_colors = (_, cb) ->
  esc = make_esc cb
  res = """
  /* This sass file was itself autogenerated; run `make` in kb-styles to rebuild */\n\n
  """
  for color_name, c of colors.colors
    if c.getA()
      res += "$kb_#{color_name}: rgba(#{c.getR()},#{c.getG()},#{c.getB()},#{c.getA()});\n"
    else
      res += "$kb_#{color_name}: rgb(#{c.getR()},#{c.getG()},#{c.getB()});\n"
  res += "\n"
  await fs.writeFile "./public/scss/kb_colors.scss", res, esc defer()
  cb null

# --------------------------------------------------------------------------------------

build_stylus_colors = (_, cb) ->
  esc = make_esc cb
  res = """
  /* This stylus file was itself autogenerated; run `make` in kb-styles to rebuild */\n\n
  """
  for color_name, c of colors.colors
    if c.getA()
      res += "kb_#{color_name} = rgba(#{c.getR()},#{c.getG()},#{c.getB()},#{c.getA()});\n"
    else
      res += "kb_#{color_name} = rgb(#{c.getR()},#{c.getG()},#{c.getB()});\n"
  res += "\n"
  await fs.writeFile "./public/styl/kb_colors.styl", res, esc defer()
  cb null


# --------------------------------------------------------------------------------------

build_bootstrap = (_, cb) ->
  esc = make_esc cb
  await sass.render {
    file: './src/kb_bootstrap.scss'
    includePaths:["#{config.dir.bootstrap_in}/assets/stylesheets"]
  }, esc defer bootstrap_css

  # write css file
  await fs.writeFile "./public/bootstrap/css/bootstrap.css", bootstrap_css.css, {encoding:'utf-8'}, esc defer()

  # cp JS and font files
  await exec "cp #{config.dir.bootstrap_in}/assets/javascripts/bootstrap*.js ./public/bootstrap/javascripts/", esc defer stdout, stderr
  await exec "cp #{config.dir.bootstrap_in}/assets/fonts/bootstrap/* ./public/bootstrap/fonts/", esc defer stdout, stderr
  cb null

# --------------------------------------------------------------------------------------

build_index_js = (_, cb) ->
  esc = make_esc cb
  exp = {colors:{}}

  console.log "Building JS"

  for color_name, c of colors.colors
    if c.getA() and (c.getA() < 1)
      exp.colors[color_name] =
        css: "rgba(#{~~c.getR()},#{~~c.getG()},#{~~c.getB()},#{c.getA().toFixed(3)})"
        r:   ~~c.getR()
        g:   ~~c.getG()
        b:   ~~c.getB()
        a:   c.getA()
    else
      exp.colors[color_name] =
        css: "rgb(#{~~c.getR()},#{~~c.getG()},#{~~c.getB()})"
        r:   ~~c.getR()
        g:   ~~c.getG()
        b:   ~~c.getB()

  res = """
  /* This index.js file was itself autogenerated; run `make` in kb-styles to rebuild */\n\n

  module.exports = #{JSON.stringify exp, null, 2}\n\n
  """
  await fs.writeFile "./index.js", res, esc defer()
  cb null

# --------------------------------------------------------------------------------------

build_toffee_passbacks = (_, cb) ->
  esc = make_esc cb
  color_lines = []
  console.log "Building Toffee"

  for color_name, c of colors.colors
    if c.getA() and (c.getA() < 1)
      color_lines.push """    "#{color_name}": rgba(#{~~c.getR()},#{~~c.getG()},#{~~c.getB()},#{c.getA().toFixed(3)})"""
    else
      color_lines.push """    "#{color_name}": rgb(#{~~c.getR()},#{~~c.getG()},#{~~c.getB()})"""

  res = """
  {#
  /* This Toffee file was itself autogenerated; run `make` in kb-styles to rebuild */\n\n

  passback.kb_styles =
    colors:
#{color_lines.join '\n'}
  #}
  """
  # write css file
  await fs.writeFile "./public/toffee/kbstyles.toffee", res, {encoding:'utf-8'}, esc defer()

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
await build_sass_colors null, main_esc defer()
await build_stylus_colors null, main_esc defer()
await build_bootstrap   null, main_esc defer()
await build_index_js null, main_esc defer()
await build_toffee_passbacks null, main_esc defer()


