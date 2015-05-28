
React Lite Audio
----

Audio component from Talk by Teambition.

Demo http://teambition.github.io/react-lite-audio/

### Properties

#### Audio

### Supposition

### Usage

```bash
npm i --save react-lite-dropdown
```

Read [src/main.jsx](main)(compiles with Babel) for details:

[main]: https://github.com/teambition/react-lite-dropdown/blob/gh-pages/src/main.jsx

```jsx
import {default as React} from 'react';
import './demo.css';

import {default as LiteDropdown} from 'react-lite-dropdown';
import 'react-lite-dropdown/src/style.css'; // CSS if you need

var languages = 'CoffeeScript PureScript Elm CirruScript'.split(' ');

var App = React.createClass({
  render: function() {
  }
});

var PageApp = React.createFactory(App);

var demo = document.querySelector('.demo');

React.render(PageApp(), demo);
```

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

### License

MIT
