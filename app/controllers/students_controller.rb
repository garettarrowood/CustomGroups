class StudentsController < ApplicationController

  def index
    # shows class roster - Class settings - CRUD operations on students, can also add exceptions, should ALSO be able to view full roster here
  end

  def new
    @group = Group.find(params[:group_id])
    @student = Student.new
  end

  def create
    # save new student - redirect to the right place based on commit
  end

  def separation
    # explain how exceptions always apply to random generation - Exception selection form - dropdown menu to choose two students from same class
  end

  def add_separation
    # save to Separation class
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
