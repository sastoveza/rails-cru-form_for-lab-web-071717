class SongsController < ApplicationController

	def show
		@song = Song.find(params[:id])
		@genre = @song.genre
		@artist = @song.artist
	end

	def new
		@song = Song.new

	end

	def edit
		@song = Song.find(params[:id])
		
	end


	def create 
		@genre = Genre.find_or_create_by(name: params[:song][:genre])
		@artist = Artist.find_or_create_by(name: params[:song][:artist])
		@song = Song.create(name: params[:song][:name], genre: @genre, artist: @artist)

		redirect_to song_path(@song)
	end


	def update
		@song = Song.find(params[:id])
		@song.update(song_params)
		@song.save

		redirect_to song_path(@song)
	end

	def index
		@songs = Song.all
	end

	private

	def song_params
		params.require(:song).permit(:name, :genre_id, :artist_id)
	end
end
