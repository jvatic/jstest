if ! jasmine
  throw new Exception("jasmine library does not exist in global namespace!")

class ObjectReporter
  constructor: ->
    @started  = false
    @finished = false

    @results = {
      totalCount: 0
      failedCount: 0
      specs: []
    }

  reportRunnerResults: (runner)=>
    for suite in runner.suites()
      name = suite.description
      _suite = suite
      while _suite.parentSuite
        _suite = _suite.parentSuite
        name = "#{ _suite.description } #{ name }"

      for spec in suite.specs()
        results = spec.results()
        items = results.getItems()

        failedCount = 0
        items = for item in items
          failedCount += 1 unless item.passed()

          if item.trace && item.trace.stack
            item.trace.stack = for shard in item.trace.stack.split("\n")
              shard.replace(/^\s*/, '')
          item

        @results.specs.push {
          passed: results.passed()
          description: "#{name} #{spec.description}"
          items: items
          failedCount: failedCount
          totalCount: items.length
        }

        @results.totalCount += items.length
        @results.failedCount += failedCount

    window.jasmineObjectReporterFinished = true
    window.jasmineObjectReporterResults = @results

jasmine.ObjectReporter = ObjectReporter
