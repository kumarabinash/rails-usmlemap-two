json.array!(@markers) do |marker|
  json.extract! marker, :id, :marker_type, :marker_content, :marker_address, :start_date, :end_date
  json.url marker_url(marker, format: :json)
end
