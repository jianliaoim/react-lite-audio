
React = require 'react'

require 'volubile-ui/ui/index.less'
require './demo.css'
require './style.less'

LiteAudio = React.createFactory require './audio'

App = React.createClass
  displayName: 'page-app'

  render: ->
    source = 'http://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3'
    LiteAudio source: source, isUnread: true

PageApp = React.createFactory App

React.render PageApp(), document.querySelector('.demo')
