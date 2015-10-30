class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :small_groups]
  before_action :set_all_students_in_group_by_last_name, only: [:show, :edit, :update, :destroy, :small_groups]

  def index
  end

  def show
    # still to set up - click to choose to generate random groups, class settings link to setting up seperations
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

  def edit
    # change group title
  end

  def update
    # save new group title
  end

  def destroy
    # delete group
  end

  def small_groups
  end

  def grouping
    # takes #small_groups data and generates groups, renders a page with links back to other stuff
  end

  def class_settings
  end

  def add_separation
    # save to Separation class
  end

  private 

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:title)
    end

    def set_all_students_in_group_by_last_name
      @students = @group.students.sort { |a,b| a.last_name.downcase <=> b.last_name.downcase }
    end

end
