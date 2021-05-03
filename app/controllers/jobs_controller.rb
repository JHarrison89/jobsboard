class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def saved
    # @jobs = Item.all.where(user_id: current_user, status: 'saved')
    # @saved = Item.all.select(:job_id).where(user_id: 21, status: 'saved')
    @jobs = Job.all.where(id: Item.all.select(:job_id).where(user_id: current_user, status: 'saved'))
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
