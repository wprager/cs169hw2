class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.allratings
    if params[:sortby] == nil
      params[:sortby] = session[:sortby]
    end
    @sort = params[:sortby]
    session[:sortby] = @sort
    if params[:ratings] == nil
      params[:ratings] = session[:ratings]
    end
    if params[:ratings] != nil
      selected_ratings = params[:ratings].keys
    else
      selected_ratings = @all_ratings
    end
    session[:ratings] = params[:ratings]
    @movies = Movie.order(@sort).where(rating: selected_ratings)
    @checked = selected_ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
