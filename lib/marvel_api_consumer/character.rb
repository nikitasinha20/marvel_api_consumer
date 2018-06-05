module MarvelApiConsumer
  class Character
    include Enumerable

    def initialize(params = {}, resource = nil, max=nil)
      @max = max
      @resource = resource
      @params = params
      @collection = []
      @offset = params.fetch(:offset, nil)
      @limit = params.fetch(:limit, 50)
    end

    def max_characters
      @response = with_handling do
        client.characters({limit: 1})
      end
      @response['data']['total']
    end

    def get_character(character_id)
      @response = with_handling do
        client.characters({}, character_id)
      end
      @response['data']['results'].first
    end

    def fetch_list
      Enumerator.new do |y|
        until last?
          fetch_next_page
          @response['data']['results'].each do |element|
            y.yield element
          end
        end
      end
    end

    private

    def fetch_next_page
      @response = with_handling do
        client.characters(@params)
      end
      @last_response_empty  = @response.empty?
      @collection           += @response['data']['results']
      @offset               = @response['data']['offset'] + @collection.size
    end
    
    def last?
      @last_response_empty || @collection.size >= @max
    end

    def with_handling
      @response = yield
      if @response.code != 200
        raise MarvelApiConsumer::ApiError, "Unexpected API response. code=#{@response.code} reason=#{@response['message']}"
      end
      @response
    end

    def client
      MarvelApiConsumer.api
    end
  end
end
