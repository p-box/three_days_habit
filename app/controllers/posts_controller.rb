class PostsController < ApplicationController
    before_action :authenticate_user!

    def new
        @post = Post.new
    end

    def create
        @user = current_user
        @post = @user.posts.new(post_params)
        p @post
        if @post.save
            flash[:notice] = "投稿に成功しました"
            redirect_to user_path(@user)
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def edit 
    end

    def update
    end
    
    def destroy
    end

    private
        def post_params
            params.require(:post).permit(:body)
        end
end
