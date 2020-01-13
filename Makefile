create:
	docker-compose run web bundle exec rake db:create
	docker-compose run web bundle exec rake db:schema:load

migrate:
	docker-compose run web bundle exec rake db:migrate

rollback:
	docker-compose run web bundle exec rake db:rollback

build:
	docker-compose build

seed:
	docker-compose run web bundle exec rake db:seed
 
up:
	docker-compose up
 
test:
	docker-compose run web rake
 
clean:
	rm -rf ./tmp
	rm -rf ./vendor
 
.PHONY: migrate build seed up test clean rollback