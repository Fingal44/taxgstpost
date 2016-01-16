json.array!(@datesettings) do |datesetting|
  json.extract! datesetting, :id
  json.url datesetting_url(datesetting, format: :json)
end
