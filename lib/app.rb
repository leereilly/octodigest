require 'sinatra/base'
require 'mustache/sinatra'

class Octodigest < Sinatra::Base
  enable :static
  set :public, './public'

  register Mustache::Sinatra
  require './views/layout'

  set :mustache, {
    :views => './views',
    :templates => 'templates/'
  }

  helpers do
    require 'gah'
  end

  get "/" do
    mustache :index
  end

  post "/" do
    redirect("#{params[:user]}/#{params[:repo]}")
  end

  get "/:user/:repo" do
    
    @gah = Gah::Commits.new("#{params[:user]}/#{params[:repo]}")
    
    @title = "#{params[:user]}/#{params[:repo]}"
    mustache :repo
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

end