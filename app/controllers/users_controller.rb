class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users
  def index
    @users = User.all

    %i(id name email phone cpf).each do |field|
      if params[field].present?
        @users = @users.where(field => params[field]) 
      end
    end

  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(name: params[:name], email: params[:email], phone: params[:phone], cpf: params[:cpf])
    if @user.save
      flash[:success] = 'Usuário cadastrado com sucesso!'
      redirect_to root_path 
    else
      flash[:danger] = 'Falha ao cadastrar usuário! Revise os dados e tente novamente.'
      redirect_to root_path 
    end
  end

  # PATCH /users/id
  def update
    if @user.update(name: params[:user][:name], email: params[:user][:email], phone: params[:user][:phone])
      flash[:success] = 'Usuário atualizado com sucesso!'
      redirect_to root_path 
    else
      flash[:danger] = 'Falha ao atualizar usuário! Revise os dados e tente novamente.'
      redirect_to root_path 
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy!
      flash[:success] = 'Usuário deletado com sucesso!'
      redirect_to root_path 
    else
      flash[:danger] = 'Falha ao deletar usuário!'
      redirect_to root_path 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :phone, :cpf)
    end
end
