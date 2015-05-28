
import {default as React} from 'react';
import './demo.css';
import './style.css';

import {default as LiteDropdown} from './dropdown';

var App = React.createClass({
  displayName: 'page-app',
  getInitialState: function() {
  },
  render: function() {
  }
});

var PageApp = React.createFactory(App);

var demo = document.querySelector('.demo');

React.render(PageApp(), demo);
