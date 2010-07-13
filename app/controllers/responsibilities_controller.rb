class ResponsibilitiesController < ApplicationController
  before_filter :find_person_company_project

  # GET /responsibilities
  # GET /responsibilities.xml
  def index
    @responsibilities = @project.responsibilities

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @responsibilities }
    end
  end

  # GET /responsibilities/1
  # GET /responsibilities/1.xml
  def show
    @responsibility = @project.responsibilities.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @responsibility }
    end
  end

  # GET /responsibilities/new
  # GET /responsibilities/new.xml
  def new
    @responsibility = Responsibility.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @responsibility }
    end
  end

  # GET /responsibilities/1/edit
  def edit
    @responsibility = @project.responsibilities.find(params[:id])
  end

  # POST /responsibilities
  # POST /responsibilities.xml
  def create
    @responsibility = @project.responsibilities.new(params[:responsibility])

    respond_to do |format|
      if @responsibility.save
        flash[:notice] = 'Responsibility was successfully created.'
        format.html { redirect_to(person_company_project_responsibility_url(
                @person, @company, @project, @responsibility)) }
        format.xml { render :xml => @responsibility, :status => :created, :location => @responsibility }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @responsibility.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /responsibilities/1
  # PUT /responsibilities/1.xml
  def update
    @responsibility = @project.responsibilities.find(params[:id])

    respond_to do |format|
      if @responsibility.update_attributes(params[:responsibility])
        flash[:notice] = 'Responsibility was successfully updated.'
        format.html { redirect_to(person_company_project_responsibility_url(@person, @company, @project, @responsibility)) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @responsibility.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /responsibilities/1
  # DELETE /responsibilities/1.xml
  def destroy
    responsibility = @project.responsibilities.find(params[:id])
    responsibility.destroy

    respond_to do |format|
      format.html { redirect_to(person_company_project_responsibilities_url(@person, @company, @project)) }
      format.xml { head :ok }
    end
  end

end
