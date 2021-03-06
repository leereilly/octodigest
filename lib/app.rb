require 'sinatra'
require 'json'
require 'erb'


  enable :static
  views = './views'

  helpers do
    require './lib/helpers'
  end

  get "/" do
    erb :index
  end

  post "/" do
    redirect("#{h params[:user]}/#{h params[:repo]}")
  end

  get "/:user/:repo" do
    @data = ghet("https://github.com/api/v2/json/repos/show/#{h params[:user]}/#{h params[:repo]}/contributors")
    if @data.has_key? "error"
      @title = "Not Found..."
      erb :nf
    else
      @title = "#{h params[:user]}/#{h params[:repo]}"
      erb :repo
    end
  end

  get "/:user/:repo/:tag" do
    tagger
    if @tcommits.include? "error"
      @title = "Not found..."
      erb :nf
    else
      @title = "#{h params[:user]}/#{h params[:repo]} #{h params[:tag]}"
      erb :tag
    end
  end

  not_found do
    erb :nf
  end

