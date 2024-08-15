class CommentsController < ApiController
  before_action :set_comment, only: %i[ update destroy ]
  before_action :authenticate_user!, only: %i[ update destroy ]
  before_action :authorize_user, only: %i[ update destroy ]

  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def create
    return render json: { error: 'You need to sign in or sign up before continuing.' },
     status: :unauthorized unless current_user

    @comment = current_user.comments.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: new_comment_url(@comment)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.permit(:body, :post_id)
    end

    def authorize_user
      super(@comment)
    end
end
