# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    authorize Client
    @q = Client.ransack(params[:q])
    @q.sorts = "last_name asc" if @q.sorts.empty?
    @pagy, @clients = pagy(@q.result.includes(:expedientes), items: 15)
  end

  def show
    authorize @client
    @expedientes = @client.expedientes.includes(:assigned_to).order(updated_at: :desc)
  end

  def new
    @client = Client.new
    authorize @client
  end

  def create
    @client = Client.new(client_params)
    authorize @client

    if @client.save
      redirect_to @client, notice: "Cliente creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @client
  end

  def update
    authorize @client
    if @client.update(client_params)
      redirect_to @client, notice: "Cliente actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @client.destroy
      redirect_to clients_path, notice: "Cliente eliminado."
    else
      redirect_to @client, alert: @client.errors.full_messages.join(", ")
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:first_name, :last_name, :document_type, :document_number,
                                   :email, :phone, :address, :notes, documents: [])
  end
end
