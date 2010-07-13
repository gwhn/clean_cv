class ProjectsController < ApplicationController
  before_filter :find_person_company
  
  # GET /people/1/company/1/projects
  # GET /people/1/company/1/projects.xml
  def index
    @projects = @company.projects

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /people/1/company/1/projects/1
  # GET /people/1/company/1/projects/1.xml
  def show
    @project = @company.projects.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /people/1/company/1/projects/new
  # GET /people/1/company/1/projects/new.xml
  def new
    @project = Project.new
    @project.responsibilities.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /people/1/company/1/projects/1/edit
  def edit
    @project = @company.projects.find(params[:id])
  end

  # POST /people/1/company/1/projects
  # POST /people/1/company/1/projects.xml
  def create
    @project = @company.projects.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(person_company_project_url(@person, @company, @project)) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1/company/1/projects/1
  # PUT /people/1/company/1/projects/1.xml
  def update
    params[:project][:existing_responsibility_attributes] ||= {}
    @project = @company.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(person_company_project_url(@person, @company, @project)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1/company/1/projects/1
  # DELETE /people/1/company/1/projects/1.xml
  def destroy
    project = @company.projects.find(params[:id])
    project.destroy

    respond_to do |format|
      format.html { redirect_to(person_company_projects_url(@person, @company)) }
      format.xml  { head :ok }
    end
  end

end
