privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end

authorization do
  role :guest do
    has_permission_on :people, :to => :read
  end

  role :author do
    includes :guest
    has_permission_on :people, :to => :create
    has_permission_on :people, :to => [:update, :delete] do
      if_attribute :user => is { user }
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
    has_permission_on [:people, :companies, :skills, :schools, :projects, :responsibilities, :tasks],
                      :to => :manage
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :authorization_usages, :to => :read
  end
end