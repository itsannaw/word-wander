class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :authorize_user, only: %i[update destroy]

  def index
    if params[:filter] == 'my'
      return render json: { error: 'You need to sign in or sign up before continuing.' },
        status: :unauthorized unless current_user
      @posts = paginate(current_user.posts)
    else
      @posts = paginate(Post.all)
    end

    total_pages = @posts.total_pages
    render json: { posts: @posts.as_json(include: :user), total_pages: total_pages }
  end

  def show
    render json: @post.as_json(include: [:user, :comments])
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: new_comment_url(@comment)
    else
      render json: @comment.errors, status: :unprocessable_entity
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
    super(@post)
  end

  def paginate(relation)
    relation.page(params[:page]).per(params[:per_page])
  end

end
