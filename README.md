jsStilt
=======

jsStilt speeds up your JavaScript testing workflow.

Your Rails environment is completely bypassed (and not required to even be there) to run your Jasmine specs from the assets pipeline.

Installation
============

```ruby
gem i jsStilt
```

jsStilt assumes you have Jasmine specs and use sprockets. It also assumes you have CoffeeScript and node.js installed.

Usage
=====

```bash
jsStilt serve app/assets/javascripts vender/assets/javascripts lib/assets/javascripts
```

Once the server is running (which it should be almost instantly), you can use the `push` command to specify which JavaScript files to test:

```bash
jsStilt push app/assets/javascripts/my_awesome_application.js.coffee
```

OR you can specify just the path relative to your assets directory:

```bash
jsStilt push my_awesome_application.js.coffee
```

(You don't even need the file extention: `jsStilt push my_awesome_application`)

All the above `push` commands will load `my_awesome_application.js` and `my_awesome_application_spec.js` through a standalone sprockets server (which will compile your CoffeeScript files) and the output printed Rspec style in your terminal.

You may pass any number of files to `push` separated with a space.

### With Kicker

See `.kick` for an example recipe.


Motivation
==========

I use [spin by jstorimer](https://github.com/jstorimer/spin) to run my Rails tests. Since JavaScript tests are also important, I started searching around for a decent way of automating that flow. [Evergreen](https://github.com/jnicklas/evergreen) doesn't handle sprockets and therefor doesn't work with Rails 3.1+. It also assumes your specs are in a cetain directory.

After looking at serveral other options (mostly loosly hacked together phantomjs scripts), I decided to just write something myself. My requirements were that it be easy to setup and use (like spin), not care where my specs are located, and be really fast. A combination of Sinatra, Sprockets, Node.js + Zombie, and Ruby is what I settled on.

Contributing
============

This was quickly hacked together, and I'll accept pull requests that make the project better (e.g. support for QUnit).

Related Projects
================

* [spin](https://github.com/jstorimer/spin)
* [Evergreen](https://github.com/jnicklas/evergreen)
* [jasmine-gem](https://github.com/pivotal/jasmine-gem)
