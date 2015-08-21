set :rsync_user,        -> { fetch(:deployment_username) }
set :rsync_log_file,    -> { shared_path.join('log', 'rsyncinator.log') }
set :rsync_tail_lines,  "10"

def rsync(host, from_host, source, destination)
  execute(
    "rsync", "-ah", fetch(:rsync_options),
    "--rsh", "\"ssh", "-o", "PasswordAuthentication=no", "-o", "StrictHostKeyChecking=no\"",
    "--log-file", fetch(:rsync_log_file),
    "#{fetch(:rsync_user)}@#{from_host}:#{source}", destination
  )
end

def rsync_log_run(host)
  capture("tac #{fetch(:rsync_log_file)} | grep 'receiving file list' -B100000 -m1 | tac")
end

def rsync_log_tail(host)
  capture "tail", "-n", fetch(:rsync_tail_lines), fetch(:rsync_log_file)
end
