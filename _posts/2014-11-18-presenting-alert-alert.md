---
layout: post
title: Presenting Alert! Alert!
date: 2014-11-18 12:00
description: Alert! Alert! is dependency-free JavaScript library to easily add UI notifications to any web project.
category: blog
tags: javascript programming
---

I built a little, dependency-free JavaScript library to add UI notifications to any web project:

 - [Demo on Codepen](https://codepen.io/whusterj/pen/qEWMwG).
 - [Code on Github](https://github.com/whusterj/alert-alert).

You’ll need to compile the LESS CSS before use … I’ll eventually add a Gruntfile or something.

It’s very simple to use:

```javascript
Alert.alert('info', 'A message', {timeout: 7000});
```

The last param is optional. If a timeout is given, the notification will disappear after the given number of milliseconds.

It's nothing groundbreaking, but I was frustrated by the options out there that seem to over-complicate such a trivial thing.

---

### Complete Source Code

Here is the complete source code, which totals about 150 lines of JavaScript and CSS (LESS).

**alert-alert.js**

```javascript
'use strict';

module.exports = (function () {

  var container,
      CONTAINER_ID  = 'aa-container',
      ALERT_CLASS   = 'aa-notification';

  exports = {
    alert: _alert
  };

  return exports;

  /////////////////////////////////////////
  // functions

  function _alert (type, message, config) {
    if (typeof(config) === 'undefined') { config = {}; }
    if (!container) { container = _genNotificationContainer(); }
    container.appendChild(
      _genAlertDiv(type, message, config.timeout)
    );
  }

  function _genNotificationContainer () {
    if (container) { return; }
    var containerDiv = document.createElement('div');
    containerDiv.id = CONTAINER_ID;
    document.body.appendChild(containerDiv);
    return containerDiv;
  }

  function _genAlertDiv (type, message, timeout) {
    var alertDiv = document.createElement('div');
    alertDiv.className = ALERT_CLASS + ' ' + type;
    alertDiv.innerHTML = message;

    //
    alertDiv.addEventListener('click', _alertClickHandler);

    //
    if (timeout) {
      alertDiv.timeout = setTimeout(
        function () {
          _removeAlert(alertDiv);
        }, timeout); 
    }

    return alertDiv;
  }

  function _removeAlert (alert) {
    window.clearTimeout(alert.timeout);
    container.removeChild(alert);
  }

  function _alertClickHandler (event) {
    _removeAlert(event.currentTarget);
  }

})();
```

**alert-alert.css**

```css
#aa-container {
  position: fixed;
  top: 12px;
  right: 12px;
  z-index: 1001;
}

.aa-notification {
  width: 300px;
  min-height: 40px;
  padding: 12px;
  margin-bottom: 12px;
  background-color: white;
  border-left: 4px solid rgb(100, 100, 100);
  border-radius: 3px;
  cursor: pointer;
  box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.6);
  transition: 0.3s linear all;
}

.aa-notification:hover {
  transform: scale(1.06);
  box-shadow: 3px 3px 4px gba(0, 0, 0, 0.6);
}

.aa-notification.info {
  border-left-color: rgb(100, 100, 200);
}

.aa-notification.success {
  border-left-color: rgb(100, 180, 100);
}

.aa-notification.warning {
  border-left-color: rgb(230, 215, 100);
}

.aa-notification.error {
  border-left-color: rgb(230, 100, 100);
}
```
