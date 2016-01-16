json.array!(@initsettings) do |initsetting|
  json.extract! initsetting, :id
  json.url initsetting_url(initsetting, format: :json)
end
