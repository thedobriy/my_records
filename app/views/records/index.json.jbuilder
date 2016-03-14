json.array!(@records) do |record|
  json.extract! record, :id, :datetime, :summa, :desc, :data, :time, :label, :status
  json.url record_url(record, format: :json)
end
