migrate:
	docker-compose run web bundle exec rake db:migrate

rollback:
	docker-compose run web bundle exec rake db:rollback

build:
	docker-compose build

seed:
	docker-compose run web bundle exec rake db:seed
 
run:
	docker-compose up
 
test:
	docker-compose run -e "RAILS_ENV=test" web bundle exec rake db:create db:migrate
	docker-compose run -e "RAILS_ENV=test" web bundle exec rspec
 
clean:
	rm -rf ./tmp
	rm -rf ./vendor
 
.PHONY: install migrate build seed run test clean rollback