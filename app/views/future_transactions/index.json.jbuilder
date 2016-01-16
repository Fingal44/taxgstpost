json.array!(@future_transactions) do |future_transaction|
  json.extract! future_transaction, :id
  json.url future_transaction_url(future_transaction, format: :json)
end
