class MatchesController < ApplicationController
  def index
    @user_stand_by =User.where(matching_status: 1)
  end
  
  def matching
  end
end
