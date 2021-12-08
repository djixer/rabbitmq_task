require 'eventmachine'
require 'bunny'
require 'json'

EventMachine.run do
    connection = Bunny.new('amqp://guest:guest@rabbitmq')
    connection.start
    channel = connection.create_channel
    exchange = channel.default_exchange
    queue_name = 'hw.input'
    sleep 3
    exchange.publish({ cpu: 5, ram: 2, hdd: 'ssd' }.to_json, routing_key: queue_name)

    queue = channel.queue('response_with_cost', auto_delete: true)
    queue.subscribe do |_delivery_info, _metadata, payload|
        puts payload
    end

    Signal.trap('INT') do
        puts 'exiting INT'
        connection.close { EventMachine.stop }
    end
end
