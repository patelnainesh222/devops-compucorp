# A master class for drush.

class drush {
  # Make all the hiera-defined drushes, my pretties!
  $drush = hiera_hash('drush', false)
  if $drush {
    create_resources(drush::drush, $drush)
  }
}
