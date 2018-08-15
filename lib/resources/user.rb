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

    def check_session_validity
      return @parent.head(self._url_user("/session"))
    end

    def create_new_session(data)
      return @parent.post(self._url_user("/session/login"))
    end

    def destroy_session
      return @parent.post(self._url_user("/session/logout"))
    end
  end
end
