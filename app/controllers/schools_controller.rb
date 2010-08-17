class SchoolsController < ApplicationController
  layout 'standard'

  before_filter :load_person
  before_filter :load_school, :only => [:show, :edit, :update, :delete, :destroy]
  before_filter :new_school, :only => [:new, :create, :index]
  filter_access_to :all, :attribute_check => true

  # GET /people/1/schools
  # GET /people/1/schools.xml
  def index
    @schools = @person.schools

    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @schools }
    end
  end

  # GET /people/1/schools/1
  # GET /people/1/schools/1.xml
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @school }
    end
  end

  # GET /people/1/schools/new
  # GET /people/1/schools/new.xml
  def new
    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @school }
    end
  end

  # GET /people/1/schools/1/edit
  def edit
  end

  # POST /people/1/schools
  # POST /people/1/schools.xml
  def create
    respond_to do |format|
      if @school.save
        flash[:notice] = 'School was successfully created.'
        format.html { redirect_to(person_school_url(@person, @school)) }
        format.xml { render :xml => @school, :status => :created, :location => @school }
        format.js { render :layout => false }
      else
        format.html { render :action => :new }
        format.xml { render :xml => @school.errors, :status => :unprocessable_entity }
        format.js { render :action => :invalid, :layout => false }
      end
    end
  end

  # PUT /people/1/schools/1
  # PUT /people/1/schools/1.xml
  def update
    respond_to do |format|
      if @school.update_attributes(params[:school])
        flash[:notice] = 'School was successfully updated.'
        format.html { redirect_to(person_school_url(@person, @school)) }
        format.xml { head :ok }
        format.js { render :layout => false }
      else
        format.html { render :action => :edit }
        format.xml { render :xml => @school.errors, :status => :unprocessable_entity }
        format.js { render :action => :invalid, :layout => false }
      end
    end
  end

  # GET /people/1/schools/1/delete
  def delete
    respond_to do |format|
      format.html # delete.html.haml
    end
  end

  # DELETE /people/1/schools/1
  # DELETE /people/1/schools/1.xml
  def destroy
    redirect_to(person_school_url(@person, @school)) and return if params[:cancel]
    @school.destroy

    respond_to do |format|
      format.html { redirect_to(person_schools_url(@person)) }
      format.xml { head :ok }
      format.js
    end
  end

  protected
  def load_school
    @school = @person.schools.find params[:id]
  end

  def new_school
    @school = @person.schools.new params[:school]
  end
end
