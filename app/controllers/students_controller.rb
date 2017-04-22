class StudentsController < ApplicationController
  before_action :set_group
  before_action :set_student, only: [:update, :destroy]
  before_action :authenticate_user!

  def new
    @student = Student.new
  end

  def create
    @student = @group.students.build(student_params)
    if @student.save
      if params[:commit] == 'Add next student'
        flash[:notice] = 'Student created, next...'
        redirect_to new_group_student_path
      else
        flash[:notice] = 'Last student saved.'
        redirect_to @group
      end
    else
      flash[:alert] = 'Student was not created'
      render 'new'
    end
  end

  def roster_edit
  end

  def update
    if @student.update(student_params)
      flash[:notice] = "#{@student.first_name} #{@student.last_name} updated."
      redirect_to group_edit_roster_path(@group)
    else
      flash[:alert] = "Unable to update"
      render action: 'roster_edit'
    end
  end

  def destroy
    @group.separations.each do |separt|
      if separt.person1_id == @student.id || separt.person2_id == @student.id
        separt.destroy
      end
    end
    @student.destroy
    flash[:alert] = "#{@student.first_name} #{@student.last_name} has been removed from your roster."
    redirect_to group_edit_roster_path(@group)
  end

  private

    def student_params
      params.require(:student).permit(:first_name, :last_name, :gender)
    end

    def set_group
      @group = Group.find(params[:group_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'The class your looking for could not be found.'
      redirect_to root_path
    end

    def set_student
      @student = @group.students.find(params[:id])
    end

end
