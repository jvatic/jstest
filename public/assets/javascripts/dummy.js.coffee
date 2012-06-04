class @Dummy
  constructor: (@name, @location)->

  setName: (name)=>
    @name = name

  getName: => @name

  setLocation: (location)=>
    @location = location

  getLocation: => @location
