module Index_info
  def index
    @solicitudes = Solicitud.all
    info_solicitudes = []
    for solicitud in @solicitudes do
      id_solicitud = solicitud.id
      estado_solicitud = solicitud.estado
      tipo_solicitado = solicitud.solicitable_type
      if tipo_solicitado == "Libro"
        prod_solicitado = Libro.find(solicitud.solicitable_id)
        nombre_solicitado = prod_solicitado.titulo
      else
        prod_solicitado = Juego.find(solicitud.solicitable_id)
        nombre_solicitado = prod_solicitado.nombre
      end
      user_prod_solicitado = prod_solicitado.user

      tipo_ofrecido = solicitud.ofreciable_type
      if tipo_ofrecido == "Libro"
        prod_ofrecido = Libro.find(solicitud.ofreciable_id)
        nombre_ofrecido = prod_ofrecido.titulo
      else
        prod_ofrecido = Juego.find(solicitud.ofreciable_id)
        nombre_ofrecido = prod_ofrecido.nombre
      end
      user_prod_ofrecido = prod_ofrecido.user

      info_solicitud = [estado_solicitud, nombre_solicitado, user_prod_solicitado, nombre_ofrecido, user_prod_ofrecido, 
                        id_solicitud]
      info_solicitudes.append(info_solicitud)
    end
    return info_solicitudes
  end
end

class SolicitudsController < ApplicationController

  include Index_info
  # GET users/:user_id/solicitudes_pendientes: 
  def index_pendientes
    @user = User.find(params[:user_id])
    @info_solicitudes_realizadas = []
    @info_solicitudes_recibidas = []
    @info_solicitudes = index()

    for info_solicitud in @info_solicitudes do
      if info_solicitud[0] == "pendiente" 
        if info_solicitud[2] == @user
          @info_solicitudes_recibidas.append(info_solicitud)
        end
        if info_solicitud[4] == @user 
          @info_solicitudes_realizadas.append(info_solicitud)
        end
      else
        next
      end
    end
  end

  # GET users/:user_id/solicitudes
  def index_ar
    @user = User.find(params[:user_id])
    @info_solicitudes = index()
    @solicitudes_aceptadas_recibidas = []
    @solicitudes_aceptadas_realizadas = []
    @solicitudes_rechazadas_recibidas = []
    @solicitudes_rechazadas_realizadas = []
  
    for info_solicitud in @info_solicitudes do
      if info_solicitud[0] == "Aceptada"
        if info_solicitud[2] == @user 
          @solicitudes_aceptadas_recibidas.append(info_solicitud)
        elsif info_solicitud[4] == @user
          @solicitudes_aceptadas_realizadas.append(info_solicitud)
        end
      elsif info_solicitud[0] == "Rechazada"
        if info_solicitud[2] == @user 
          @solicitudes_rechazadas_recibidas.append(info_solicitud)
        elsif info_solicitud[4] == @user
          @solicitudes_rechazadas_realizadas.append(info_solicitud)
        end
      end
    end
  end
 
 # GET solicituds/:id
  def show
    @solicitud = Solicitud.find(params[:solicitud_id])
    @tipo_solicitado = @solicitud.solicitable_type
  
    if @tipo_solicitado == "Libro"
      @producto_solicitado = Libro.find(@solicitud.solicitable_id)
      @nombre_solicitado = @producto_solicitado.titulo
    else
      @producto_solicitado = Juego.find(@solicitud.solicitable_id)
      @nombre_solicitado = @producto_solicitado.nombre
    end

    @user_solicitado = @producto_solicitado.user.nombre
    @tipo_ofrecido = @solicitud.ofreciable_type
    
    if @tipo_ofrecido == "Libro"
      @producto_ofrecido = Libro.find(@solicitud.ofreciable_id)
      @nombre_ofrecido = @producto_ofrecido.titulo
    else
      @producto_ofrecido = Juego.find(@solicitud.ofreciable_id)
      @nombre_ofrecido = @producto_ofrecido.nombre
    end
  end
   


 # GET "/producto_solicitado/:producto_solicitado_id/:tipo_solicitado/solicitud/new"
  def new_solicitado
    @user = current_user
    libros_propios = @user.libros
    juegos_propios = @user.juegos
    @libros_propios = libros_propios.where("disponibilidad ='Disponible'")
    @juegos_propios = juegos_propios.where("disponibilidad = 'Disponible'")
    @solicitable_id = params[:producto_solicitado_id]
    @solicitable_type = params[:solicitable_type]
  end

  # GET "/solicitud/:producto_solicitado_id/:tipo_solicitado/:producto_ofrecido_id/:tipo_ofrecido
  def new_ofrecido
    @user = current_user
    @libros_propios = @user.libros
    @juegos_propios = @user.juegos
    @solicitable_id = params[:producto_solicitado_id]
    @solicitable_type = params[:solicitable_type]
    @ofreciable_id = params[:producto_ofrecido_id]
    @ofreciable_type = params[:ofreciable_type]
    
    if @ofreciable_type == "1"
      @ofreciable_type = "Libro"
    elsif @ofreciable_type == "2"
      @ofreciable_type = "Juego"
    end

    if @solicitable_type == "1"
      @solicitable_type = "Libro"
      @prod_solicitado = Libro.find(@solicitable_id)
    elsif @solicitable_type == "2"
      @solicitable_type = "Juego"
      @prod_solicitado = Juego.find(@solicitable_id)
    end
    
    if @prod_solicitado.user == @user
      redirect_to action: "error", tipo_solicitado: @solicitable_type
    else
      @solicitud = Solicitud.new  
    end
  end
  
  # GET "error/solicitud/:tipo_solicitado"
  def error
    @tipo_solicitado = params[:tipo_solicitado]
    if @tipo_solicitado == "Libro"
      @path = libros_index_path(current_user.id)
    else
      @path = juegos_index_path(current_user.id)
    end
  end

  # POST "/solicituds"
  def create
    @user = current_user
    @libros_propios = @user.libros
    @juegos_propios = @user.juegos
    @solicitable_id = params[:producto_solicitado_id]
    @solicitable_type = params[:solicitable_type]
    @ofreciable_id = params[:producto_ofrecido_id]
    @ofreciable_type = params[:ofreciable_type]
    @solicitud = Solicitud.new(solicitud_params)
    if @solicitud.save
      redirect_to action: "show", solicitud_id: @solicitud.id
    else
      render :new_ofrecido, status: :unprocessable_entity
    end
  end

  # GET
  def edit
    @solicitud = Solicitud.find(params[:solicitud_id])
    @user = current_user
    libros = @user.libros
    juegos = @user.juegos
    @libros_usuario = libros.where("disponibilidad ='Disponible'")
    @juegos_usuario = juegos.where("disponibilidad = 'Disponible'")
  end


  # PATCH user/:user_id/solicitudes/:solicitud_id
  def update_ar
    @solicitud = Solicitud.find(params[:solicitud_id])
    if @solicitud.update(solicitud_params)
      redirect_to action: "update_estado", solicitud_id: @solicitud.id 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # GET 
  def update_estado
    @solicitud = Solicitud.find(params[:solicitud_id])
    @prod_solicitado = @solicitud.solicitable
    @prod_ofrecido = @solicitud.ofreciable
    if @solicitud.estado == "Aceptada"
      @prod_solicitado.update_column(:disponibilidad, "En Intercambio")
      @prod_ofrecido.update_column(:disponibilidad, "En Intercambio")
    end
    redirect_to action: "index_ar"
  end

  # PATCH user/:user_id/solicitudes/:solicitud_id/update
  def update_solicitud
    @solicitud = Solicitud.find(params[:solicitud_id])
    if @solicitud.update(solicitud_params)
      redirect_to action: "show", solicitud_id: @solicitud.id 
    end
  end

  # DELETE /solicitudes/:id
  def destroy
    @solicitud = Solicitud.find(params[:solicitud_id])
    @solicitud.destroy
    redirect_to action: "index_pendientes", status: :see_other
  end

  private
  def solicitud_params
    params.require(:solicitud).permit(:estado, :solicitable_type, :solicitable_id, :ofreciable_type, :ofreciable_id)
  end

end
