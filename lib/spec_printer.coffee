class SpecPrinter
  constructor: ->
    @color = require("ansi-color").set

  processResults: (objectReporterResults, start, finish)->
    totalCount = objectReporterResults.totalCount
    failedCount = objectReporterResults.failedCount

    passedCount = totalCount - failedCount

    dots = ""
    for i in [1..passedCount]
      dots += @color(".", 'green')

    for i in [1..failedCount]
      dots += @color("F", 'red')

    console.log dots
    console.log "#{ @pluralize(totalCount, 'spec') }, #{ failedCount } failing, completed in #{finish - start} seconds\n"

    for spec in objectReporterResults.specs
      failedCount = spec.failedCount
      totalCount = spec.totalCount

      if failedCount > 0
        console.log @color("\n#{ spec.description }", 'red+underline')
        for item in spec.items
          console.log @color("\t#{item.message}", 'red')
          console.log @color("\texpected #{item.expected} #{item.matcherName} #{item.actual}", 'red') if item.expected && item.matcherName && item.actual
          console.log @color("\t#{ item.trace.stack.join("\n\t") }", 'bold') unless item.trace == ''
      else
        console.log @color(spec.description, 'green')

  pluralize: (num, word)=>
    word = "#{word}s" if num > 1
    "#{num} #{word}"

module.exports = SpecPrinter
