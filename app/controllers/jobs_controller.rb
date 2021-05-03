class JobsController < ApplicationController
  def index
    #Select all jobs which current user does not have an item for
    @jobs = Job.all.where(id: Item.all.select(:job_id).where!(user_id: current_user, status: 'none'))
  end

  def save
    job = Job.find(params[:id])
    Item.create!(
      user_id: current_user.id,
      job_id: job.id,
      status: 'saved'
    )
    redirect_to jobs_path, notice: "Job saved..."
  end

  def saved
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

  def update
    item = Item.find(params[:id])
    if item.status == 'saved'
      item.status = 'none'
    else
      item.status = 'saved'
    end
    redirect_to jobs_saved_path, notice: "Job saved..."
  end
end
