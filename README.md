# kb-styles

This project generates a number of outputs for having access to Keybase styles:

Setup:
 - `npm install -d` after checking out for the first time

Inputs:
  - `src/colors.iced` to change color variables
  - `src/kb_bootstrap_variables.scss` to change bootstrap's variables (can use stuff from colors)
  - `src/kb_bootstrap_overrides.scss` to change bootstrap's output (some things can't be controlled in vars, so this overrides the generated css as a last resort
  - `package.json` - make sure to increment version number if there are changes in a PR.
  
To compile and test it:

```bash
make
open public/html/bootstrap-demo.html
```

Feel free to add some more tests/extra divs to that demo html file.

Outputs:
  - a whole bunch of stuff in public for use in other projects


