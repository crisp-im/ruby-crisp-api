##
# ruby-crisp-api
#
# Copyright 2018, Valerian Saliou
# Author: Valerian Saliou <valerian@valeriansaliou.name>
##

require 'crisp-api'

client = Crisp::Client.new

client.authenticate(
  "5c0595b2-9381-4a76-a2e0-04aa00c1ede7",
  "3bdb0812d0f5352bf68901ddc731434dade419b98507971905acdd2f967df61c"
)

data = client.user.get_profile()

puts data.inspect
