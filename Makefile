create:
	docker-compose run bip-web bundle exec rake db:create
	docker-compose run bip-web bundle exec rake db:schema:load

migrate:
	docker-compose run bip-web bundle exec rake db:migrate

rollback:
	docker-compose run bip-web bundle exec rake db:rollback

build:
	docker-compose build

seed:
	docker-compose run bip-web bundle exec rake db:seed
 
up:
	docker-compose up
 
test:
	docker-compose run bip-web rake
 
console:
	docker-compose run bip-web "bin/rails c"

bash:
	docker-compose run bip-web bash 

rake:
	docker-compose run bip-web rake $(cmd)

clean:
	rm -rf ./tmp
	rm -rf ./vendor
 
.PHONY: migrate build seed up test clean rollback bash