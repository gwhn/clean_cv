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
    has_permission_on :people, :to => [:new, :create]
    has_permission_on :people, :to => [:edit, :update] do
      if_attribute :user => is { user }
    end
  end

  role :admin do
    has_permission_on [:people, :companies, :skills, :schools, :projects, :responsibilities, :tasks],
                      :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:people, :companies, :skills, :schools, :projects],
                      :to => [:delete]
    has_permission_on [:skills, :responsibilities, :tasks],
                      :to => [:sort]
  end
end