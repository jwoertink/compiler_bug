class Home::Index < ApiAction
  get "/" do
    uri = "https://api.punkapi.com/v2/beers"
    response = HTTP::Client.exec("GET", uri)
    data = JSON.parse(response.body)
    json({data: data})
  end
end
