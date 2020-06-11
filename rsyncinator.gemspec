Gem::Specification.new do |s|
  s.name        = 'rsyncinator'
  s.version     = '0.1.0'
  s.date        = '2015-10-13'
  s.summary     = "Define and run Rsyncs repeatably"
  s.description = "Capistrano Plugin to run Rsyncs repeatably"
  s.authors     = ["Kishore", "Dhanesh"]
  s.email       = "kishore@railsfactory.com"
  s.files       = [
    "lib/rsyncinator.rb",
    "lib/rsyncinator/rsync.rb",
    "lib/rsyncinator/config.rb",
    "lib/rsyncinator/check.rb",
    "lib/rsyncinator/built-in.rb",
    "lib/rsyncinator/examples/Capfile",
    "lib/rsyncinator/examples/config/deploy.rb",
    "lib/rsyncinator/examples/config/deploy/staging.rb"
  ]
  s.required_ruby_version  =                '>= 1.9.3'
  s.requirements           <<               "Rsync"
  s.add_runtime_dependency 'capistrano',    '~> 3.2.1'
  s.add_runtime_dependency 'deployinator'
  s.add_runtime_dependency 'colorize',      '= 0.7.3'
  s.add_runtime_dependency 'rake',          '~> 10.3.2'
  s.add_runtime_dependency 'sshkit',        '~> 1.5.1'
  s.homepage    =
    'https://github.com/ctisol/rsyncinator'
  s.license     = 'GNU'
end
