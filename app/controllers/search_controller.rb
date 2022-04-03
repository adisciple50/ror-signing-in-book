class SearchController < ApplicationController

  def search
    if params[:search]
      redirect_to :controller => :search,:action => :view,search:params[:search]
    else params[:search].blank?
    redirect_to :controller => :entries,action: :new
    end
  end

  def view
    if params[:search] != nil
      # the array reference [0] is needed to bust out the AR entry out of the aray so the view can use to_model
      @entry = Entry.where(username: params[:search],time_out: nil ).order(created_at: :desc).limit(1)[0]
      render(:view, status: :ok,locals: {entry:@entry})
    else
      raise "session search is #{params[:search]}"
      flash.alert = 'You must search for your name (which is case sensitive) or be an admin to view this'
      redirect_to root_url
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def entry_params
    parameters = params.require(:entry).permit(:search)
    # puts parameters.to_h.to_s
    return parameters
  end
end
