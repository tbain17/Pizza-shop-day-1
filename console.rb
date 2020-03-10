require("pry-byebug")
require_relative("models/property")

Property.delete_all()

property1 = Property.new(
  {
    "address" => "42 High Street",
    "property_value" => 72000,
    "number_bedrooms" => 2,
    "year_built" => 1902
  }
)
property1.save()
property1.year_built = 2001

property2 = Property.new(
  {
    "address" => "43 Hippo Street",
    "property_value" => 73000,
    "number_bedrooms" => 3,
    "year_built" => 1903
  }
)
property2.save()










binding.pry
nil
