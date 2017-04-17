%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
  application.yml
).each { |path| Spring.watch(path) }
