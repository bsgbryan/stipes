    c = require 'colors'

    style = (content, indent) ->
      out = ''
      if typeof content == 'string'
        out += content
      else if typeof content == 'number'
        out += content.toString().cyan
      else if typeof content == 'boolean'
        out += content.toString().underline
      else if typeof content == 'object'
        if Array.isArray content
          out = "\n#{[0...indent + 2].map((i) -> ' ').join ''}" + content
            .map (j) -> style j, indent + 2
            .join "\n#{[0...indent + 2].map((i) -> ' ').join ''}"
        else
          out = format_json content, indent + 2, false

      out

    format = (message) ->
      if typeof message == 'object'
        format_json message, 2
      else if typeof message != 'undefined'
        style message, 2
      else
        ''

    lead = (text, status) ->
      return "#{text.green}"  + '('.green  + status.italic + ') '.green  if text == 'SUCCESS'
      return "#{text.yellow}" + '('.yellow + status.italic + ') '.yellow if text == 'WARNING'
      return "#{text.cyan}"   + '('.cyan   + status.italic + ') '.cyan   if text == 'NOTICE'
      return "#{text.blue}"   + '('.blue   + status.italic + ') '.blue   if text == 'DEBUG'
      return "#{text.red}"    + '('.red    + status.italic + ') '.red    if text == 'ERROR'

    format_json = (json, indent = 2, newline = true) ->
      if json?
        depth = if newline then "\n#{[0...indent].map((i) -> ' ').join ''}" else ''

        Object
          .keys json
          .map (k) ->
            out = "#{depth[0...-2]} -#{k.magenta.bold}: "

            out += style json[k], indent

            out
          .join ''
      else
        ''

    module.exports = 
      format_json: format_json

      success: (status, message, json) -> console.log lead('SUCCESS', status) + "#{message.bold} " + format json
      warn:    (status, message, json) -> console.log lead('WARNING', status) + "#{message} "      + format json
      debug:   (status, message, json) -> console.log lead('NOTICE',  status) + "#{message} "      + format json
      notice:  (status, message, json) -> console.log (lead('DEBUG',  status) + "#{message} "      + format json).bgWhite
      error:   (status, message, json) -> console.log lead('ERROR',   status) + "#{message.bold} " + format json