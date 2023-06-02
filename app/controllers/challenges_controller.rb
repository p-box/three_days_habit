class ChallengesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_habit

    def index
        @habit = Habit.find(params[:habit_id])
    end

    def create
        challenge = @habit.challenges.new(challenge_params)
        if challenge.save
            flash[:notice] = "挑戦を開始しました"
            redirect_to request.referer
        else
            render "habits/show", status: :unprocessable_entity
        end
    end

    def destroy
       challenge = @habit.challenges.all
       if challenge.destroy_all
        # noticeは変更が必要
        flash[:notice] = "挑戦を開始しました"
        redirect_to habit_path(@habit)
       else
        render "habits/show", status: :unprocessable_entity
       end
    end

    private

    def challenge_params
        params.require(:record).permit(:start_time, :continuation)
    end

    def set_habit
        @habit = Habit.find(params[:habit_id])
    end
        
end
