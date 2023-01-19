class CustomTextResponse < Lucky::Response
  getter context, content_type, body, enable_cookies

  def initialize(@context : HTTP::Server::Context,
                 @content_type : String,
                 @body : String | IO,
                 @enable_cookies : Bool = true)
  end

  def print : Nil
    # if enable_cookies
    #   write_flash
    #   write_session
    #   write_cookies
    # end
    context.response.content_type = content_type
    context.response.status_code = status
    context.response.print(body)
  end

  def status : Int
    200
  end

  def debug_message : String?
    nil
  end

  private def write_flash : Nil
    context.session.set(
      Lucky::FlashStore::SESSION_KEY,
      context.flash.to_json
    )
  end

  private def write_session : Nil
    context.cookies.set(
      Lucky::Session.settings.key,
      context.session.to_json
    )
  end

  private def write_cookies : Nil
    response = context.response

    context.cookies.updated.each do |cookie|
      response.cookies[cookie.name] = cookie
    end

    response.cookies.add_response_headers(response.headers)
  end
end

class Home::Index < Lucky::Action
  disable_cookies
  accepted_formats [:json]

  get "/" do
    uri = "https://api.punkapi.com/v2/beers"
    response = HTTP::Client.exec("GET", uri)
    data = JSON.parse(response.body)
    CustomTextResponse.new(
      context,
      "application/json",
      {data: data}.to_json,
      enable_cookies: false
    )
  end
end
