class ProjectsController < ApplicationController
  before_filter :load_person_company
  before_filter :load_project, :only => [:show, :edit, :update, :delete, :destroy,
                                         :move_top, :move_up, :move_down, :move_bottom]
  before_filter :new_project, :only => [:new, :create, :index]
  filter_access_to :all, :attribute_check => true
  filter_access_to [:reposition, :move_top, :move_up, :move_down, :move_bottom], :require => :update

  # GET /people/1/company/1/projects
  # GET /people/1/company/1/projects.xml
  def index
    @projects = @company.projects

    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @projects }
    end
  end

  # GET /people/1/company/1/projects/1
  # GET /people/1/company/1/projects/1.xml
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @project }
    end
  end

  # GET /people/1/company/1/projects/new
  # GET /people/1/company/1/projects/new.xml
  def new
    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @project }
    end
  end

  # GET /people/1/company/1/projects/1/edit
  def edit
  end

  # POST /people/1/company/1/projects
  # POST /people/1/company/1/projects.xml
  def create
    respond_to do |format|
      if @project.save
        flash[:notice] = "#{@project.name} was successfully created."
        format.html { redirect_to @person }
        format.xml { render :xml => @project, :status => :created, :location => @project }
        format.js { render :layout => false }
      else
        format.html { render :action => :new }
        format.xml { render :xml => @project.errors, :status => :unprocessable_entity }
        format.js { render :action => :invalid, :layout => false }
      end
    end
  end

  # PUT /people/1/company/1/projects/1
  # PUT /people/1/company/1/projects/1.xml
  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = "#{@project.name} was successfully updated."
        format.html { redirect_to @person }
        format.xml { head :ok }
        format.js { @project.reload and render :layout => false }
      else
        format.html { render :action => :edit }
        format.xml { render :xml => @project.errors, :status => :unprocessable_entity }
        format.js { render :action => :invalid, :layout => false }
      end
    end
  end

  # GET /people/1/companies/1/projects/1/delete
  def delete
    respond_to do |format|
      format.html # delete.html.haml
    end
  end

  # DELETE /people/1/company/1/projects/1
  # DELETE /people/1/company/1/projects/1.xml
  def destroy
    redirect_to @person and return if params[:cancel]
    flash[:notice] = "#{@project.name} was successfully deleted." if @project.destroy

    respond_to do |format|
      format.html { redirect_to @person }
      format.xml { head :ok }
      format.js
    end
  end

  # PUT /people/1/company/1/projects/reposition
  def reposition
    @company.projects.each do |project|
      project.position = params[:project].index(project.id.to_s) + 1
      project.save
    end

    render :nothing => true
  end

  # GET /people/1/company/1/project/1/move_top
  def move_top
    @project.move_to_top
    @project.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  # GET /people/1/company/1/project/1/move_up
  def move_up
    @project.move_higher
    @project.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  # GET /people/1/company/1/project/1/move_down
  def move_down
    @project.move_lower
    @project.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  # GET /people/1/company/1/project/1/move_bottom
  def move_bottom
    @project.move_to_bottom
    @project.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  protected
  def load_project
    @project = @company.projects.find params[:id]
  end

  def new_project
    @project = @company.projects.new params[:project]
  end
end
