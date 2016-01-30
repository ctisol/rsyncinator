desc "Rsync according to each host's settings"
task :rsync => 'deployinator:load_settings' do
  on roles(:all) do |host|
    as :root do
      with :ssh_auth_sock => capture("echo $SSH_AUTH_SOCK") do
        if host.properties.rsyncs.nil?
          info ""
          info "No syncs defined for #{host}"
        else
          execute "mkdir", "-p", Pathname.new(fetch(:rsync_log_file)).split.first.to_s
          host.properties.rsyncs.each do |sync|
            sync[:dir_sets].each do |dir_set|
              dir_set[:excludes] ||= []
              set :rsync_excludes,      dir_set[:excludes].collect { |exclude| "--exclude '#{exclude.to_s}'" }.join(' ')
              set :rsync_from_host,     sync[:from]
              set :rsync_source,        dir_set[:from_dir]
              set :rsync_destination,   dir_set[:to_dir]
              rsync(host)
            end
          end
        end
      end
    end
  end
end

namespace :rsync do

  desc "Rsync according to each host's settings using the --dry-run option"
  task :dry => 'deployinator:load_settings' do
    set :rsync_options, "--dry-run"
    Rake::Task["rsync"].invoke
  end

  desc "Rsync according to each host's settings using the --delete option"
  task :delete => 'deployinator:load_settings' do
    set :rsync_options, "--delete"
    Rake::Task["rsync"].invoke
  end

  namespace :delete do
    desc "Rsync according to each host's settings using the --delete and --dry-run options"
    task :dry => 'deployinator:load_settings' do
      set :rsync_options, "--dry-run --delete"
      Rake::Task["rsync"].invoke
    end
  end

  desc "Show the latest sync in the log file"
  task :log => 'deployinator:load_settings' do
    on roles(:all), in: :sequence do |host|
      as :root do
        info "Latest Rsync run on #{host}"
        rsync_log_run(host).lines.each { |line| info line }
      end
    end
  end

  namespace :log do
    desc "Show the last few lines of the sync's log file"
    task :tail => 'deployinator:load_settings' do
      on roles(:all), in: :sequence do |host|
        as :root do
          info "From #{host}:"
          rsync_log_tail(host).lines.each { |line| info line }
          info ""
        end
      end
    end
  end

end

