# PRIVATE CLASS: do not call directly
class mongodb::mongos::config (
  $ensure          = $mongodb::mongos::ensure,
  $config          = $mongodb::mongos::config,
  $config_content  = $mongodb::mongos::config_content,
  $config_template = $mongodb::mongos::config_template,
  $configdb        = $mongodb::mongos::configdb,
) {

  if ($ensure == 'present' or $ensure == true) {

    #Pick which config content to use
    if $config_content {
      $config_content_real = $config_content
    } elsif $config_template {
      $config_content_real = template($config_template)
    } else {
      $config_content_real = template('mongodb/mongodb-shard.conf.erb')
    }

    file { $config:
      content => $config_content_real,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

  }

}
