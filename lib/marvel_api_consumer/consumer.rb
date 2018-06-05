require 'httparty'

module MarvelApiConsumer
  class Consumer
    include ::HTTParty
    base_uri 'gateway.marvel.com'

    def initialize(public_key:, private_key:)
      @public_key  = public_key
      @private_key = private_key
    end

    def characters(params={}, resource=nil)
      params.merge! auth_params
      options = { query: params }
      base_uri = "/v1/public/characters"
      uri = !resource.nil? ? base_uri + "/#{resource}" : base_uri
      self.class.get(uri, options)
    end

  private
    attr_reader :private_key, :public_key

    def auth_params
      ts = Time.now.to_i
      hash = Digest::MD5.hexdigest("#{ts}#{private_key}#{public_key}")
      {
        ts: ts,
        apikey: public_key,
        hash: hash
      }
    end
  end
end
