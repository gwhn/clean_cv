class SkillsController < ApplicationController
  layout 'standard'

  before_filter :load_person
  before_filter :load_skill, :only => [:show, :edit, :update, :delete, :destroy]
  before_filter :new_skill, :only => [:new, :create, :index]
  filter_access_to :all, :attribute_check => true
  filter_access_to :reposition, :require => :update

  # GET /people/1/skills
  # GET /people/1/skills.xml
  def index
    @skills = @person.skills

    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @skills }
    end
  end

  # GET /people/1/skills/1
  # GET /people/1/skills/1.xml
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @skill }
    end
  end

  # GET /people/1/skills/new
  # GET /people/1/skills/new.xml
  def new
    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @skill }
    end
  end

  # GET /people/1/skills/1/edit
  def edit
  end

  # POST /people/1/skills
  # POST /people/1/skills.xml
  def create
    respond_to do |format|
      if @skill.save
        flash[:notice] = 'Skill was successfully created.'
        format.html { redirect_to(person_skill_url(@person, @skill)) }
        format.xml { render :xml => @skill, :status => :created, :location => @skill }
        format.js { render :layout => false }
      else
        format.html { render :action => :new }
        format.xml { render :xml => @skill.errors, :status => :unprocessable_entity }
        format.js { render :action => :invalid, :layout => false }
      end
    end
  end

  # PUT /people/1/skills/1
  # PUT /people/1/skills/1.xml
  def update
    respond_to do |format|
      if @skill.update_attributes(params[:skill])
        flash[:notice] = 'Skill was successfully updated.'
        format.html { redirect_to(person_skill_url(@person, @skill)) }
        format.xml { head :ok }
        format.js { render :layout => false }
      else
        format.html { render :action => :edit }
        format.xml { render :xml => @skill.errors, :status => :unprocessable_entity }
        format.js { render :action => :invalid, :layout => false }
      end
    end
  end

  # GET /people/1/skills/1/delete
  def delete
    respond_to do |format|
      format.html # delete.html.haml
    end
  end

  # DELETE /people/1/skills/1
  # DELETE /people/1/skills/1.xml
  def destroy
    redirect_to(person_skill_url(@person, @skill)) and return if params[:cancel]
    @skill.destroy

    respond_to do |format|
      format.html { redirect_to(person_skills_url(@person)) }
      format.xml { head :ok }
      format.js
    end
  end

  # PUT /people/1/skills/reposition
  def reposition
    @person.skills.each do |skill|
      skill.position = params[:skill].index(skill.id.to_s) + 1
      skill.save
    end

    render :nothing => true
  end

  protected
  def load_skill
    @skill = @person.skills.find params[:id]
  end

  def new_skill
    @skill = @person.skills.new params[:skill]
  end
end
