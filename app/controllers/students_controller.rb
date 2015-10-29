class StudentsController < ApplicationController
  before_action :set_group
  before_action :set_student, only: [:update, :destroy]
  before_action :set_all_students_in_group_by_last_name

  def index
    # shows class roster - Class settings - CRUD operations on students, can also add exceptions, should ALSO be able to view full roster here
  end

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
    @group = Group.find(params[:group_id])
  end

  def update
    binding.pry
  end

  def destroy
    binding.pry
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
