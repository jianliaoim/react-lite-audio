
React = require 'react'
ReactDOM = require 'react-dom'

require 'volubile-ui/ui/index.less'
require './demo.css'
require './style.less'

LiteAudio = React.createFactory require './audio'
LiteAudioSlim = React.createFactory require './audio-slim'

div   = React.createFactory 'div'

App = React.createClass
  displayName: 'page-app'

  render: ->
    source = 'http://www.alexkatz.me/codepen/music/interlude.mp3'
    div null,
      div className: 'wrapper',
        div null, 'LiteAudio: audio palyer with progress-bar'
        LiteAudio source: source, isUnread: true
      div className: 'wrapper',
        div null, 'LiteAudioSlim: audio palyer with progress-tip'
        LiteAudioSlim source: source, isUnread: true

PageApp = React.createFactory App

ReactDOM.render PageApp(), document.querySelector('.demo')
