Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'decisions/pareto', to: 'decisions#pareto_method'
  get 'decisions/initial', to: 'decisions#initial_data'
  get 'decisions/normalized', to: 'decisions#normalized'
  get 'decisions/electre', to: 'decisions#electre'
end
