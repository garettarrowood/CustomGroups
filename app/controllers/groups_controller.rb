class GroupsController < ApplicationController

  def index
    # From home page, you select a group or create a group
  end

  def show
    # main class page - From “group” page, can view entire students roster, can click to add student (or adjust roster), (mass assignment, or click to add one more - either way, should be able to view class as you add), and can click to choose to generate random groups, can click "class settings" (or adjust roster)
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

    def group_params
      params.require(:group).permit(:title)
    end

end
