class Api::V1::TopWordController < ApplicationController
  def show
    render json: { value: Word.top }
  end
end

