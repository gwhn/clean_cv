class SkillsController < ApplicationController
  before_filter :find_person
  
  # GET /people/1/skills
  # GET /people/1/skills.xml
  def index
    @skills = @person.skills

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @skills }
    end
  end

  # GET /people/1/skills/1
  # GET /people/1/skills/1.xml
  def show
    @skill = @person.skills.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @skill }
    end
  end

  # GET /people/1/skills/new
  # GET /people/1/skills/new.xml
  def new
    @skill = Skill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @skill }
    end
  end

  # GET /people/1/skills/1/edit
  def edit
    @skill = @person.skills.find(params[:id])
  end

  # POST /people/1/skills
  # POST /people/1/skills.xml
  def create
    @skill = @person.skills.new(params[:skill])

    respond_to do |format|
      if @skill.save
        flash[:notice] = 'Skill was successfully created.'
        format.html { redirect_to(person_skills_url(@person)) }
        format.xml  { render :xml => @skill, :status => :created, :location => @skill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @skill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1/skills/1
  # PUT /people/1/skills/1.xml
  def update
    @skill = @person.skills.find(params[:id])

    respond_to do |format|
      if @skill.update_attributes(params[:skill])
        flash[:notice] = 'Skill was successfully updated.'
        format.html { redirect_to(person_skills_url(@person)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @skill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1/skills/1
  # DELETE /people/1/skills/1.xml
  def destroy
    skill = @person.skills.find(params[:id])
    skill.destroy

    respond_to do |format|
      format.html { redirect_to(person_skills_url(@person)) }
      format.xml  { head :ok }
    end
  end
end
