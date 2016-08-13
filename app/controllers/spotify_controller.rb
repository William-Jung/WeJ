class SpotifyController < ApplicationController

  def show
    p params
    # @artists = RSpotify::Artist.search('Arctic Monkeys')

  end

  def search

    if params[:type] == "song"
      @return_json = RSpotify::Track.search(params[:query], limit: 10)
      render 'show'

    elsif params[:type] == "artist"
      @return_json = RSpotify::Artist.search(params[:query], limit: 10)
      render 'show'

    elsif params[:type] == "album"
      @return_json = RSpotify::Album.search(params[:query], limit: 10)
      render 'show'
    else
      flash[:notice] = "We couldn't find what you were looking for!"
    end

  end

  private
  # def search_params
  #   params.require(:search).permit(:query, :type)
  # end

end
