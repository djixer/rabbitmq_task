require 'eventmachine'
require 'bunny'
require './cost_vm_service.rb'

EventMachine.run do
    connection = Bunny.new('amqp://guest:guest@rabbitmq')
    connection.start
    channel = connection.create_channel
    queue = channel.queue('hw.input', auto_delete: true)
    queue.subscribe do |_delivery_info, _metadata, payload|
        CostVmService.call(payload)
    end

    Signal.trap('INT') do
        puts 'exiting INT'
        connection.close { EventMachine.stop }
    end
end
