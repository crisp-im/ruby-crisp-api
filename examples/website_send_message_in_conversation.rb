##
# ruby-crisp-api
#
# Copyright 2018, Valerian Saliou
# Author: Valerian Saliou <valerian@valeriansaliou.name>
##

require "crisp-api"

client = Crisp::Client.new

client.authenticate(
  "5c0595b2-9381-4a76-a2e0-04aa00c1ede7",
  "3bdb0812d0f5352bf68901ddc731434dade419b98507971905acdd2f967df61c"
)

# Message routing details
website_id = "6497e4a4-b17c-41e0-bfea-eea97ba8115a"
session_id = "session_f32bc993-f7ce-41af-bcd1-110fc147a392"

data = client.website.send_message_in_conversation(
  website_id, session_id,

  {
    "type" => "text",
    "content" => "This message was sent from ruby-crisp-api! :)",
    "from" => "operator",
    "origin" => "chat"
  }
)

puts data.inspect
