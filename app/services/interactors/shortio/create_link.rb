# frozen_string_literal: true

require "net/http"

module Interactors
  module Shortio
    class CreateLink
      include Interactor

      SHORTIO_API_URL = "https://api.short.io/links"
      DOMAIN          = "f6GKwr.short.gy"

      delegate :original_url, to: :context

      def call
        response = http.request(request)
        context.short_url = JSON.parse(response.body)["shortURL"]
      rescue StandardError => e
        context.fail!(error: e.message)
      end

      private

      def body
        {
          skipQS: false,
          archived: false,
          allowDuplicates: false,
          originalURL: original_url,
          domain: DOMAIN
        }
      end

      def headers
        {
          "Accept" => "application/json",
          "Content-Type" => "application/json",
          "Authorization" => ENV["SHORTIO_API_KEY"]
        }
      end

      def http
        Net::HTTP.new(uri.host, uri.port).tap do |http|
          http.use_ssl = true
        end
      end

      def request
        Net::HTTP::Post.new(uri, headers).tap do |req|
          req.body = body.to_json
        end
      end

      def uri
        @uri ||= URI(SHORTIO_API_URL)
      end
    end
  end
end
