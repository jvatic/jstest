Browser = require 'zombie'
SpecPrinter = require './lib/spec_printer'

browser = new Browser
spec_printer = new SpecPrinter

files = process.argv.splice(2)

address = "http://localhost:4567/jasmine/#{files.join(',')}"
console.log "Loading ", address, "..."

browser.visit address, ->
  timeout = null
  start = new Date
  maxWaitMs = 5000 # jasmine will timeout after 5 seconds
  waitFor = (check, callback, checkInterval=100)->
    _check = ->
      if check() || (new Date - start) >= maxWaitMs
        callback()
      else
        timeout = setTimeout _check, checkInterval

    _check()

  console.log "Running specs...\n"
  waitFor (-> browser.window.jasmineObjectReporterFinished), ->
    spec_printer.processResults browser.window.jasmineObjectReporterResults, start, new Date

