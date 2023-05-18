class SearchesController < ApplicationController
    before_action :authenticate_user!

    def search
        @range = params[:range]
        @word = params[:word]
        @condition = search_condition_lang_jp(params[:condition])

        # if @range == "User"
            @users = User.looks(params[:condition], params[:word])
            render "/searches/search_result"
        # else
        #     @posts = Post.Looks(params[:condition], params[:word])
        # end
    end

    private
    def search_condition_lang_jp(condition)
        if condition == "perfect_match"
            @condition = "完全一致"
          elsif condition == "forward_match"
            @condition = "前方一致"
          elsif condition == "backward_match"
            @condition = "後方一致"
          elsif condition == "partial_match"
            @condition = "部分一致"
        end
    end
end
