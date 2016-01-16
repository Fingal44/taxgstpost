json.array!(@gst_returns) do |gst_return|
  json.extract! gst_return, :id
  json.url gst_return_url(gst_return, format: :json)
end
