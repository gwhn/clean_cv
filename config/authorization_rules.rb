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

  role :user do
    includes :guest
    has_permission_on :people, :to => :create
    has_permission_on :people, :to => [:update, :delete] do
      if_attribute :user => is { user }
    end
  end

  role :admin do
    has_permission_on [:people, :companies, :skills, :schools, :projects, :responsibilities, :tasks],
                      :to => :manage
  end
end