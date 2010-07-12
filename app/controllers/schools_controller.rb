class SchoolsController < ApplicationController
  before_filter :find_person

  # GET /people/1/schools
  # GET /people/1/schools.xml
  def index
    @schools = @person.schools

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schools }
    end
  end

  # GET /people/1/schools/1
  # GET /people/1/schools/1.xml
  def show
    @school = @person.schools.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @school }
    end
  end

  # GET /people/1/schools/new
  # GET /people/1/schools/new.xml
  def new
    @school = School.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @school }
    end
  end

  # GET /people/1/schools/1/edit
  def edit
    @school = @person.schools.find(params[:id])
  end

  # POST /people/1/schools
  # POST /people/1/schools.xml
  def create
    @school = School.new(params[:school])

    respond_to do |format|
      if @person.schools << @school
        flash[:notice] = 'School was successfully created.'
        format.html { redirect_to(person_schools_url(@person)) }
        format.xml  { render :xml => @school, :status => :created, :location => @school }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @school.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1/schools/1
  # PUT /people/1/schools/1.xml
  def update
    @school = @person.schools.find(params[:id])

    respond_to do |format|
      if @school.update_attributes(params[:school])
        flash[:notice] = 'School was successfully updated.'
        format.html { redirect_to(person_schools_url(@person)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @school.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1/schools/1
  # DELETE /people/1/schools/1.xml
  def destroy
    school = @person.schools.find(params[:id])
    @person.schools.destroy(school)

    respond_to do |format|
      format.html { redirect_to(person_schools_url(@person)) }
      format.xml  { head :ok }
    end
  end
end
