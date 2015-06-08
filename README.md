Overview
========

This is a simple little module to write pretty things to the console and help you stay sane.

*NOTE* All stipes logging uses pretty colors. Colors are not, however, included in the examples below :disappointed:

Usage
=====

Simple messages
---------------

```coffeescript
stipes = require 'stipes'

stipes.debug 'Richard', "WHAT'S HAPPENING?!"
```

This will output `DEBUG(Richard) WHAT'S HAPPENING?!`

JSON data
---------

```coffeescript
stipes = require 'stipes'

stipes.error 'Postgres', 'ran into an error', error
```

This willl output the following:

```
ERROR(Tester) ran into an error
  code: 314159
  message: Expected cake
```

Available methods
=================

1. `success` - When good things happen
2. `warn` - When strange things happen
3. `error` - when the world ends
4. `notice` - just so you're aware
5. `debug` - To help you work through a tough spot