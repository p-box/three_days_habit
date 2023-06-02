class ChallengesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_habit

    def create
        challenge = habit.challenges.new(challenge_params)
        if challenge.save
            notice[:flash] = "挑戦を開始しました"
            redirect_to request.referer
        else
            render "habits/show", status: :unprocessable_entity
        end
    end

    def destroy
       challenge = habit.challenges.find(params[:id])
       if challenge.destroy
        # noticeは変更が必要
        notice[:flash] = "挑戦を開始しました"
        redirect_to habit_path(habit)
       else
        render "habits/show", status: :unprocessable_entity
       end
    end

    private

    def challenge_params
        params.require(:challenge).permit(:start_time,:continuation)
    end

    def set_habit
        habit = Habit.find(prams[:id])
    end
        
end
