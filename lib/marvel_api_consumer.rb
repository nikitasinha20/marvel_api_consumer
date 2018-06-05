require "marvel_api_consumer/version"
require "marvel_api_consumer/consumer"
require "marvel_api_consumer/exceptions"
require "marvel_api_consumer/character"
require 'httparty'


module MarvelApiConsumer
  class << self
    def set_config(config)
      @config = config
      verify_configuration
      @api = MarvelApiConsumer::Consumer.new(
        public_key: config[:public_key],
        private_key: config[:private_key]
      )
    end

    def total_characters(params = {})
      MarvelApiConsumer::Character.new(params).max_characters
    end

    def character_list(params = {})
      max_requested_number = 100 # We may not request more than 100 items with Marvel api as per guidelines
      MarvelApiConsumer::Character.new(params.merge!({limit: max_requested_number}),nil,max_requested_number).fetch_list
    end

    def paginated_character_list(params = {})
      MarvelApiConsumer::Character.new(params, nil, total_characters).fetch_list
    end

    def character_details(character_id = nil, params = {})
      return nil if character_id.nil?
      MarvelApiConsumer::Character.new(params).get_character(character_id)
    end

    def api
      @api
    end

  private

    attr_reader :config

    def verify_configuration
      if config.nil?
        raise MarvelApiConsumer::NotConfigured, 'Not configured. Please use #set_config with a hash containing :public_key and :private_key.'
      end

      if !config.has_key?(:public_key) || config[:public_key].empty?
        raise MarvelApiConsumer::NotConfigured, 'No Marvel API public key has been set in the configuration, or is empty.'
      end

      if !config.has_key?(:private_key) || config[:private_key].empty?
        raise MarvelApiConsumer::NotConfigured, 'No Marvel API private key has been set in the configuration, or is empty.'
      end
    end

  end
end
