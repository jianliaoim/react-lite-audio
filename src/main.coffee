
React = require 'react'

require 'volubile-ui/ui/index.less'
require './demo.css'
require './style.less'

LiteAudio = React.createFactory require './audio'

App = React.createClass
  displayName: 'page-app'

  render: ->
    source = 'http://www.alexkatz.me/codepen/music/interlude.mp3'
    LiteAudio source: source, isUnread: true

PageApp = React.createFactory App

React.render PageApp(), document.querySelector('.demo')
