Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }, 
                   path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#inicial"
  get "/pages", to: "pages#inicio"
  get "/soporte", to: "pages#soporte"

  get "/inicio/:id", to: 'pages#inicio'

  # RUTAS LIBROS
  get "/libros/search", to: "libros#search", as: "libros/search"
  get "/libros/:user_id", to: "libros#index", as: "libros/index"
  get "/libros", to: "libros#index_sin_sesion", as: "libros/index_sin_sesion"
  get "/users/:user_id/libro/:libro_id", to: "libros#show", as: "libros/show"
  get "/users/:user_id/libros/new", to: "libros#new", as: "libros/new" 
  post "/users/:user_id/libros" , to: "libros#create", as: "libros/create"
  get "/users/:user_id/libro/:libro_id/edit", to: "libros#edit", as: "libros/edit"
  patch "/users/:user_id/libro/:libro_id/update", to: "libros#update", as: "libros/update"
  delete "/users/:user_id/libro/delete/:libro_id", to: "libros#destroy", as: "libros/destroy"

  get "/libros/:libro_id/:user_dueno_id", to: "libros#mostrar", as: "libros/mostrar"

  # RUTAS JUEGOS
  get "/juegos/search", to: "juegos#search", as: "juegos/search"
  get "/juegos/:user_id", to: "juegos#index", as: "juegos/index"
  get "/juegos", to: "juegos#index_sin_sesion", as: "juegos/index_sin_sesion"

  get "/users/:user_id/juego/:juego_id", to: "juegos#show", as: "juegos/show"
  get "/users/:user_id/juegos/new", to: "juegos#new", as: "juegos/new" 
  post "/users/:user_id/juegos" , to: "juegos#create", as: "juegos/create"
  get "/users/:user_id/juego/:juego_id/edit", to: "juegos#edit", as: "juegos/edit"
  patch "/users/:user_id/juego/:juego_id/update", to: "juegos#update", as: "juegos/update"
  delete "/users/:user_id/juego/delete/:juego_id", to: "juegos#destroy", as: "juegos/destroy"

  get "/juegos/:juego_id/:user_dueno_id", to: "juegos#mostrar", as: "juegos/mostrar"

  # RUTAS USUARIO
  get "/users/:user_id/inventario", to:'users#show_productos', as: "users/show_productos"
  get "/users/:user_id/perfil", to: "users#show", as: "users/show"
  delete "users/:user_id/delete", to: "users#destroy", as: "users/destroy"
  
  # RUTAS SOLICITUDES
  get "/users/:user_id/solicitudes_pendientes", to: "solicituds#index_pendientes", as: "solicituds/index_pendientes"  
  get "users/:user_id/solicitudes", to: "solicituds#index_ar", as: "solicituds/index_ar"
  get "/solicitudes/:solicitud_id", to: "solicituds#show", as: "solicituds/show"
  get "/producto_solicitado/:producto_solicitado_id/:solicitable_type/solicitud/new", to: "solicituds#new_solicitado", 
  as: "solicituds/new_solicitado"

  get "/producto_solicitado/:producto_solicitado_id/:solicitable_type/:producto_ofrecido_id/:ofreciable_type/solicitud/new", 
      to: "solicituds#new_ofrecido", as: "solicituds/new_ofrecido"
      
  post "/solicituds/", to: "solicituds#create", as: "solicituds/create"
  get "/user/:user_id/solicitudes/:solicitud_id/edit", to: "solicituds#edit", as: "solicituds/edit"
  patch "/user/:user_id/solicitudes/:solicitud_id", to: "solicituds#update_ar", as: "solicituds/update_ar"
  delete "/user/:user_id/solicitudes/:solicitud_id", to: "solicituds#destroy", as: "solicituds/destroy"

  get "user/:user_id/solicitudes/:solicitud_id/estado", to: "solicituds#update_estado", as: "solicituds/update_estado"
  get "error/solicitud/:tipo_solicitado", to: "solicituds#error", as: "solicituds/error"
  patch "/user/:user_id/solicitudes/:solicitud_id/update", to: "solicituds#update_solicitud", 
as: "solicituds/update_solicitud"

  # RUTAS RESEÑAS
  get "/user/:user_creador_id/:user_receptor_id/resena/new", to: "resenas#new", as: "resenas/new"
  post "/user/:user_creador_id/:user_receptor_id/resena", to: "resenas#create", as: "resenas/create"
  get "/user/:user_creador_id/:user_receptor_id/resena/:resena_id", to: "resenas#show", as: "resenas/show"
  get "user/:user_id/resenas", to: "resenas#index", as: "resenas/index"
  get "/user/:user_creador_id/resenas/:resena_id/edit", to: "resenas#edit", as: "resenas/edit"
  patch "/resenas/:resena_id", to: "resenas#update", as: "resenas/update"
  delete "/resenas/:resena_id/destroy", to: "resenas#destroy", as: "resenas/destroy" 
end
