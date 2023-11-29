class LibrosController < ApplicationController
    # GET /libros  
  def index
    @libros_disponibles = Libro.where(disponibilidad: "Disponible")
  end

  def index_sin_sesion
    @libros_disponibles = Libro.where(disponibilidad: "Disponible")
  end

  def search
    if params[:titulo].present? && params[:estado].present?
      libros_search = Libro.where(disponibilidad: "Disponible").where('titulo ilike ?', 
                                                                      "%#{params[:titulo]}%").where('estado ilike ?', "%#{params[:estado]}%")
      render(partial: "libros_disponibles", locals:{libros_disponibles: libros_search})
    elsif params[:titulo].present? && params[:estado].blank?
      libros_search = Libro.where(disponibilidad: "Disponible").where('titulo ilike ?', "%#{params[:titulo]}%")
      render(partial: "libros_disponibles", locals:{libros_disponibles: libros_search})
    elsif params[:titulo].blank? && params[:estado].present?
      libros_search = Libro.where(disponibilidad: "Disponible").where('estado ilike ?', "%#{params[:estado]}%")
      render(partial: "libros_disponibles", locals:{libros_disponibles: libros_search})
    else
      redirect_to action: "index", status: :see_other
    end
  end 

  # GET /users/:user_id/libros/:libro_id
  def show 
    @libro = Libro.find(params[:libro_id])
  end

  # GET "/user/:user_id/libros/new"
  def new  
    @libro = Libro.new
    render :new
  end

  # POST /user/:user_id/libros
  def create
    @user = User.find(params[:user_id])
    @libro = Libro.new(libros_params)
    @libro.user = @user
    if @libro.save
      redirect_to action: "show", libro_id: @libro.id
      
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /libros/:id/edit
  def edit
    @libro = Libro.find(params[:libro_id])
  end

  # PATCH user/:user_id/libros/:libro_id
  def update
    @libro = Libro.find(params[:libro_id])
    if @libro.update(libros_params)
      redirect_to action: "show", libro_id: @libro.id
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /libros/:id
  def destroy
    @libro = Libro.find(params[:libro_id])
    @libro.destroy
    redirect_to action: "index", status: :see_other
  end

   # GET /libros/:libro_id/:user_dueno_id
  def mostrar 
    @libro = Libro.find(params[:libro_id])
    @resenas_recibidas = Resena.where("usuario_receptor_id =?", params[:user_dueno_id])
  end

  private
  def libros_params
    params.require(:libro).permit(:titulo, :autor, :estado, :paginas, :edicion, :editorial, :tapa, :descripcion, 
                                  :imagen, :disponibilidad)
  end
    

end
