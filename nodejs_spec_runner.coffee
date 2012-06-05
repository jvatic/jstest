Browser = require 'zombie'
SpecPrinter = require './lib/spec_printer'

browser = new Browser
spec_printer = new SpecPrinter

files = process.argv.splice(2)

address = "http://localhost:4567/jasmine/#{files.join(',')}"

browser.visit address, ->
  timeout = null
  waitFor = (check, callback, checkInterval=100)->
    _check = ->
      if check()
        callback()
      else
        timeout = setTimeout _check, checkInterval

    _check()

  setTimeout (-> clearTimeout(timeout); console.log('Timed out')), 10000

  start = new Date
  console.log "Running specs...\n"
  waitFor (-> browser.window.jasmineObjectReporterFinished), ->
    spec_printer.processResults browser.window.jasmineObjectReporterResults, start, new Date

