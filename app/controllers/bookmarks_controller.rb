class BookmarksController < ApplicationController

def new
  @list = List.find(params[:list_id])
  # @movie = Movie.find(params[:movie_id])
  @bookmark = Bookmark.new
end

def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:bookmark][:movie])
    # @movie = Movie.find(params[:movie_id])
    @bookmark = Bookmark.new(params_bookmark)
    @bookmark.list = @list
    @bookmark.movie = @movie
    # @bookmark.movie = @movie # Pas besoin de préciser l'id
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end


  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list # -> Je récupère le list avant de supprimer la bookmark
    # @movie = @bookmark.movie
    @bookmark.destroy
    redirect_to list_path(@list)
  end

  private

  def params_bookmark
    params.require(:bookmark).permit(:comment, :list_id)
  end

end
