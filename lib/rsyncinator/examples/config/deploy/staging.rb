##### rsyncinator
### ------------------------------------------------------------------
server "my-app-stage.example.com",
  :user                               => fetch(:deployment_username),
  :rsyncs                             => [ # rsyncinator
    {
      :from                             => "my-app.example.com",
      :dir_sets                         => [
        {
          :from_dir   => shared_path.join("var", "images"),
          :to_dir     => shared_path.join("var", "images"),
          :excludes   => [shared_path.join("var", "tmp"), "*.tmp"]
        },
        {
          :from_dir   => shared_path.join("public", "assets"),
          :to_dir     => shared_path.join("public", "assets"),
          :excludes   => ["tmp/*"]
        }
      ]
    }
  ]
### ------------------------------------------------------------------
