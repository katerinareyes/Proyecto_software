class ResenasController < ApplicationController
  
  # GET /user/:user_id/resenas
  def index
    @resenas_creadas = Resena.where("usuario_creador_id =?", current_user.id)
    @resenas_recibidas = Resena.where("usuario_receptor_id =?", current_user.id)
  end

  # GET /user/:user_creador_id/:user_receptor_id/resenas/:resena_id
  def show
    @resena = Resena.find(params[:resena_id])
    @user_receptor = User.find(params[:user_receptor_id])
  end

  # GET /user/:user_creador_id/user_receptor_id/resena/new
  def new
    @resena = Resena.new
    @user_receptor = User.find(params[:user_receptor_id])
  end

  # POST /user/:user_creador_id/:user_receptor_id/resena
  def create
    @resena = Resena.new(resenas_params)
    @user_receptor = User.find(params[:user_receptor_id])
    @user_creador = User.find(params[:user_creador_id])
    @resena.usuario_creador_id = @user_creador.id
    @resena.usuario_receptor_id = @user_receptor.id
    if @resena.save
      redirect_to action: "show", resena_id: @resena.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /user/:user_creador_id/resenas/:resena_id/edit
  def edit
    @resena = Resena.find(params[:resena_id])
  end

  # PATCH /resenas/:resena_id
  def update
    @resena = Resena.find(params[:resena_id])
    if @resena.update(resenas_params)
      redirect_to action: "show", resena_id: @resena.id , user_creador_id: current_user.id, 
                  user_receptor_id: @resena.usuario_receptor_id
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /resenas/:resena_id
  def destroy
    @resena = Resena.find(params[:resena_id])
    @resena.destroy
    redirect_to action: "index", user_id: current_user.id, status: :see_other
  end

  private
  def resenas_params
    params.require(:resena).permit(:calificacion, :comentario, :usuario_creador_id, :usuario_receptor_id)
  end
end
