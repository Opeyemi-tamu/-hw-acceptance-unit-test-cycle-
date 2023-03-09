Rottenpotatoes::Application.routes.draw do
  resources :movies

  match 'movies/others/:id/', to: 'movies#show_by_director', via: %i[get post], as: 'search_directors' # , defaults: { director: 'JCole' }
  # map '/' to be a redirect to '/movies'
  root to: redirect('/movies')
end
