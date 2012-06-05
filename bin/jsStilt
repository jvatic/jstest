#!/usr/bin/env ruby

# jsStilt requires nodejs and runs your Jasmine specs in isolation super fast
# inspired by https://github.com/jstorimer/spin

require 'socket'
require 'tempfile' # Dir.tmpdir
require 'digest/md5'
require 'benchmark'
require 'optparse'

SEPARATOR = '|'

def usage
  <<-USAGE
Usage: jsStilt serve
       jsStilt push <file> <file>...
jsSilt preloads an asset server to speed up running your Jasmine specs
  USAGE
end

def socket_file
  key = Digest::MD5.hexdigest [Dir.pwd, 'jsStilt-gem'].join
  File.join(Dir.tmpdir, key)
end

def root_path
  File.expand_path(File.join __FILE__, '..', '..')
end

def serve_command
  "ruby " << File.join(root_path, 'app.rb')
end

def run_command
  "coffee #{ File.join(root_path, 'nodejs_spec_runner.coffee') }"
end

def log_file
  File.join(root_path, 'log', 'server.log')
end

def serve(asset_paths)
  file = socket_file
  File.delete(file) if File.exists?(file)

  socket = UNIXServer.open(file)

  pid = Process.fork
  if pid.nil?
    # in child
    sec = Benchmark.realtime do
      `#{ serve_command } #{ asset_paths.join(' ') } >> #{ log_file } 2>&1 &`
    end
    puts "Asset server started in #{sec}s..."
    return
  end

  loop do
    conn = socket.accept

    files = conn.gets.chomp
    files = files.split(SEPARATOR)

    run(files, conn)
  end
ensure
  if pid
    puts "Shutting down..."
    File.delete(file) if file && File.exists?(file)
    Process.kill("SIGQUIT", pid)
    Process.wait
  end
end

def run(files, conn)
  puts `#{ run_command } #{files.join(' ')}`
end

def push
  # Pass in JavaScript filenames to test
  # Assumes coresponding Jasmine specs are suffixed with _spec
  # Also assumes all files being passed are in the asset pipeline set in `jsStilt serve`
  files_to_load = ARGV

  files_to_load = files_to_load.map do |file_name|
    if File.exists?(file_name)
      File.expand_path(file_name)
    end
  end.compact.uniq

  f = files_to_load.join(SEPARATOR)

  abort if f.empty?
  puts "Running specs for #{f}"

  socket = UNIXSocket.open(socket_file)
  socket.puts f
rescue Errno::ECONNREFUSED, Errno::ENOENT
  abort "Connection was refused. Have you started up `jsStilt serve` yet?"
end

options = OptionParser.new do |opts|
  opts.banner = usage
  opts.separator ""
  opts.separator "Server Options:"
end
options.parse!

subcommand = ARGV.shift
asset_paths = ARGV

case subcommand
when 'serve' then serve(asset_paths)
when 'push' then push
else
  $stderr.puts options
  exit 1
end

