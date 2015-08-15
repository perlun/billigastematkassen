require 'rubygems'
require 'json'

JSON.parse(IO.read("products.json")).each do |obj|
  printf("%s\t%s\t%s\t%s %s\n", obj['productGroup'], obj['productSubGroup'], obj['name'], obj['qty'], obj['unitOfMeasure'])
end
