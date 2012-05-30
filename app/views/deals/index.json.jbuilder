json.array!(@deals) do |json, deal|
  json.total deal.price
  json.subject deal.name
  json.status deal.status
  json.currency deal.currency
end