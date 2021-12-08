require 'json'

PRICES = {
    cpu: 10,
    ram: 25,
    sata: 5,
    sas: 10,
    ssd: 15
}


class CostVmService
    def self.call(payload)
        hardware = JSON.parse(payload)
        cost = \
        hardware['cpu'] * PRICES[:cpu] +
        hardware['ram'] * PRICES[:ram] +
        PRICES[ hardware['hdd'].to_sym ]
        cost_send(cost)
    end

    def self.cost_send(cost)
        connection = Bunny.new('amqp://guest:guest@rabbitmq')
        connection.start
        channel = connection.create_channel
        exchange = channel.default_exchange
        queue_name = 'response_with_cost'
        exchange.publish("#{cost}", routing_key: queue_name)
    end

end
