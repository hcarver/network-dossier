require 'rmeetup'

module RMeetup
  module Fetcher
    class Base
      def base_url
        "https://api.meetup.com/2/#{@type}.json/"
      end

      def build_url(options)
        options = encode_options(options)

        result = base_url + params_for(options)
        return result
      end
    end
  end

  class Client
    def self.check_configuration!

    end
  end
end
