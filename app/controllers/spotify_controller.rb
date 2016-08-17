class SpotifyController < ApplicationController

  def show
    p params
    # @artists = RSpotify::Artist.search('Arctic Monkeys')

  end

  def search

    if request.xhr?
      @return_json = RSpotify::Track.search(params[:query], limit: 10)
      render json: @return_json
      # flash[:notice] = "We couldn't find what you were looking for!"
    end

  end

  private
  # def search_params
  #   params.require(:search).permit(:query, :type)
  # end

end
