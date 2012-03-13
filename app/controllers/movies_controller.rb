class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort=params[:sort]
    @ratings=params[:ratings]
    redirect = false
    if @sort
        session[:sort]=@sort
    else
        @sort=session[:sort]
        redirect = true if @sort
    end
    if @ratings
        session[:ratings]=@ratings
    else
        @ratings=session[:ratings]
        redirect = true if @ratings
    end
    @all_ratings = Movie.all_ratings
    if @ratings
        @ratings.keys.each do |rating|
            @all_ratings[rating]=true
        end
        @movies=Movie.order(@sort).find_all_by_rating(@ratings.keys)
    else
        @movies=Movie.order(@sort).all
    end
    if redirect
        redirect_to movies_path(:sort => @sort, :ratings => @ratings)
    end
    #debugger
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
