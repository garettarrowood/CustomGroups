class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy, :small_groups, :grouping, :class_settings, :gender_setter]

  def index
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      redirect_to new_group_student_path(@group)
    else
      flash[:alert] = "Class needs to have a title"
      render "new"
    end
  end

  def class_edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "#{@group.title} updated."
      redirect_to :class_edit
    else
      flash[:alert] = "Unable to update"
      render action: 'class_edit'
    end
  end

  def destroy
    @group.destroy
    flash[:alert] = "#{@group.title} has been deleted."
    redirect_to groups_path
  end

  def gender_setter
    @group.update(group_params)
    redirect_to "/groups/#{@group.id}/class_settings"
  end

  def small_groups
    @group.check_loop_scenario ? @min = 3 : @min = 2
    @max = ((@group.students.length + 1) / 2) > 2 ? ((@group.students.length + 1) / 2) : 2
  end

  def grouping
    Randomizer.group_id = @group.id
    Randomizer.number = params[:number]
    redirect_to "/groups/#{@group.id}/small_groups"
  end

  def class_settings
  end

  private 

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:title, :genderfied)
    end

end
