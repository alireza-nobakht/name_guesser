# frozen_string_literal: true

class GuessesController < ApplicationController
  def show
    name = name_param
    render json: GuessCountry.new(name).call
  rescue ActionController::ParameterMissing => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def name_param
    params.require(:name)
  end
end
