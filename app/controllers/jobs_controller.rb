class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def saved
    @jobs = Job.all(where: user_id == current_user, status: 'saved')
  end

  def removed
    @jobs = Job.all
  end

  def show
  end

  def new
  end

  def create
  end
end
