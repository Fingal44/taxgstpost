json.array!(@temp_transactions) do |temp_transaction|
  json.extract! temp_transaction, :id
  json.url temp_transaction_url(temp_transaction, format: :json)
end
