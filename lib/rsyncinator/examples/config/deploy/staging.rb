##### rsyncinator
### ------------------------------------------------------------------
server "my-app-stage.example.com",
  :user                               => fetch(:deployment_username),
  :rsyncs                             => [ # rsyncinator
    {
      :from                             => "my-app.example.com",
      :dirs                             => {
        shared_path.join("var", "images") => shared_path.join("var", "images"),
        shared_path.join("public", "images") => shared_path.join("public", "images")
      }
    }
  ]
### ------------------------------------------------------------------
