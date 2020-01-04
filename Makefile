install: ## Install or update dependencies
	docker-compose run web bundle exec bundle install
	docker-compose run web bundle exec rake db:migrate

build:
	docker-compose build

seed:
	docker-compose run web bundle exec rake db:seed
 
run: ## Start the app server
	docker-compose up
 
test: ## Run the tests
	docker-compose run web bundle exec rspec ./specs
 
clean: ## Clean temporary files and installed dependencies
	rm -rf ./tmp
	rm -rf ./vendor
 
.PHONY: install run test clean