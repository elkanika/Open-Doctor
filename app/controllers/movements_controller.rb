# frozen_string_literal: true

class MovementsController < ApplicationController
  before_action :set_expediente
  before_action :set_movement, only: [:edit, :update, :destroy]

  def create
    @movement = @expediente.movements.new(movement_params)
    @movement.user = current_user

    if @movement.save
      redirect_to @expediente, notice: "Movimiento registrado."
    else
      redirect_to @expediente, alert: @movement.errors.full_messages.join(", ")
    end
  end

  def edit; end

  def update
    if @movement.update(movement_params)
      redirect_to @expediente, notice: "Movimiento actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movement.destroy
    redirect_to @expediente, notice: "Movimiento eliminado."
  end

  private

  def set_expediente
    @expediente = Expediente.find(params[:expediente_id])
  end

  def set_movement
    @movement = @expediente.movements.find(params[:id])
  end

  def movement_params
    params.require(:movement).permit(:title, :description, :occurred_at, :movement_type)
  end
end
