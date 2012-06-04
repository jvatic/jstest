displayResult = (spec)->
  console.log spec.description, "#{spec.totalCount} specs | #{spec.totalCount - spec.passedCount} failing"


address = "http://localhost:4567/jasmine?js_files=Player,Song"
page = require('webpage').create()
phantom.injectJs("lib/utils/core.js")
page.open address, (status)->
  if status != 'success'
    console.log "Unable to access #{address} (#{status})"
  else
    page.onConsoleMessage = (msg...)-> console.log(msg...)

    check = ->
      page.evaluate ->
        typeof(jasmineComplete) != "undefined"

    onTestComplete = ->
      jasmineResults = page.evaluate ->
        return jasmineResults
      for spec in jasmineResults
        console.log spec
      phantom.exit()

    onTimeout = ->
      console.log "timed out"
      phantom.exit(1)

    utils.core.waitfor check, onTestComplete, onTimeout
