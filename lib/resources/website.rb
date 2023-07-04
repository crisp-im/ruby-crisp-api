##
# ruby-crisp-api
#
# Copyright 2018, Valerian Saliou
# Author: Valerian Saliou <valerian@valeriansaliou.name>
##

require "rest-client"

module Crisp
  class WebsiteResource
    SEARCH_CONVERSATIONS_QUERY_PARAMETERS = [
      "search_query",
      "search_type",
      "search_operator",
      "include_empty",
      "filter_unread",
      "filter_resolved",
      "filter_not_resolved",
      "filter_mention",
      "filter_assigned",
      "filter_unassigned",
      "filter_date_start",
      "filter_date_end",
      "order_date_created",
      "order_date_updated",
    ]

    def initialize(parent)
      @parent = parent
    end

    protected

    def _url_website(website_id, resource = "")
      return "/website/%s%s" % [website_id, resource]
    end

    def _url_conversation(website_id, session_id, resource = "")
      return self._url_website(website_id, "/conversation/%s%s" % [session_id, resource])
    end

    def _url_people(kind, website_id, people_id, resource = "")
      return self._url_website(website_id, "/people/%s/%s%s" % [kind, people_id, resource])
    end

    public

    def create_website(data)
      return @parent.post("/website", data)
    end

    def get_website(website_id)
      return @parent.get(self._url_website(website_id))
    end

    def delete_website(website_id)
      return @parent.delete(self._url_website(website_id))
    end

    def batch_resolve_items(website_id, data)
      return @parent.patch(self._url_website(website_id, "/batch/resolve"), data: data)
    end

    def batch_read_items(website_id, data)
      return @parent.patch(self._url_website(website_id, "/batch/read"), data: data)
    end

    def batch_remove_items(website_id, data)
      return @parent.patch(self._url_website(website_id, "/batch/remove"), data: data)
    end

    def get_website_availability_status(website_id)
      return @parent.get(self._url_website(website_id, "/availability/status"))
    end

    def list_website_operators(website_id)
      return @parent.get(self._url_website(website_id, "/operators/list"))
    end

    def list_last_active_website_operators(website_id)
      return @parent.get(self._url_website(website_id, "/operators/active"))
    end

    def get_website_settings(website_id)
      return @parent.get(self._url_website(website_id, "/settings"))
    end

    def update_website_settings(website_id, data)
      return @parent.patch(self._url_website(website_id, "/settings"), data: data)
    end

    def count_visitors(website_id)
      return @parent.get(self._url_website(website_id, "/visitors/count"))
    end

    def list_visitors(website_id, page_number)
      return @parent.get(self._url_website(website_id, "/visitors/list/%d" % page_number))
    end

    def search_conversations(website_id, page_number = 1, search_query = "", search_type = "", search_operator = "", include_empty = "", filter_unread = "", filter_resolved = "", filter_not_resolved = "", filter_mention = "", filter_assigned = "", filter_unassigned = "", filter_date_start = "", filter_date_end = "", order_date_created = "", order_date_updated = "")
      resource_url = ""
      query_parameters = []

      SEARCH_CONVERSATIONS_QUERY_PARAMETERS.each do |parameter|
        parameter_value = binding.local_variable_get(parameter)

        if parameter_value != ""
          query_parameters.push("%s=%s" % [parameter, CGI.escape(parameter_value).gsub("+", "%20")])
        end
      end

      if query_parameters != []
        resource_url = self._url_website(website_id, "/conversations/%d?%s" % [page_number, query_parameters.join("&")])
      else
        resource_url = self._url_website(website_id, "/conversations/%d" % page_number)
      end

      return @parent.get(resource_url)
    end

    def list_conversations(website_id, page_number = 1)
      return self.search_conversations(website_id, page_number)
    end

    def create_new_conversation(website_id)
      return @parent.post(self._url_website(website_id, "/conversation"))
    end

    def check_conversation_exists(website_id, session_id)
      return @parent.head(self._url_conversation(website_id, session_id))
    end

    def get_conversation(website_id, session_id)
      return @parent.get(self._url_conversation(website_id, session_id))
    end

    def remove_conversation(website_id, session_id)
      return @parent.remove(self._url_conversation(website_id, session_id))
    end

    def initiate_conversation_with_existing_session(website_id, session_id)
      return @parent.post(self._url_conversation(website_id, session_id, "/initiate"))
    end

    def get_messages_in_conversation(website_id, session_id, query)
      return @parent.get(self._url_conversation(website_id, session_id, "/messages"), query: query)
    end

    def send_message_in_conversation(website_id, session_id, data)
      return @parent.post(self._url_conversation(website_id, session_id, "/message"), data: data)
    end

    def update_message_in_conversation(website_id, session_id, fingerprint, data)
      return @parent.patch(self._url_conversation(website_id, session_id, "/message/%d" % fingerprint), data: data)
    end

    def compose_message_in_conversation(website_id, session_id, data)
      return @parent.patch(self._url_conversation(website_id, session_id, "/compose"), data: data)
    end

    def mark_messages_read_in_conversation(website_id, session_id, data)
      return @parent.patch(self._url_conversation(website_id, session_id, "/read"), data: data)
    end

    def mark_messages_delivered_in_conversation(website_id, session_id, data)
      return @parent.patch(self._url_conversation(website_id, session_id, "/delivered"), data: data)
    end

    def get_conversation_routing_assign(website_id, session_id)
      return @parent.get(self._url_conversation(website_id, session_id, "/routing"))
    end

    def assign_conversation_routing(website_id, session_id, data)
      return @parent.patch(self._url_conversation(website_id, session_id, "/routing"), data: data)
    end

    def get_conversation_metas(website_id, session_id)
      return @parent.get(self._url_conversation(website_id, session_id, "/meta"))
    end

    def update_conversation_metas(website_id, session_id, data)
      return @parent.patch(self._url_conversation(website_id, session_id, "/meta"), data: data)
    end

    def list_conversation_pages(website_id, session_id, page_number)
      return @parent.get(self._url_conversation(website_id, session_id, "/pages/%d" % page_number))
    end

    def list_conversation_events(website_id, session_id, page_number)
      return @parent.get(self._url_conversation(website_id, session_id, "/events/%d" % page_number))
    end

    def list_conversation_files(website_id, session_id, page_number)
      return @parent.get(self._url_conversation(website_id, session_id, "/files/%d" % page_number))
    end

    def get_conversation_state(website_id, session_id)
      return @parent.get(self._url_conversation(website_id, session_id, "/state"))
    end

    def change_conversation_state(website_id, session_id, data)
      return @parent.patch(self._url_conversation(website_id, session_id, "/state"), data: data)
    end

    def get_block_status_for_conversation(website_id, session_id)
      return @parent.get(self._url_conversation(website_id, session_id, "/block"))
    end

    def block_incoming_messages_for_conversation(website_id, session_id, data)
      return @parent.patch(self._url_conversation(website_id, session_id, "/block"), data: data)
    end

    def request_email_transcript_for_conversation(website_id, session_id, data)
      return @parent.post(self._url_conversation(website_id, session_id, "/transcript"), data: data)
    end

    def get_people_statistics(website_id)
      return @parent.get(self._url_website(website_id, "/people/stats"))
    end

    def list_people_segments(website_id, page_number)
      return @parent.get(self._url_website(website_id, "/people/segments/%d" % page_number))
    end

    def list_people_profiles(website_id, page_number)
      return @parent.get(self._url_website(website_id, "/people/profiles/%d" % page_number))
    end

    def add_new_people_profile(website_id, data)
      return @parent.post(self._url_website(website_id, "/people/profile"), data: data)
    end

    def check_people_profile_exists(website_id, people_id)
      return @parent.head(self._url_people("profile", website_id, people_id))
    end

    def find_people_profile_by_email(website_id, email)
      return @parent.get(self._url_people("profile", website_id, email))
    end

    def get_people_profile(website_id, people_id)
      return @parent.get(self._url_people("profile", website_id, people_id))
    end

    def save_people_profile(website_id, people_id, data)
      return @parent.put(self._url_people("profile", website_id, people_id), data: data)
    end

    def update_people_profile(website_id, people_id, data)
      return @parent.patch(self._url_people("profile", website_id, people_id), data: data)
    end

    def remove_people_profile(website_id, people_id)
      return @parent.remove(self._url_people("profile", website_id, people_id))
    end

    def list_people_conversations(website_id, people_id, page_number)
      return @parent.get(self._url_people("conversations", website_id, people_id, "/list/%d" % page_number))
    end

    def add_people_event(website_id, people_id, data)
      return @parent.post(self._url_people("events", website_id, people_id), data: data)
    end

    def list_people_events(website_id, people_id, page_number)
      return @parent.get(self._url_people("events", website_id, people_id, "/list/%d" % page_number))
    end

    def get_people_data(website_id, people_id)
      return @parent.get(self._url_people("data", website_id, people_id))
    end

    def save_people_data(website_id, people_id, data)
      return @parent.put(self._url_people("data", website_id, people_id), data: data)
    end

    def update_people_data(website_id, people_id, data)
      return @parent.patch(self._url_people("data", website_id, people_id), data: data)
    end

    def get_people_subscription_status(website_id, people_id)
      return @parent.get(self._url_people("subscription", website_id, people_id))
    end

    def update_people_subscription_status(website_id, people_id, data)
      return @parent.patch(self._url_people("subscription", website_id, people_id), data: data)
    end

    def get_session_id_by_token(website_id, token)
      return @parent.get(self._url_website(website_id, "/visitors/token/#{token}"))
    end
  end
end
