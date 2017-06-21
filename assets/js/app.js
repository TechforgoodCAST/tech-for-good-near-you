import 'phoenix_html'

import ElmApp from './elm.js'
import elmEmbed from './elm-embed.js'

if (window.ElmApp.boot) {
  elmEmbed.init(ElmApp)
}
