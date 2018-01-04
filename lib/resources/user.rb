##
# ruby-crisp-api
#
# Copyright 2018, Valerian Saliou
# Author: Valerian Saliou <valerian@valeriansaliou.name>
##

require 'rest-client'

module Crisp
  class UserResource
    def initialize(parent)
      @parent = parent
    end

    protected

    def _url_user(resource)
      return "/user%s" % resource
    end

    public

    def get_user_availability
      return @parent.get(self._url_user("/availability"))
    end

    def update_user_availability(data)
      return @parent.patch(self._url_user("/availability"), data: data)
    end

    def get_user_availability_status
      return @parent.get(self._url_user("/availability/status"))
    end

    def get_user_account
      return @parent.get(self._url_user("/account"))
    end

    def create_user_account(data)
      return @parent.post(self._url_user("/account"), data: data)
    end

    def list_websites
      return @parent.get(self._url_user("/account/websites"))
    end

    def get_profile
      return @parent.get(self._url_user("/account/profile"))
    end

    def update_profile(data)
      return @parent.patch(self._url_user("/account/profile"), data: data)
    end

    def check_session_validity
      return @parent.head(self._url_user("/session"))
    end

    def create_new_session(data)
      return @parent.post(self._url_user("/session/login"))
    end

    def destroy_session
      return @parent.post(self._url_user("/session/logout"))
    end

    def count_total_unread_messages
      return @parent.get(self._url_user("/stats/unread"))
    end
  end
end
