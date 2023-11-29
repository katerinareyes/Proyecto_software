class UsersController < ApplicationController
# inventario
  def show_productos
    if current_user.nil? == false
      @user = current_user
      @libros_propios = @user.libros
      @juegos_propios = @user.juegos
    end
  end


# GET /user/:user_id
  def show
    if current_user.nil? == false
      @usuario = current_user
      @libros_publicados = @usuario.libros.count()
      @juegos_publicados = @usuario.juegos.count()
      if @usuario.rol == 0
        @rol = "Usuario"
      else
        @rol = "Administrador"
      end
    end
  end

  def destroy
    if current_user.nil? == false
      user = current_user
      solicitudes = Solicitud.all
      juegos = user.juegos
      for juego in juegos do
        for solicitud in solicitudes do
          if solicitud.solicitable_type == "Juego" && solicitud.solicitable_id == juego.id
            solicitud.destroy
          elsif solicitud.ofreciable_type == "Juego" && solicitud.ofreciable_id == juego.id
            solicitud.destroy
          end 
        end
        if juego.disponibilidad == "Disponible"
          juegos.destroy
        end
      end
      libros = user.libros
      for libro in libros do
        for solicitud in solicitudes do
          if solicitud.solicitable_type == "Libro" && solicitud.solicitable_id == libro.id
            solicitud.destroy
          elsif solicitud.ofreciable_type == "Libro" && solicitud.ofreciable_id == libro.id
            solicitud.destroy
          end 
        end

        if libro.disponibilidad == "Disponible"
          libro.destroy
        end
      end
      resenas_creadas = Resena.where("usuario_creador_id =?", current_user.id)
      resenas_recibidas = Resena.where("usuario_receptor_id =?", current_user.id)
      for resena in resenas_creadas do
        resena.destroy
      end
      for resena in resenas_recibidas do
        resena.destroy
      end
      user.destroy
      redirect_to "/"
    end
  end
end