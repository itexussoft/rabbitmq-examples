#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

# create and start connection to RabbitMQ via bunny gem
connection = Bunny.new
connection.start

# create channel and set exchange topic with some name
channel  = connection.create_channel
exchange = channel.topic('some_topic_name')


# you can set routing_key and message ether from ARGV
# (example: $ ruby topic_publisher.rb 'consumer.first' 'Hello World!')
route = ARGV.shift || "anonymous.info"
msg   = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

# or hardcode, like below
# (example: $ ruby topic_publisher.rb)
# route = 'consumer.first'
# msg   = "Hi! I've downloaded news from TRKD"

# send message to exchange with routing_key
exchange.publish(msg, routing_key: route)

# simple message for show, what publisher send to exchange
puts " [x] Sent #{route}:#{msg}"

# close connection
connection.close
