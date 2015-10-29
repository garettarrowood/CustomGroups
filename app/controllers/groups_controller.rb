class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_all_students_in_group_by_last_name, only: [:show, :edit, :update, :destroy]

  def index
    # From home page, you select a group or create a group
  end

  def show
    # still to set up - click to choose to generate random groups, class settings link to setting up seperations
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

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
    # From random generation page, can specify how many groups you want, and whether they should be required to be mixed gender (exceptions always apply, but DO NOT remind user here) - SO THIS PAGE DISPLAYS FORM
  end

  def grouping
    # takes #small_groups data and generates groups, renders a page with links back to other stuff
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
