/* @flow */

// Fixes network calls in tests env.
global.XMLHttpRequest = require('xhr2').XMLHttpRequest
