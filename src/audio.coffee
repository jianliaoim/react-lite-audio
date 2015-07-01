
React = require 'react/addons'
cx    = require 'classnames'

div    = React.createFactory 'div'
span   = React.createFactory 'span'
audio  = React.createFactory 'audio'

T  = React.PropTypes

module.exports = React.createClass
  displayName: 'quote-audio'

  propTypes:
    isUnread: T.bool
    duration: T.number
    source: T.string.isRequired

  getDefaultProps: ->
    isUnread: false

  getInitialState: ->
    pause: true
    played: false
    playPercent: 0
    duration: @props.duration or 0

  componentDidMount: ->
    @_audioEl = @refs.audio.getDOMNode()
    @_audioEl.addEventListener 'durationchange', @setDuration
    @_audioEl.addEventListener 'timeupdate', @updateProgress
    @_audioEl.addEventListener 'ended', @endProgress

  componentWillUnmount: ->
    @_audioEl.removeEventListener 'durationchange', @setDuration
    @_audioEl.removeEventListener 'timeupdate', @updateProgress
    @_audioEl.removeEventListener 'ended', @endProgress

  setDuration: ->
    # safari may get wrong duration
    defaultDuration = @props.duration or 0
    duration = Math.round @_audioEl.duration
    if defaultDuration < duration
      @setState duration: duration

  updateProgress: ->
    currentTime = @_audioEl.currentTime
    playPercent = currentTime / @state.duration * 100
    @setState playPercent: playPercent
    if currentTime >= @state.duration
      @endPlay()

  endProgress: ->
    @endPlay()

  endPlay: ->
    @setState pause: true, playPercent: 0

  playClick: ->
    if @_audioEl.paused
      @_audioEl.play()
      @setState pause: false, played: true
    else
      @_audioEl.pause()
      @setState pause: true, played: true

  render: ->
    src = @props.source
    duration = @state.duration

    className = cx 'icon',
      'icon-play': @state.pause
      'icon-pause': not @state.pause

    classNameProgress = cx 'progress',
      'is-playing': not @state.pause

    timelineStyle = width: duration / 60 * 100 + 100
    progressStyle = width: "#{@state.playPercent}%"

    div className: 'lite-audio',
      div className: 'audio-player', style: timelineStyle, onClick: @playClick,
        div className: 'content',
          span className: className
          span className: 'time', duration
        div className: classNameProgress, style: progressStyle
      audio ref: 'audio', src: src
      if (not @state.played) and this.props.isUnread
        div className: 'unread-dot'
