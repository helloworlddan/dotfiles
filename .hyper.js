// Daniel's hyper config

module.exports = {
  config: {
    updateChannel: 'stable',

    windowSize: [1400, 800],

    fontSize: 13,
    fontFamily: 'Hack',

    css: '',
    termCSS: '',

    showHamburgerMenu: '',
    showWindowControls: '',

    padding: '8px 8px 8px 8px',

    cursorBlink: true,
    cursorShape: 'BLOCK',
    cursorColor: '#ffffff',

    foregroundColor: '#ebdbb2',
    backgroundColor: '#282828',
    borderColor: '#555',

    colors         : {
      black        : '#282828',
      red          : '#fb4934',
      green        : '#b8bb26',
      yellow       : '#fabd2f',
      blue         : '#83a598',
      magenta      : '#d3869b',
      cyan         : '#8ec07c',
      white        : '#ebdbb2',
      lightBlack   : '#928374',
      lightRed     : '#fb4934',
      lightGreen   : '#b8bb26',
      lightYellow  : '#fabd2f',
      lightBlue    : '#83a598',
      lightMagenta : '#d3869b',
      lightCyan    : '#8ec07c',
      lightWhite   : '#ebdbb2'
    },

    paneNavigation   : {
      showIndicators : false,
      hotkeys        : {
        navigation   : {
          up         : 'command+alt+up',
          down       : 'command+alt+down',
          left       : 'command+alt+left',
          right      : 'command+alt+right'
        }
      }
    },

    shell: '',
    shellArgs: ['--login'],

    env: {},

    bell: 'visual',

    copyOnSelect: true
  },

  plugins: [
    'hypercwd',
    'hyper-pane',
    'hyperlinks'
  ],

  localPlugins: [],

  keymaps: {
  }
};
