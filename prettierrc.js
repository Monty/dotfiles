// Enable prettier to format awk files

// Uses os.homedir() since prettier does not expand ~ in config files.
// plugins points to the compiled output of prettier-plugin-awk
// in ~/.local/lib/prettier-plugin-awk

// ~/dotfiles/lib.dir/prettier-plugin-awk is copied there
// by ~/dotfiles/install.sh only if a prettier executable is found
// The user must afterwards build the the code:
// cd ~/.local/lib/prettier-plugin-awk && npm install && npx tsc -b

const os = require('os')

module.exports = {
  plugins: [os.homedir() + '/.local/lib/prettier-plugin-awk/out/index.js'],
}
