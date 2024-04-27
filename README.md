# Crisp API Wrapper

[![Build and Release](https://github.com/crisp-im/ruby-crisp-api/workflows/Build%20and%20Release/badge.svg)](https://github.com/crisp-im/ruby-crisp-api/actions?query=workflow%3A%22Build+and+Release%22) [![RubyGems](https://img.shields.io/gem/v/crisp-api.svg)](https://rubygems.org/gems/crisp-api) [![Downloads](https://img.shields.io/gem/dt/crisp-api.svg)](https://rubygems.org/gems/crisp-api)

The Crisp API Ruby wrapper. Authenticate, send messages, fetch conversations, access your agent accounts from your Ruby code.

Copyright 2023 Crisp IM SAS. See LICENSE for copying information.

* **📝 Implements**: [REST API Reference (V1)](https://docs.crisp.chat/references/rest-api/v1/) at revision: 16/01/2023
* **😘 Maintainer**: [@valeriansaliou](https://github.com/valeriansaliou), [@eliottvincent](https://github.com/eliottvincent)

## Usage

You may follow the [REST API Quickstart](https://docs.crisp.chat/guides/rest-api/quickstart/) guide, which will get you running with the REST API in minutes.

Add the library to your `Gemfile`:

```bash
gem "crisp-api", "~> 1.1.12"
```

Then, import it:

```ruby
require "crisp-api"
```

Build a new authenticated Crisp client with your `identifier` and `key` tokens.

```ruby
client = Crisp::Client.new

client.set_tier("plugin")
client.authenticate(identifier, key)
```

Then, your client is ready to be consumed!

## Authentication

To authenticate against the API, obtain your authentication token keypair by following the [REST API Authentication](https://docs.crisp.chat/guides/rest-api/authentication/) guide. You'll get a token keypair made of 2 values.

**Keep your token keypair values private, and store them safely for long-term use.**

Then, add authentication parameters to your `client` instance right after you create it:

```ruby
client = Crisp::Client.new

# Authenticate to API with your plugin token (identifier, key)
# eg. client.authenticate("5c0595b2-9381-4a76-a2e0-04aa00c1ede7", "3bdb0812d0f5352bf68901ddc731434dade419b98507971905acdd2f967df61c")
client.set_tier("plugin")
client.authenticate(identifier, key)

# Now, you can use authenticated API sections.
```

## Resource Methods

Most useful available Crisp API resources are implemented. **Programmatic methods names are named after their label name in the [REST API Reference](https://docs.crisp.chat/references/rest-api/v1/)**.

All methods that you will most likely need when building a Crisp integration are prefixed with a star symbol (⭐).

In the following method prototypes, `crisp` is to be replaced with your Crisp API instance. For example, instanciate `client = Crisp()` and then call eg: `client.website.list_conversations(website_id, 1)`.

When calling a method that writes data to the API (eg. send a message with: `client.website.send_message_in_conversation()`), you need to submit it this way:

```ruby
website_id = "6497e4a4-b17c-41e0-bfea-eea97ba8115a"
session_id = "session_f32bc993-f7ce-41af-bcd1-110fc147a392"

client.website.send_message_in_conversation(
  website_id, session_id,

  {
    "type" => "text",
    "content" => "This message was sent from ruby-crisp-api! :)",
    "from" => "operator",
    "origin" => "chat"
  }
)
```

**⚠️ Note that, depending on your authentication token tier, which is either `user` or `plugin`, you may not be allowed to use all methods from the library. When in doubt, refer to the library method descriptions below. Most likely, you are using a `plugin` token.**

### Website

* **Website Conversations**
  * ⭐ **List Conversations** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-conversations)
    * `client.website.list_conversations(website_id, page_number)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      page_number = 1

      client.website.list_conversations(website_id, page_number);
      ```
      </details>

  * **Search Conversations** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-conversations)
    * `client.website.search_conversations(website_id, page_number, search_query, search_type, search_operator, include_empty, filter_unread, filter_resolved, filter_not_resolved, filter_mention, filter_assigned, filter_unassigned, filter_date_start, filter_date_end, order_date_created", order_date_updated)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      page_number = 1

      client.website.list_conversations(website_id, page_number);
      ```
      </details>


* **Website Conversation**
  * ⭐ **Create A New Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#create-a-new-conversation)
    * `client.website.create_new_conversation(website_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.create_new_conversation(website_id);
      ```
      </details>

  * **Check If Conversation Exists** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#check-if-conversation-exists)
    * `client.website.check_conversation_exists(website_id, session_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      client.website.check_conversation_exists(website_id, session_id);
      ```
      </details>

  * ⭐ **Get A Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-a-conversation)
    * `client.website.get_conversation(website_id, session_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      client.website.get_conversation(website_id, session_id);
      ```
      </details>

  * **Remove A Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#remove-a-conversation)
    * `client.website.remove_conversation(website_id, session_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      client.website.remove_conversation(website_id, session_id);
      ```
      </details>

  * **Initiate A Conversation With Existing Session** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#initiate-a-conversation-with-existing-session)
    * `client.website.initiate_conversation_with_existing_session(website_id, session_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      client.website.initiate_conversation_with_existing_session(website_id, session_id);
      ```
      </details>

  * ⭐ **Get Messages In Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-messages-in-conversation)
    * `client.website.get_messages_in_conversation(website_id, session_id, query)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      client.website.get_messages_in_conversation(website_id, session_id, query);
      ```
      </details>

  * ⭐ **Send A Message In Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#send-a-message-in-conversation)
    * `client.website.send_message_in_conversation(website_id, session_id, query)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      query = {
        "type" => "text",
        "from" => "operator",
        "origin" => "chat",
        "content" => "Hey there! Need help?"
      }

      client.website.send_message_in_conversation(website_id, session_id, query);
      ```
      </details>

  * **Update A Message In Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#update-a-message-in-conversation)
    * `client.website.update_message_in_conversation(website_id, session_id, fingerprint, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"
      fingerprint = 524653764345

      data = "Hey there! Need help?"

      client.website.update_message_in_conversation(website_id, session_id, fingerprint, data);
      ```
      </details>

  * **Compose A Message In Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#compose-a-message-in-conversation)
    * `client.website.compose_message_in_conversation(website_id, session_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      data = [
        "type" => "start",
        "from" => "operator"
      ]

      client.website.compose_message_in_conversation(website_id, session_id, data);
      ```
      </details>

  * ⭐ **Mark Messages As Read In Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#mark-messages-as-read-in-conversation)
    * `client.website.mark_messages_read_in_conversation(website_id, session_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      data = [
        "from" => "operator",
        "origin" => "urn:crisp.im:slack:0",
        "fingerprints" => [
          "5719231201"
        ]
      ]

      client.website.mark_messages_read_in_conversation(website_id, session_id, data);
      ```
      </details>

  * ⭐ **Mark Messages As Delivered In Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#mark-messages-as-delivered-in-conversation)
    * `client.website.mark_messages_delivered_in_conversation(website_id, session_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      data = [
        "from" => "operator",
        "origin" => "urn:crisp.im:slack:0",
        "fingerprints" => [
          "5719231201"
        ]
      ]

      client.website.mark_messages_delivered_in_conversation(website_id, session_id, data);
      ```
      </details>

  * ⭐ **Get Conversation Routing Assign** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-conversation-routing-assign)
    * `client.website.get_conversation_routing_assign(website_id, session_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      client.website.get_conversation_routing_assign(website_id, session_id);
      ```
      </details>

  * ⭐ **Assign Conversation Routing** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#assign-conversation-routing)
    * `client.website.assign_conversation_routing(website_id, session_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      data = [
        "assigned" => [
          "user_id" => "a4c32c68-be91-4e29-8a05-976e93abbe3f"
        ]
      ]

      client.website.assign_conversation_routing(website_id, session_id, data);
      ```
      </details>

  * ⭐ **Get Conversation Metas** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-conversation-metas)
    * `client.website.get_conversation_metas(website_id, session_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      client.website.get_conversation_metas(website_id, session_id);
      ```
      </details>

  * ⭐ **Update Conversation Metas** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#update-conversation-metas)
    * `client.website.update_conversation_metas(website_id, session_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      data = [
        "nickname" => "John Doe",
        "email" => "john.doe@acme-inc.com",
        "segments" => [
          "happy",
          "customer",
          "love"
        ],
        "data" => [
          "type" => "customer",
          "signup" => "finished"
        ]
      ]

      client.website.update_conversation_metas(website_id, session_id, data);
      ```
      </details>

  * **List Conversation Pages** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-conversation-pages)
    * `client.website.list_conversation_pages(website_id, session_id, page_number)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"
      page_number = 1

      client.website.list_conversation_pages(website_id, session_id, page_number);
      ```
      </details>

  * **List Conversation Events** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-conversation-events)
    * `client.website.list_conversation_events(website_id, session_id, page_number)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"
      page_number = 1

      client.website.list_conversation_events(website_id, session_id, page_number);
      ```
      </details>

  * **List Conversation Files** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-conversation-files)
    * `client.website.list_conversation_files(website_id, session_id, page_number)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"
      page_number = 1

      client.website.list_conversation_files(website_id, session_id, page_number);
      ```
      </details>

  * **Get Conversation State** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-conversation-state)
    * `client.website.get_conversation_state(website_id, session_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      client.website.get_conversation_state(website_id, session_id);
      ```
      </details>

  * ⭐ **Change Conversation State** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#change-conversation-state)
    * `client.website.change_conversation_state(website_id, session_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      data = "unresolved"

      client.website.change_conversation_state(website_id, session_id, data);
      ```
      </details>

  * **Get Block Status For Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-block-status-for-conversation)
    * `client.website.get_block_status_for_conversation(website_id, session_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      client.website.get_block_status_for_conversation(website_id, session_id);
      ```
      </details>

  * **Block Incoming Messages For Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#block-incoming-messages-for-conversation)
    * `client.website.block_incoming_messages_for_conversation(website_id, session_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      data = true

      client.website.block_incoming_messages_for_conversation(website_id, session_id, data);
      ```
      </details>

  * **Request Email Transcript For Conversation** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#request-email-transcript-for-conversation)
    * `client.website.request_email_transcript_for_conversation(website_id, session_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"

      data = [
        "to" => "operator",
        "email" => "valerian@crisp.chat"
      ]

      client.website.request_email_transcript_for_conversation(website_id, session_id, data);
      ```
      </details>


* **Website People** _(these are your end-users)_
  * **Get People Statistics** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-people-statistics)
    * `client.website.get_people_statistics(website_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.get_people_statistics(website_id);
      ```
      </details>

  * **List People Segments** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-suggested-people-segments)
    * `client.website.list_people_segments(website_id, page_number)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      page_number = 1

      client.website.list_people_segments(website_id, page_number);
      ```
      </details>

  * ⭐ **List People Profiles** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-people-profiles)
    * `client.website.list_people_profiles(website_id, page_number)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      page_number = 1

      client.website.list_people_profiles(website_id, page_number);
      ```
      </details>

  * ⭐ **Add New People Profile** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#add-new-people-profile)
    * `client.website.add_new_people_profile(website_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      data = [
        "email" => "valerian@crisp.chat",
        "person" => [
          "nickname" => "Valerian Saliou"
        ]
      ]

      client.website.add_new_people_profile(website_id, data);
      ```
      </details>

  * ⭐ **Check If People Profile Exists** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#check-if-people-profile-exists)
    * `client.website.check_people_profile_exists(website_id, people_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      people_id = "c5a2f70c-f605-4648-b47f-8c39d4b03a50"

      client.website.check_people_profile_exists(website_id, people_id);
      ```
      </details>

  * ⭐ **Get People Profile** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-people-profile)
    * `client.website.get_people_profile(website_id, people_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      people_id = "c5a2f70c-f605-4648-b47f-8c39d4b03a50"

      client.website.get_people_profile(website_id, people_id);
      ```
      </details>

  * ⭐ **Save People Profile** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#save-people-profile)
    * `client.website.save_people_profile(website_id, people_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      people_id = "c5a2f70c-f605-4648-b47f-8c39d4b03a50"

      data = [
        "email" => "valerian@crisp.chat",
        "person" => [
          "nickname" => "Valerian Saliou"
        ]
      ]

      client.website.save_people_profile(website_id, people_id, data);
      ```
      </details>

  * **Find People Profile By Email** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-people-profile)
    * `client.website.find_people_profile_by_email(website_id, email)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      people_id = "c5a2f70c-f605-4648-b47f-8c39d4b03a50"

      client.website.get_people_profile(website_id, people_id);
      ```
      </details>

  * ⭐ **Update People Profile** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#update-people-profile)
    * `client.website.update_people_profile(website_id, people_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      people_id = "c5a2f70c-f605-4648-b47f-8c39d4b03a50"

      data = [
        "email" => "valerian@crisp.chat",
        "person" => [
          "nickname" => "Valerian Saliou"
        ]
      ]

      client.website.update_people_profile(website_id, people_id, data);
      ```
      </details>

  * ⭐ **Remove People Profile** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#remove-people-profile)
    * `client.website.remove_people_profile(website_id, people_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      people_id = "c5a2f70c-f605-4648-b47f-8c39d4b03a50"

      client.website.remove_people_profile(website_id, people_id);
      ```
      </details>

  * **List People Conversations** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-people-conversations)
    * `client.website.list_people_conversations(website_id, people_id, page_number)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      people_id = "c5a2f70c-f605-4648-b47f-8c39d4b03a50"
      page_number = 1

      client.website.list_people_conversations(website_id, people_id, page_number);
      ```
      </details>

  + **Add A People Event** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#add-a-people-event)
    * `client.website.add_people_event(website_id, people_id, data)`
  + **List People Events** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-people-events)
    * `client.website.list_people_events(website_id, people_id, page_number)`
  + **Get People Data** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-people-data)
    * `client.website.get_people_data(website_id, people_id)`
  + **Save People Data** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#save-people-data)
    * `client.website.save_people_data(website_id, people_id, data)`
  + **Update People Data** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#update-people-data)
    * `client.website.update_people_data(website_id, people_id, data)`
  + **Get People Subscription Status** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-people-subscription-status)
    * `client.website.get_people_subscription_status(website_id, people_id)`
  + **Update People Subscription Status** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#update-people-subscription-status)
    * `client.website.update_people_subscription_status(website_id, people_id, data)`

_👉 Notice: The `peopleID` argument can be an email or the `peopleID`._

* **Website Base**
  * **Create Website** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#create-website)
    * `client.website.create_website(data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      client.website.create_website(data);
      ```
      </details>

  * **Get A Website** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-a-website)
    * `client.website.get_website(website_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.get_website(website_id);
      ```
      </details>

  * **Delete A Website** [`user`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#delete-a-website)
    * `client.website.delete_website(website_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.delete_website(website_id);
      ```
      </details>


* **Website Batch**
  * **Batch Resolve Items** [`user`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#batch-resolve-items)
    * `client.website.batch_resolve_items(website_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.batch_resolve_items(website_id, data);
      ```
      </details>

  * **Batch Read Items** [`user`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#batch-read-items)
    * `client.website.batch_read_items(website_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.batch_read_items(website_id, data);
      ```
      </details>

  * **Batch Remove Items** [`user`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#batch-remove-items)
    * `client.website.batch_remove_items(website_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      data = [
        "session_19e5240f-0a8d-461e-a661-a3123fc6eec9",
        "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"
      ]

      client.website.batch_remove_items(website_id, data);
      ```
      </details>


* **Website Availability**
  * **Get Website Availability Status** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-website-availability-status)
    * `client.website.get_website_availability_status(website_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.get_website_availability_status(website_id);
      ```
      </details>


* **Website Operator**
  * **List Website Operators** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-website-operators)
    * `client.website.list_website_operators(website_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.list_website_operators(website_id);
      ```
      </details>

  * **List Last Active Website Operators** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-last-active-website-operators)
    * `client.website.list_last_active_website_operators(website_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.list_last_active_website_operators(website_id);
      ```
      </details>


* **Website Settings**
  * **Get Website Settings** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-website-settings)
    * `client.website.get_website_settings(website_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.get_website_settings(website_id);
      ```
      </details>

  * **Update Website Settings** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#update-website-settings)
    * `client.website.update_website_settings(website_id, data)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      data = [
        "name" => "Crisp",
        "domain" => "crisp.chat",
        "logo" => "https://storage.crisp.chat/users/avatar/website/8c842203-7ed8-4e29-a608-7cf78a7d2fcc/b6c2948d-b061-405e-91a9-2fdf855d1cc0.png",
        "contact" => [
          "email" => "contact@crisp.chat",
          "phone" => "+33757905447"
        ],
        "inbox" => [
          "lock_removal" => false,
          "force_operator_token" => false
        ],
        "emails" => [
          "rating" => true,
          "transcript" => true,
          "enrich" => true,
          "junk_filter" => true
        ],
        "chatbox" => [
          "tile" => "default",
          "wait_game" => false,
          "last_operator_face" => false,
          "ongoing_operator_face" => true,
          "activity_metrics" => true,
          "operator_privacy" => false,
          "availability_tooltip" => true,
          "hide_vacation" => false,
          "hide_on_away" => false,
          "hide_on_mobile" => false,
          "position_reverse" => false,
          "email_visitors" => false,
          "phone_visitors" => false,
          "force_identify" => false,
          "ignore_privacy" => false,
          "visitor_compose" => false,
          "file_transfer" => true,
          "overlay_search" => true,
          "overlay_mode" => false,
          "helpdesk_link" => true,
          "helpdesk_only" => false,
          "status_health_dead" => true,
          "check_domain" => false,
          "color_theme" => "blue",
          "text_theme" => "default",
          "welcome_message" => "default",
          "locale" => "en",
          "allowed_pages" => [],
          "blocked_pages" => [
            "status/*/",
            "docs.crisp.chat/*",
            "crisp.chat/terms/",
            "https://crisp.chat/privacy/"
          ],
          "blocked_countries" => [
            "IT"
          ],
          "blocked_locales" => [
            "fa",
            "he"
          ],
          "blocked_ips" => [
            "8.8.8.8",
            "2001:0db8:85a3:0000:0000:8a2e:0370:7334",
            "192.168.1.1/24"
          ]
        ]
      ]

      client.website.update_website_settings(website_id, data);
      ```
      </details>


* **Website Visitors**
  * **Count Visitors** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#count-visitors)
    * `client.website.count_visitors(website_id)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.count_visitors(website_id);
      ```
      </details>

  * **List Visitors** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#list-visitors)
    * `client.website.list_visitors(website_id, page_number)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"
      page_number = 1

      client.website.list_visitors(website_id, page_number);
      ```
      </details>

  * **Get Session ID** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#get-session-identifier-from-token)
    * `client.website.get_session_id_by_token(website_id, token)`
    * <details>
      <summary>See Example</summary>

      ```ruby
      session_id = "session_700c65e1-85e2-465a-b9ac-ecb5ec2c9881"
      website_id = "8c842203-7ed8-4e29-a608-7cf78a7d2fcc"

      client.website.get_session_id_by_token(website_id, token);
      ```
      </details>


### Bucket

* **Bucket URL**
  * **Generate Bucket URL** [`user`, `plugin`]: [Reference](https://docs.crisp.chat/references/rest-api/v1/#generate-bucket-url)
    * `client.bucket.generate_bucket_url(data)`
