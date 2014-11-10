require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @req = req
      cookies = @req.cookies.select { |cookie| cookie.name == "_rails_lite_app" }

      if cookies.empty?
        @cookie_value = {}
      else
        cookie = cookies.first
        @cookie_value = JSON.parse(cookie.value)
      end
    end

    def [](key)
      @cookie_value[key]
    end

    def []=(key, val)
      @cookie_value[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      value = @cookie_value.to_json
      res.cookies << WEBrick::Cookie.new("_rails_lite_app", value)
    end
  end
end
