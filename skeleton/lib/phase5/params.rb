require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    def initialize(req, route_params = {})
      @req = req
      @params = route_params
      if @req.query_string
        parse_www_encoded_form(@req.query_string)
      elsif @req.body
        parse_www_encoded_form(@req.body)
      end
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      param_array = URI::decode_www_form(www_encoded_form)

      param_array = param_array.map do |param|
          [parse_key(param[0]), param[1]]
      end

      param_array.each do |param|
        if param[0].is_a?(Array)
          hashify_param(param)
        else
          @params[param[0]] = param[1]
        end
      end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      if key.include?("]")
        key = key.split(/\]\[|\]|\[/)
      else
        key
      end

      key
    end

    def hashify_param(param)
      scope = @params

      param[0].each_with_index do |key, index|
        if index == param[0].count - 1
          scope[key] = param[1]
        else
          scope[key] ||= {}
          scope = scope[key]
        end
      end
    end

  end
end


