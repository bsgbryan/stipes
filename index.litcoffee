    c = require 'colors'

    style = (content) ->
      if typeof content == 'string'
        content
      else if typeof content == 'number'
        content.toString().cyan
      else if typeof content == 'boolean'
        content.toString().underline

    format = (message) ->
      if typeof message == 'object'
        format_json message
      else if typeof message != 'undefined'
        style message
      else
        ''

    lead = (text, status) ->
      return "#{text.green}"  + '('.green  + status.italic + ') '.green  if text == 'SUCCESS'
      return "#{text.yellow}" + '('.yellow + status.italic + ') '.yellow if text == 'WARNING'
      return "#{text.cyan}"   + '('.cyan   + status.italic + ') '.cyan   if text == 'NOTICE'
      return "#{text.blue}"   + '('.blue   + status.italic + ') '.blue   if text == 'DEBUG'
      return "#{text.red}"    + '('.red    + status.italic + ') '.red    if text == 'ERROR'

    format_json = (json, indent = 2) ->
      if json?
        depth = "\n#{[0...indent].map((i) -> ' ').join ''}"

        Object
          .keys json
          .map (k) ->
            out = "#{depth}#{k.magenta.bold}: "

            if typeof json[k] == 'object'
              if Array.isArray json[k]
                out += json[k]
                  .map (j) -> style j
                  .join ', '
              else
                out += "\n#{format_json json[k], indent + 2}"
            else
              out += style json[k]

            out
          .join '\n'
      else
        ''

    module.exports = 
      format_json: format_json

      success: (status, message, json) -> console.log lead('SUCCESS', status) + message.bold + format json
      warn:    (status, message, json) -> console.log lead('WARNING', status) + message      + format json
      debug:   (status, message, json) -> console.log lead('NOTICE',  status) + message      + format json
      notice:  (status, message, json) -> console.log (lead('DEBUG',  status) + message      + format json).bgWhite
      error:   (status, message, json) -> console.log lead('ERROR',   status) + message.bold + format json