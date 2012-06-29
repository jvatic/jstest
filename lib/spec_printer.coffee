class SpecPrinter
  constructor: ->
    @color = require("ansi-color").set

  processResults: (objectReporterResults, start, finish)->
    unless objectReporterResults
      console.log "No results\n"
      return

    totalCount = objectReporterResults.totalCount - 1
    failedCount = objectReporterResults.failedCount
    pendingCount = objectReporterResults.pendingCount

    passedCount = totalCount - failedCount - pendingCount

    if totalCount == 0
      return console.log("No Specs to run!")

    dots = ""
    for spec in objectReporterResults.specs
      i = spec.passedCount
      if i > 0
        dots += @color(".", 'green')

      i = spec.failedCount
      if i > 0
        dots += @color("F", 'red')

      i = spec.pendingCount
      if i > 0
        dots += @color("*", 'yellow')

    console.log dots
    console.log "#{ @pluralize(totalCount, 'spec') }, #{ failedCount } failing, #{ pendingCount } pending, completed in #{ @pluralize(finish - start, "seconds") }\n"

    for spec in objectReporterResults.specs
      continue if spec.description.match('jsStilt-IGNOREME')
      failedCount = spec.failedCount
      pendingCount = spec.pendingCount
      totalCount = spec.totalCount

      if failedCount > 0
        console.log @color("\n#{ spec.description }", 'red+underline')
        for item in spec.items
          console.log @color("\t#{item.message}", 'red')
          console.log @color("\texpected #{item.expected} #{item.matcherName} #{item.actual}", 'red') if item.expected && item.matcherName && item.actual
          console.log @color("\t#{ item?.trace?.stack?.join("\n\t") }\n", 'bold')
      else if pendingCount > 0
        console.log @color(spec.description, 'yellow')
      else
        console.log @color(spec.description, 'green')
    console.log ""

  pluralize: (num, word)=>
    word = "#{word}s" if num > 1
    "#{num} #{word}"

module.exports = SpecPrinter
