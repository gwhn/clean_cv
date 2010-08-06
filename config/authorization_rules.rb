authorization do
  role :admin do
    has_permission_on [:people, :companies, :skills, :schools, :projects, :responsibilities, :tasks],
                      :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:people, :companies, :skills, :schools, :projects],
                      :to => [:delete]
    has_permission_on [:skills, :responsibilities, :tasks],
                      :to => [:sort]
  end
end