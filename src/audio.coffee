React = require 'react/addons'
cx    = require 'classnames'

div   = React.createFactory 'div'
span  = React.createFactory 'span'
audio = React.createFactory 'audio'

T = React.PropTypes

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
    currentTime: 0
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
    if window.isFinite(duration) and defaultDuration < duration
      @setState duration: duration

  formatDuration: (duration) ->
    if duration <= 0
      return '00:00'
    minutes = Math.floor duration / 60
    seconds = Math.floor duration % 60
    minutes = if minutes >= 10 then minutes else '0' + minutes
    seconds = if seconds >= 10 then seconds else '0' + seconds
    durationFormat = minutes + ':' + seconds

    return durationFormat

  updateProgress: ->
    currentTime = @_audioEl.currentTime
    @setState currentTime: currentTime
    if currentTime >= @state.duration
      @endPlay()

  endProgress: ->
    @endPlay()

  endPlay: ->
    @setState pause: true
    # ".paused" flag remains false in Opera, Safari and IE10, when the audio has ended.
    # firing the pause() method manually in response to the "ended" event
    @_audioEl.pause()
    @_audioEl.currentTime = 0

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
    durationFormat = @formatDuration(duration)
    playPercent = @state.currentTime / @state.duration * 100

    className = cx 'icon',
      'icon-play': @state.pause
      'icon-pause': not @state.pause

    classNameProgress = cx 'progress',
      'is-playing': not @state.pause

    timelineStyle = width: duration / 60 * 100 + 100
    progressStyle = width: "#{playPercent}%"

    div className: 'lite-audio',
      div className: 'audio-player', style: timelineStyle, onClick: @playClick,
        div className: 'content',
          span className: className
          span className: 'time', durationFormat
        div className: classNameProgress, style: progressStyle
      audio ref: 'audio', src: src
      if (not @state.played) and this.props.isUnread
        div className: 'unread-dot'
