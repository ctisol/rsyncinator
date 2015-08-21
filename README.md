rsyncinator
============

*Repeatably Rsync between Capistrano roles*

This is a Capistrano 3.x plugin, and relies on SSH access with passwordless sudo rights.

### Installation:
* `gem install rsyncinator` (Or add it to your Gemfile and `bundle install`.)
* Add "require 'rsyncinator'" to your Capfile
`echo "require 'rsyncinator'" >> Capfile`
* Create example configs:
`cap rsyncinator:write_example_configs`
* Turn them into real configs by removing the `_example` portions of their names, and adjusting their content to fit your needs. (Later when you upgrade to a newer version of rsyncinator, you can `rsyncinator:write_example_configs` again and diff your current configs against the new configs to see what you need to add.)
* Add the `rsync_from` OR `rsync_to` role to your each host you want to sync from/to. A host with the role `rsync_from` will refuse to be an Rsync destination, while a host with the role `rsync_to` may be either an Rsync source or destination. Currently only one host may be given the `rsync_from` role.

### Usage:
`cap -T` will help remind you of the available commands, see this for more details.
* After setting up your config files during installation simply run:
`cap <stage> rsync`
* If you want to use Rsync's `--delete` option simply run:
`cap <stage> rsync:with_delete`
* Run `cap <stage> rsync:log` to see the last few lines of the Rsync log file. (For programmatically checking on long running syncs.)

###### Debugging:
* You can add the `--trace` option at the end of a command to see when which tasks are invoked, and when which task is actually executed.
