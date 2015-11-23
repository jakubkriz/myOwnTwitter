class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
  end


  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.js # Will search for create.js.erb
      else
        format.html { render root_path }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:author, :title, :body, :tags))
     redirect_to @post
   else
     render 'edit'
   end
 end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:author, :title, :body, :all_tags)
    end
end
