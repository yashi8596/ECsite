class Admin::GenresController < Admin::Base
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash.notice = "ジャンルを追加しました。"
      redirect_to admin_genres_path
    else
      render :index
    end
  end

  def edit
  end

  def update
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
