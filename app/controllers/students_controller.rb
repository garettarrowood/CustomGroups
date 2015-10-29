class StudentsController < ApplicationController
  before_action :set_group
  before_action :set_student, only: [:update, :destroy]
  before_action :set_all_students_in_group_by_last_name

  def new
    @student = Student.new
  end

  def create
    @student = @group.students.build(student_params)
    if @student.save
      if params[:commit] == 'Add next student'
        flash[:alert] = 'Student created, next...'
        redirect_to new_group_student_path
      else 
        flash[:alert] = 'Last student saved.'
        redirect_to @group
      end
    else
      flash[:alert] = 'Student was not created'
      render 'new'
    end
  end

  def separation
    # explain how exceptions always apply to random generation - Exception selection form - dropdown menu to choose two students from same class
  end

  def add_separation
    # save to Separation class
  end

  def roster_edit
  end

  def update

    if @student.update(student_params)
      flash[:notice] = "#{@student.first_name} #{@student.last_name} updated."
      redirect_to group_students_roster_edit_path(@group)
    else
      flash[:alert] = "Unable to update"
      render action: 'roster_edit'
    end
  end

  def destroy
    @student.destroy
    flash[:alert] = "#{@student.first_name} #{@student.last_name} has been removed from your roster."
    redirect_to group_students_roster_edit_path(@group)
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

    def set_all_students_in_group_by_last_name
      @students = @group.students.sort { |a,b| a.last_name.downcase <=> b.last_name.downcase }
    end

end
