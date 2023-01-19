class CustomTextResponse < Lucky::Response
  getter context, content_type, body

  def initialize(@context : HTTP::Server::Context,
                 @content_type : String,
                 @body : String | IO
                )
  end

  def print : Nil
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
end

class Home::Index < Lucky::Action
  accepted_formats [:json]

  get "/" do
    uri = "https://api.punkapi.com/v2/beers"
    response = HTTP::Client.exec("GET", uri)
    data = JSON.parse(response.body)
    CustomTextResponse.new(
      context,
      "application/json",
      {data: data}.to_json,
    )
  end
end
