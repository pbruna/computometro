json.array!(@movements) do |json, movement|
  json.total movement.total
  json.subject movement.subject
  json.income movement.income
end