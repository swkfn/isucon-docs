# https://github.com/k-nasa/isucon-magic-powder/blob/master/Makefile

.DEFAULT_GOAL := help

APP_DIR := todo

NGINX_LOG := /var/log/nginx/access.log
MYSQL_SLOW_LOG := /var/log/mysql/slow.log

MYSQL_CONFIG := /etc/mysql/my.cnf
NGINX_CONFIG := /etc/nginx/nginx.conf

DB_HOST := 127.0.0.1
DB_PORT := 3306
DB_USER := todo
DB_PASS := todo
DB_NAME := todo

NOW := $$(date "+%Y%m%d-%H%M%S")
LOG := /home/isucon/logs

.PHONY: help
help: ## show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; { \
		printf "\033[36m%-20s\033[0m %s\n", $$1, $$2 \
	}'

.PHONY: log_reset
log_reset: ## logファイルを初期化する
	@sudo cp $(MYSQL_SLOW_LOG) > $(LOG)/mysql_slow_log/$(NOW)
	@sudo cp $(NGINX_LOG) > $(LOG)/nginx/$(NOW)
	@sudo cp /dev/null $(MYSQL_SLOW_LOG)
	@sudo cp /dev/null $(NGINX_LOG)

.PHONY: alp
alp: ## alpのログを見る (make alp ALP_ARG="")
	@sudo cat $(NGINX_LOG) | alp ltsv --sort avg -r $(ALP_ARG)
	@sudo cat $(NGINX_LOG) | alp ltsv --sort avg -r $(ALP_ARG) > $(LOG)/alp/$(NOW)

.PHONY: slow
slow: ## スロークエリを見る
	@sudo pt-query-digest $(MYSQL_SLOW_LOG)
	@sudo pt-query-digest $(MYSQL_SLOW_LOG) > $(LOG)/pt_query_digest/$(NOW)

.PHONY: slow_on
slow_on: ## mysqlのslowログをonにする
	@sudo mysql -e "set global slow_query_log_file = '$(MYSQL_SLOW_LOG)'; set global long_query_time = 0; set global slow_query_log = ON;"

.PHONY: slow_off
slow_off: ## mysqlのslowログをoffにする
	@sudo mysql -e "set global slow_query_log = OFF;"

.PHONY: show_slow_config
show_slow_config: ## mysqlのslowログ設定を確認するコマンド
	@sudo mysql -e "show variables like 'slow_query%'"

.PHONY: send_result
send_result: ## discordにalpとslowの出力を送信する
	@make alp  > tmp.txt && discordcat -f tmp.txt --filename alp.md
	@make slow > tmp.txt && discordcat -f tmp.txt --filename slow_log.txt

.PHONY: mysql
mysql: ## mysql接続コマンド
	mysql -h $(DB_HOST) -u $(DB_USER) -p$(DB_PASS) $(DB_NAME)

pprof:
	@go tool pprof -png -output pprof.png http://localhost:6060/debug/pprof/profile && discordcat -f pprof.png --filename pprof.png

.PHONY: application_build
application_build: ## application build (wip)
	@echo "Please implement!!"

.PHONY: application_restart
application_restart: ## application restart (wip)
	@echo "Please implement!!"

.PHONY: middleware_restart
middleware_restart: ## mysqlとnginxのrestart
	sudo systemctl restart mysql
	sudo systemctl restart nginx

.PHONY: restart
restart: application_restart middleware_restart ## application, mysql, nginxのリスタート

.PHONY: pre-bench
pre-bench: log_reset application_build restart slow_on ## bench回す前に実行するコマンド(これで全ての前処理が完了する状態を作る)