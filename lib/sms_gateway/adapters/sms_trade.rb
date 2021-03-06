module SmsGateway
  module Adapters
    class SmsTrade
      require 'httparty'
      include HTTParty
      base_uri 'http://gateway.smstrade.de'

      def initialize(config = {})
        @config = { key: SmsGateway::Base.key, from: SmsGateway::Base.from, route: SmsGateway::Base.route }
        @config.merge!(config)
        self.class.base_uri SmsGateway::Base.base_uri
      end

      def send_sms(sms)
        options = @config.merge(from: sms.from, to: sms.to, message: sms.text, charset: 'UTF-8')
        options.merge!(route: sms.route) if sms.route
        options.merge!(dlr: 1) if sms.delivery_report
        self.class.get('/', query: options)
      end
    end
  end
end
