# Используем официальный образ Ruby
FROM ruby:3.3.3

# Устанавливаем необходимые зависимости
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Устанавливаем директорию для нашего приложения
WORKDIR /app

# Копируем Gemfile и Gemfile.lock в директорию приложения
COPY Gemfile* ./

# Устанавливаем зависимости приложений
RUN bundle install

# Копируем всё остальное в директорию приложения
COPY . .

# Предкомпилируем ассеты
RUN bundle exec rake assets:precompile

# Запуск сервера
CMD ["rails", "server", "-b", "0.0.0.0"]
