class Home::Index < Lucky::Action
  accepted_formats [:json]

  get "/" do
    uri = "https://api.punkapi.com/v2/beers"
    response = HTTP::Client.exec("GET", uri)
    raw_json(response.body.to_s)
  end
end
