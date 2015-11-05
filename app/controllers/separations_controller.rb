class SeparationsController < ApplicationController
  before_action :set_separation, only: [:destroy]
  before_action :set_group

  def create
    if @group.separations.length >= 3
      flash[:alert] = "Cannot create anymore special cases."
      return redirect_to "/groups/#{@group.id}/class_settings"
    elsif params[:separation][:person1_id] == params[:separation][:person2_id]
      flash[:alert] = "Cannot separate a student from her/himself."
      return redirect_to "/groups/#{@group.id}/class_settings"
    end
    @separation = @group.separations.build(separation_params)
    if @separation.check_redundancies
      flash[:alert] = "This preference already exists"
      return redirect_to "/groups/#{@group.id}/class_settings"
    end
    if @separation.save
      flash[:notice] = "Student preference saved"
      redirect_to "/groups/#{@group.id}/class_settings"
    else
      flash[:alert] = "Separation could not be saved"
      redirect_to "/groups/#{@group.id}/class_settings"
    end
  end

  def destroy
    @separation.destroy
    flash[:alert] = "Separation has been deleted."
    redirect_to "/groups/#{@group.id}/class_settings"
  end

  private

    def set_separation
      @separation = Separation.find(params[:id])
    end

    def separation_params
      params.require(:separation).permit(:person1_id, :person2_id)
    end

    def set_group
      @group = Group.find(params[:group_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'The class your looking for could not be found.'
      redirect_to root_path
    end

end

