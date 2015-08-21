namespace :rsync do
  namespace :check do

    desc 'Ensure all rsyncinator specific settings are set, and warn and exit if not.'
    task :settings do
      {
        (File.dirname(__FILE__) + "/examples/config/deploy.rb") => 'config/deploy.rb',
        (File.dirname(__FILE__) + "/examples/config/deploy/staging.rb") => "config/deploy/#{fetch(:stage)}.rb"
      }.each do |abs, rel|
        Rake::Task['deployinator:settings'].invoke(abs, rel)
        Rake::Task['deployinator:settings'].reenable
      end
    end

    namespace :settings do
      desc 'Print example rsyncinator specific settings for comparison.'
      task :print do
        set :print_all, true
        Rake::Task['rsync:check:settings'].invoke
      end
    end

  end
end
