Warbler.framework_detection = false
Warbler::Config.new do |config|
  config.webxml.rails.env = 'development'
  config.webinf_files += FileList[".env"]
end