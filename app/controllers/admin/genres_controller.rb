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
      flash.alert = "お手数ですが、操作をやり直してください。"
      render :back
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash.notice = "ジャンル名を変更しました。"
      redirect_to admin_genres_path
    else
      flash.alert = "お手数ですが、操作をやり直してください。"
      render :back
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
