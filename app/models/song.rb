class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  def self.create_song(params)
    song = Song.new(name: params[:song][:name])

    if !params[:genres].empty?
      params[:genres].each do |genre|
        song.genres << Genre.find(genre)
      end
    end

    if !params[:song][:artist].empty?
      artist = Artist.find_or_create_by(name: params[:song][:artist])
      song.artist_id = artist.id
    end

    song.save
    song
  end

  def self.update_song(params)
    song = Song.find_by(name: params[:song][:name])
    song.update(name: params[:song][:name])

    if !params[:genres].empty?
      params[:genres].each do |genre|
        song.genres << Genre.find(genre)
      end
    end

    if !params[:song][:artist].empty?
      artist = Artist.find_or_create_by(name: params[:song][:artist])
      song.artist_id = artist.id
    end

    song.save
    song
  end
end
