describe "Dummy", ->
  it "should initialize with name and location", ->
    [name, location] = ["John Doe", "Toronto"]
    dummy = new Dummy(name, location)

    expect(dummy.getName()).toEqual(name)
    expect(dummy.getLocation()).toEqual(location)

  describe "#getName", ->
    describe "dumb assertion", ->
      it "should fail", ->
        dummy = new Dummy

        expect(dummy.getName()).toEqual('Blinky Bate')

  it "should set name", ->
    dummy = new Dummy

    name = "John Doe"
    dummy.setName name
    expect(dummy.getName()).toEqual(name)

  it "should set location", ->
    dummy = new Dummy

    location = "Toronto"
    dummy.setLocation location
    expect(dummy.getLocation()).toEqual(location)

  describe "#nameWithLocation()", ->
    it "should return name and location", ->
      [name, location] = ["John Doe", "Toronto"]
      dummy = new Dummy(name, location)

      res = dummy.nameWithLocation()
      expect(res).toMatch(name)
      expect(res).toMatch(location)
