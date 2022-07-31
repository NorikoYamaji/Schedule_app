class PostsController < ApplicationController
  protect_from_forgery :except => [:destroy]

  def index
    @posts = Post.all #allメソッドはusersテーブルのレコードを全て取得できるメソッド
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :start_day, :end_day, :all_day, :memo))
    if @post.save
      flash[:notice] = "スケジュールが登録されました"
      redirect_to :posts
    else
      flash[:notice] = "スケジュールを登録できませんでした"
      render "new"
    end
  end

  def show
    @post = Post.find_by(params[:id])
  end

  def edit
    @post = Post.find_by(params[:id])
  end

  def update
    @post = Post.find_by(params[:id])
    if @post.update(params.require(:post).permit(:title, :start_day, :end_day, :all_day, :memo))
      flash[:notice] = "スケジュールを編集しました"
      redirect_to :posts
    else
      flash[:notice] = "スケジュールを編集できませんでした"
      render "edit"
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "スケジュールを削除しました"
    redirect_to :posts
  end  
end