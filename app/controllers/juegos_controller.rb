class JuegosController < ApplicationController
    # GET /juegos  
  def index
    @juegos_disponibles = Juego.where(disponibilidad: "Disponible")
  end

  def index_sin_sesion
    @juegos_disponibles = Juego.where(disponibilidad: "Disponible")
  end

  def search
    if params[:nombre].present? && params[:estado].present?
      juegos_search = Juego.where(disponibilidad: "Disponible").where('nombre ilike ?', 
                                                                      "%#{params[:nombre]}%").where('estado ilike ?', "%#{params[:estado]}%")
      render(partial: "juegos_disponibles", locals:{juegos_disponibles: juegos_search})
    elsif params[:nombre].present? && params[:estado].blank?
      juegos_search = Juego.where(disponibilidad: "Disponible").where('nombre ilike ?', "%#{params[:nombre]}%")
      render(partial: "juegos_disponibles", locals:{juegos_disponibles: juegos_search})
    elsif params[:nombre].blank? && params[:estado].present?
      juegos_search = Juego.where(disponibilidad: "Disponible").where('estado ilike ?', "%#{params[:estado]}%")
      render(partial: "juegos_disponibles", locals:{juegos_disponibles: juegos_search})
    else
      redirect_to action: "index", status: :see_other
    end
  end

  # GET /user/:user_id/juegos/:juego_id
  def show 
    @juego = Juego.find(params[:juego_id])
  end

  # GET "/user/:user_id/juegos/new"
  def new  
    @juego = Juego.new
    render :new
  end

  # POST /user/:user_id/juegos
  def create
    @user = User.find(params[:user_id])
    @juego = Juego.new(juegos_params)
    @juego.user = @user
    if @juego.save
      redirect_to action: "show", juego_id: @juego.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /juegos/:id/edit
  def edit
    @juego = Juego.find(params[:juego_id])
  end

  # PATCH /juegos/:id
  def update
    @juego = Juego.find(params[:juego_id])
    if @juego.update(juegos_params)
      redirect_to action: "show", juego_id: @juego.id
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /juegos/:id
  def destroy
    @juego = Juego.find(params[:juego_id])
    @juego.destroy
    redirect_to action: "index", status: :see_other
  end

   # GET /juegos/:juego_id/:user_dueno_id
  def mostrar 
    @juego = Juego.find(params[:juego_id])
    @resenas_recibidas = Resena.where("usuario_receptor_id =?", params[:user_dueno_id])
  end


  private
  def juegos_params
    params.require(:juego).permit(:nombre, :tipo, :estado, :cant_jugadores, :descripcion, :imagen, :disponibilidad)
  end

end
