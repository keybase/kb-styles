gulp       = require 'gulp'
sass       = require 'node-sass'
{make_esc} = require 'iced-error'
fs         = require 'fs'

config =
  dir:
    bootstrap: './bower_components/bootstrap-sass'
    public:    './public'

# --------------------------------------------------------------------------------------

make_sass_from_iced_vars = (_, cb) ->

# --------------------------------------------------------------------------------------

build_bootstrap = (_, cb) ->
  esc = make_esc cb
  await sass.render {
    file: './src/kb_bootstrap.scss'
    includePaths:["#{config.dir.bootstrap}/assets/stylesheets"]
  }, esc defer bootstrap_css
  await fs.writeFile "./public/css/kb_bootstrap.css", bootstrap_css.css, {encoding:'utf-8'}, esc defer()
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
await build_bootstrap null, main_esc defer()
