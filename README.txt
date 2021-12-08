Запускаем rabbitmq:
docker-compose up -d rabbitmq

Запускаем сервер рассчёта стоимости:
docker-compose run --rm app-p-41 ruby cost_server.rb

Запускаем сервис, который запрашивает стоимость ВМ по параметрам:
docker-compose run --rm app-p-41 ruby request_sender.rb
