privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete, :reposition]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
  privilege :reposition, :includes => [:move_top, :move_up, :move_down, :move_bottom]

end

authorization do
  role :guest do
    has_permission_on :people, :to => :read
    # Temporarily uncomment below to run rake tasks and comment above
#    has_permission_on [:people, :companies, :responsibilities, :projects, :tasks, :skills, :schools], :to => :manage
  end

  role :user do
    includes :guest
    has_permission_on :people, :to => :create
    has_permission_on :people, :to => [:update, :delete] do
      if_attribute :user => is { user }
    end
    has_permission_on :social_medias, :to => [:manage] do
      if_attribute :person => {:user => is { user }}
    end
    has_permission_on [:companies, :skills, :schools], :to => :manage do
      if_attribute :person => {:user => is { user }}
    end
    has_permission_on [:projects, :responsibilities], :to => :manage do
      if_attribute :company => {:person => {:user => is { user }}}
    end
    has_permission_on :tasks, :to => :manage do
      if_attribute :project => {:company => {:person => {:user => is { user }}}}
    end
  end

  role :admin do
    has_permission_on [:people, :social_medias, :companies, :skills, :schools, :projects, :responsibilities, :tasks],
                      :to => :manage
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :authorization_usages, :to => :read
  end
end