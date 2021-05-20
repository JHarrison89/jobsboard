class JobsController < ApplicationController
  def index
    @jobs = Job.all - Job.all.where(id: Item.all.select(:job_id).where(user_id: current_user, status: 'saved'))
  end

  def saved
    @jobs = Job.all.where(id: Item.all.select(:job_id).where(user_id: current_user, status: 'saved'))
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

  def remove
    item = current_user.items.find_by(job_id: params[:id])
    item.destroy
    redirect_to jobs_saved_path, notice: "Job removed..."
  end

  def removed
    @jobs = Job.all
  end
end
