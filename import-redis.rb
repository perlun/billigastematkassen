#!/usr/bin/env jruby

require 'bson'
require 'json'
require 'redis'

products = JSON.parse(IO.read('db/products.json'))

redis = Redis.new

products.each do |product|
  product.delete 'imageUrl'
  product.delete 'objectId'
  product.delete 'slug'

  key = BSON::ObjectId.new.to_s

  redis.hset 'products', key, product.to_json
end