class SongController < ApplicationController

  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs' do
    erb :'songs/index'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  post '/songs/:slug' do
    @song = Song.update_song(params)

    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end

  post '/songs' do
    @song = Song.create_song(params)

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end
end
