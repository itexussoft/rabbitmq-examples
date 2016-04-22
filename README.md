# RabbitMQ - Examples

For run these examples, you should install [RabbitMQ](https://www.rabbitmq.com/download.html)

### After installation

    $ rabbitmq-server


Open another tab in terminal and type:

    $ ruby topic_consumer.rb 'consumer.first'

Open one more tab in terminal and type:

    $ ruby topic_publisher.rb 'consumer.first' 'Hello World!'

where `consumer.first` - it's a routing key, and `'Hello World!'` - it's message, which you want send to message queue

### Details
More details you can see in `topic_publisher.rb` and `topic_consumer.rb` as comments.
