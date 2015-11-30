
React Lite Audio
----

Audio component from Talk by Teambition.

Demo http://ui.talk.ai/react-lite-audio/

### Properties

* `source`: url for audio file
* `isUnread`: a Boolean, when true, an unread button is rendered
* `duration`: a Number, is Safari, duration is not correct, try this

### Supposition

* Only one piece of audio is playing at one moment.

### Usage

```bash
npm i --save react-lite-audio
```

Use in Webpack:

```coffee
require('react-lite-audio').liteAudio
require('react-lite-audio').liteAudioSlim
require 'react-lite-audio/src/style.less'
# icons are from teambition/icon-fonts , volubile-ui
```

Read [src/main.main](main)(compiles with Babel) for details:

[main]: https://github.com/teambition/react-lite-audio/blob/master/src/main.coffee

### Develop

```text
npm i
```

You need a static file server for the HTML files. Personally I suggest using Nginx.

Develop:

```bash
gulp html # regenerate index.html
webpack-dev-server --hot # enable live-reloading
```

Build (Pack and optimize js, reivision js and add entry in `index.html`):

```bash
gulp build
```

### Special notice

However there is a significant anomaly here in Opera, Safari and IE10, which is that the .paused flag remains false when the media has ended.
You can see the problem [here](here)

Fixed by firing the pause() method and setting currentTime at 0 manually, in response to the "ended" event
[here]:http://www.sitepoint.com/essential-audio-and-video-events-for-html5/

### License

MIT
