class PostsController < ApplicationController
  before_action :restrict_to_signed_in, only: [:index, :new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      title: params[:post][:title],
      body: params[:post][:body])
    @post.save

    flash.notice = "Post '#{@post.title}' Created!"

    redirect_to posts_path
  end
end
