##
# ruby-crisp-api
#
# Copyright 2018, Valerian Saliou
# Author: Valerian Saliou <valerian@valeriansaliou.name>
##

require "rest-client"

module Crisp
  class BucketResource
    def initialize(parent)
      @parent = parent
    end

    protected

    def _url_bucket(resource)
      return "/bucket%s" % resource
    end

    public

    def generate_bucket_url(data)
      return @parent.post(self._url_bucket("/url/generate"), data: data)
    end
  end
end
