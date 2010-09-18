class TasksController < ApplicationController
  before_filter :load_person_company_project
  before_filter :load_task, :only => [:show, :edit, :update, :delete, :destroy,
                                      :move_top, :move_up, :move_down, :move_bottom]
  before_filter :new_task, :only => [:new, :create, :index]
  filter_access_to :all, :attribute_check => true
  filter_access_to [:reposition, :move_top, :move_up, :move_down, :move_bottom], :require => :update

  # GET people/1/company/1/project/1/tasks
  # GET people/1/company/1/project/1/tasks.xml
  def index
    @tasks = @project.tasks

    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @tasks }
    end
  end

  # GET people/1/company/1/project/1/tasks/1
  # GET people/1/company/1/project/1/tasks/1.xml
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @task }
    end
  end

  # GET people/1/company/1/project/1/tasks/new
  # GET people/1/company/1/project/1/tasks/new.xml
  def new
    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @task }
    end
  end

  # GET people/1/company/1/project/1/tasks/1/edit
  def edit
  end

  # POST people/1/company/1/project/1/tasks
  # POST people/1/company/1/project/1/tasks.xml
  def create
    respond_to do |format|
      if @task.save
        flash[:notice] = "#{@task.description} was successfully created."
        format.html { redirect_to @person }
        format.xml { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => :new }
        format.xml { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT people/1/company/1/project/1/tasks/1
  # PUT people/1/company/1/project/1/tasks/1.xml
  def update
    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = "#{@task.description} was successfully updated."
        format.html { redirect_to @person }
        format.xml { head :ok }
      else
        format.html { render :action => :edit }
        format.xml { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /people/1/companies/1/project/1/tasks/1/delete
  def delete
    respond_to do |format|
      format.html # delete.html.haml
    end
  end

  # DELETE people/1/company/1/project/1/tasks/1
  # DELETE people/1/company/1/project/1/tasks/1.xml
  def destroy
    flash[:notice] = "#{@task.description} was successfully deleted." if @task.destroy

    respond_to do |format|
      format.html { redirect_to @person }
      format.xml { head :ok }
    end
  end


  # PUT /people/1/company/1/projects/1/tasks/reposition
  def reposition
    @project.tasks.each do |task|
      task.position = params[:task].index(task.id.to_s) + 1
      task.save
    end

    render :nothing => true
  end

  # GET /people/1/company/1/project/1/task/1/move_top
  def move_top
    @task.move_to_top
    @task.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  # GET /people/1/company/1/project/1/task/1/move_up
  def move_up
    @task.move_higher
    @task.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  # GET /people/1/company/1/project/1/task/1/move_down
  def move_down
    @task.move_lower
    @task.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  # GET /people/1/company/1/project/1/task/1/move_bottom
  def move_bottom
    @task.move_to_bottom
    @task.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  protected
  def load_task
    @task = @project.tasks.find params[:id]
  end

  def new_task
    @task = @project.tasks.new params[:task]
  end
end
