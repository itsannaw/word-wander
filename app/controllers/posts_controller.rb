class PostsController < ApiController
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
    render json: @post.as_json(include: { user: { only: [:name] }, comments: { include: { user: { only: [:name] } } } })
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
    super(@post)
  end

  def paginate(relation)
    relation.page(params[:page]).per(params[:per_page])
  end

end
