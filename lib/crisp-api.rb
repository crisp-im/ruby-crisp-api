##
# ruby-crisp-api
#
# Copyright 2018, Valerian Saliou
# Author: Valerian Saliou <valerian@valeriansaliou.name>
##

require "faraday"
require "json"

require_relative "errors/route"
require_relative "resources/bucket"
require_relative "resources/website"

module Crisp
  class Client
    attr_writer :rest_host
    attr_writer :rest_base_path

    attr_accessor :bucket
    attr_accessor :website

    def initialize()
      @auth = {}
      @tier = "user"

      @bucket = Crisp::BucketResource.new(self)
      @website = Crisp::WebsiteResource.new(self)
    end

    public

    def authenticate(identifier, key)
      @auth["identifier"] = identifier
      @auth["key"] = key
    end

    def set_tier(tier)
      @tier = tier
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
        connection = Faraday.new(
          :request => {
            :timeout => self.timeout,
            :open_timeout => self.timeout
          },
          :ssl => { :verify => true }
        ) do |builder|
          if @auth["identifier"]
            builder.request :authorization, :basic, @auth["identifier"], @auth["key"]
          end
          builder.adapter :net_http
        end

        response = connection.run_request(
          method,
          self._prepare_rest_url(resource),
          data ? data.to_json : nil,
          {
            "User-Agent" => "ruby-crisp-api/1.1.16",
            "Accept" => "application/json",
            "Content-Type" => "application/json",
            "X-Crisp-Tier" => @tier
          }
        ) do |request|
          request.params.update(query) if query
        end
      rescue Faraday::ConnectionFailed, Faraday::TimeoutError, Faraday::SSLError
        raise RouteError, "http_error"
      end

      if response && method != :head
        begin
          result = JSON.parse(response.body)
        rescue JSON::ParserError
          raise RouteError, "http_error"
        end
      elsif response and method == :head and response.status == 200
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
