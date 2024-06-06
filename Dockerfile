FROM ruby:2.7.1

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configurar diretório de trabalho
WORKDIR /myapp

# Copiar Gemfile e Gemfile.lock e instalar gems
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Copiar o restante do código da aplicação
COPY . /myapp

# Pré-compilar assets para produção
RUN bundle exec rails assets:precompile

# Expor a porta da aplicação
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
