desc "Rsync according to each host's settings"
task :rsync do
  on roles(:all) do |host|
    as :root do
      with :ssh_auth_sock => capture("echo $SSH_AUTH_SOCK") do
        if host.properties.rsyncs.nil?
          info ""
          info "No syncs defined for #{host}"
        else
          execute "mkdir", "-p", Pathname.new(fetch(:rsync_log_file)).split.first.to_s
          host.properties.rsyncs.each do |sync|
            sync[:dirs].each do |source, destination|
              rsync(host, sync[:from], source, destination)
            end
          end
        end
      end
    end
  end
end

namespace :rsync do

  desc "Rsync according to each host's settings using the --dry-run option"
  task :dry do
    set :rsync_options, "--dry-run"
    Rake::Task["rsync"].invoke
  end

  desc "Rsync according to each host's settings using the --delete option"
  task :delete do
    set :rsync_options, "--delete"
    Rake::Task["rsync"].invoke
  end

  namespace :delete do
    desc "Rsync according to each host's settings using the --delete and --dry-run options"
    task :dry do
      set :rsync_options, "--dry-run --delete"
      Rake::Task["rsync"].invoke
    end
  end

  desc "Show the latest sync in the log file"
  task :log do
    on roles(:all), in: :sequence do |host|
      as :root do
        info "Latest Rsync run on #{host}"
        rsync_log_run(host).lines.each { |line| info line }
      end
    end
  end

  namespace :log do
    desc "Show the last few lines of the sync's log file"
    task :tail do
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

