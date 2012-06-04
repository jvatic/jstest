require 'bundler/setup'
Bundler.require

assets = Sprockets::Environment.new do |env|
  env.logger = Logger.new(STDOUT)
end

paths = %w{ javascripts stylesheets images }
paths.each do |path|
  assets.append_path("public/assets/#{path}")
end

ARGV.each do |path|
  if File.exists?(path)
    assets.append_path(path)
  end
end

module AssetHelpers
  def asset_path(name)
    "/assets/#{name}"
  end
end

assets.context_class.instance_eval do
  include AssetHelpers
end

get '/assets/*' do
  new_env = env.clone
  new_env["PATH_INFO"].gsub!("/assets", "")
  assets.call(new_env)
end

get '/jasmine/*' do
  @javascripts = (params[:splat].first || '').split(',')
  haml :jasmine
end

puts assets.paths.inspect
