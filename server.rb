require 'sinatra/base'
require 'time'
require 'json'
require "sinatra/multi_route"
require 'logger'
require 'dotenv'
Dotenv.load('.env')

class App < Sinatra::Base
    set :bind, "0.0.0.0"
    set :server, :puma

    register Sinatra::MultiRoute

    before do
      $logger = Logger.new(STDOUT)
    end

    after do
      $logger.info ">>> #{request.request_method} #{request.url} #{request.ip} #{response.status}"
    end

    get '/metrics' do
      "es_member #{ENV['TKN']}"
    end

    error Sinatra::NotFound do
      status 404
      erb :notfound, {:layout => :index_layout}, {:main_class=>"page"}
    end

    run!
  end