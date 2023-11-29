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
      juegos = user.juegos
      for juego in juegos do
        if juego.disponibilidad == "Disponible"
          juegos.destroy
        end
      end
      libros = user.libros
      for libro in libros do
        if libro.disponibilidad == "Disponible"
          libro.destroy
        end
      end
      user.destroy
      redirect_to "/"
    end
  end
end