# alpineを使ったphpのDockerイメージを使用
FROM php:7-alpine3.12

# 外部に開放するポート
EXPOSE 8000

# パケージマネージャapkでパッケージリポジトリ一覧を更新
RUN apk update --no-cache && apk upgrade --no-cache

# composerのインストール
WORKDIR /tmp
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 開発に必要なパッケージのインストール
RUN apk add --no-cache bash vim jq

# PHPで必要な拡張があればインストール
# パッケージ一覧: https://gist.github.com/chronon/95911d21928cff786e306c23e7d1d3f3
RUN apk add --no-cache oniguruma-dev && \
    docker-php-ext-install -j$(nproc) mbstring pdo_mysql

# 作業用ディレクトリ
WORKDIR /work
CMD ["tail", "-f", "/dev/null"]
