class TasksController < ApplicationController
  before_filter :load_person_company_project
  before_filter :load_task, :only => [:show, :edit, :update, :destroy]
  before_filter :new_task, :only => [:new, :create, :index]
  filter_access_to :all, :attribute_check => true
  filter_access_to :reposition, :require => :update

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
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to(person_company_project_task_url(@person, @company, @project, @task)) }
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
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(person_company_project_task_url(@person, @company, @project, @task)) }
        format.xml { head :ok }
      else
        format.html { render :action => :edit }
        format.xml { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE people/1/company/1/project/1/tasks/1
  # DELETE people/1/company/1/project/1/tasks/1.xml
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(person_company_project_tasks_url(@person, @company, @project)) }
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

  protected
  def load_task
    @task = Task.find params[:id]
  end

  def new_task
    @task = @project.tasks.new params[:task]
  end
end
