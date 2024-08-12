class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :authorize_user, only: %i[update destroy]

  def index
    if params[:filter] == 'my'
      return render json: { error: 'You need to sign in or sign up before continuing.' }, status: :unauthorized unless current_user
      @posts = current_user.posts
    else
      @posts = Post.all
    end

    render json: @posts.as_json(include: :user)
  end

  def show
    render json: @post.as_json(include: :user)
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:title, :description, :image)
  end

  def authorize_user
    unless @post.user == current_user
      render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
    end
  end
end
