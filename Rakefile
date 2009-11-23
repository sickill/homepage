require 'nanoc3/tasks'

desc "Compile site"
task :compile do
  system "nanoc3 co"
end

desc "Compile .less"
task :compile_less do
  puts "Compiling .less"
  `lessc assets/css/master.less`
end

desc "Link static assets to output dir"
task :link_assets do
  %w(css javascripts images favicon.ico robots.txt).each do |file|
    src = "../assets/#{file}"
    dst = "output/#{file}"
    `ln -s #{src} #{dst}` unless File.exist?(dst)
  end
end

task :rmrf do
  system "rm -rf output"
end

desc "Create new post"
task :post do
  require 'erb'
  require 'ostruct'
  title = ENV['title']
  markup = ENV['markup'] || 'textile'
  if title.nil?
    puts 'rake post title="Some title"'
    exit
  end
  tpl = File.read('templates/post.erb')
  now = Time.now
  slug = title.downcase.gsub(/[\s\.]+/, '-').gsub(/[^a-z0-9\-]/, '').gsub(/\-{2,}/, '-')
  filename = "content/blog/#{Time.now.strftime('%Y-%m-%d-')}#{slug}.#{markup}"
  File.open(filename, "w") { |f| f.write ERB.new(tpl).result(binding) }
  puts "running: #{ENV['EDITOR']} #{filename}"
  system "$EDITOR #{filename}"
end

desc "Start local adsf server"
task :server do
  system "cd output; adsf -p 4000 &"
  system "sleep 1; firefox http://localhost:4000/"
end

task :full_compile => [:compile, :compile_less, :link_assets]
task :deploy => [:full_compile, :"deploy:rsync"]
task :recompile => [:rmrf, :full_compile]

