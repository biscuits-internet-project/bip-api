migrate:
	docker-compose run web bundle exec rake db:migrate

rollback:
	docker-compose run web bundle exec rake db:rollback

bundle:
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
 
.PHONY: migrate bundle seed up test clean rollback