##
# ruby-crisp-api
#
# Copyright 2018, Valerian Saliou
# Author: Valerian Saliou <valerian@valeriansaliou.name>
##

require 'rest-client'
require 'json'

require_relative 'errors/route'
require_relative 'resources/bucket'
require_relative 'resources/website'

module Crisp
  class Client
    attr_writer :rest_host
    attr_writer :rest_base_path

    attr_accessor :bucket
    attr_accessor :website

    def initialize()
      @auth = {}

      @bucket = Crisp::BucketResource.new(self)
      @website = Crisp::WebsiteResource.new(self)
    end

    public

    def authenticate(identifier, key)
      @auth["identifier"] = identifier
      @auth["key"] = key
    end

    def rest_host
      @rest_host || "https://api.crisp.chat"
    end

    def rest_base_path
      @rest_base_path || "/v1"
    end

    def timeout
      @timeout || 5
    end

    def get(resource, query: {})
      self._do_request(:get, resource, query: query)
    end

    def head(resource)
      self._do_request(:head, resource)
    end

    def remove(resource)
      self._do_request(:delete, resource)
    end

    def post(resource, data: {})
      self._do_request(:post, resource, data: data)
    end

    def patch(resource, data: {})
      self._do_request(:patch, resource, data: data)
    end

    def put(resource, data: {})
      self._do_request(:put, resource, data: data)
    end

    protected

    def _do_request(method, resource, query: nil, data: nil)
      begin
        response = RestClient::Request.execute(
          :url => self._prepare_rest_url(resource),
          :method => method,
          :timeout => self.timeout,
          :verify_ssl => OpenSSL::SSL::VERIFY_PEER,

          :user => @auth["identifier"],
          :password => @auth["key"],

          :payload => (data ? data.to_json : nil),

          :headers => {
            :user_agent => "ruby-crisp-api/1.1.1",
            :accept => :json,
            :content_type => :json,
            :params => query
          }
        )
      rescue RestClient::ExceptionWithResponse => error
        response = error.response
      rescue
        response = nil
      end

      if response && method != :head
        result = JSON.parse(response)
      elsif response and method == :head and response.code == 200
        result = {}
      else
        result = {
          "error" => true,
          "reason" => "http_error"
        }
      end

      if result["error"] === true
        raise RouteError, (result["reason"] || "error")
      end

      return result["data"] || {}
    end

    def _prepare_rest_url(resource)
      return self.rest_host + self.rest_base_path + resource
    end
  end
end
