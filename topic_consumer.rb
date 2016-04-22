#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

# ARGV is require for start consumer
# example: $ ruby topic_consumer.rb 'consumer.first' 'consumer.second'
if ARGV.empty?
  abort "Usage: #{$0} [binding key]"
end

# create and start connection to RabbitMQ via bunny gem
connection = Bunny.new
connection.start

# create channel and set exchange topic with some name.
# topic name in consumer should be equal with topic name in publisher
# queue name isn't require
channel  = connection.create_channel
exchange = channel.topic('some_topic_name')
q        = channel.queue('', exclusive: true)

# bind all routing_key, that you set in ARGV
ARGV.each do |route|
  q.bind(exchange, routing_key: route)
end

# simple message for show, that consumer is working
puts ' [*] Waiting for logs. To exit press CTRL+C'

begin
  # subscribe for getting all messages for this queue
  q.subscribe(block: true) do |delivery_info, properties, body|
    # simple message for show, that message have received
    puts " [x] #{delivery_info.routing_key}:#{body}"
  end
rescue Interrupt => _
  # close channel and conection
  channel.close
  connection.close
end
