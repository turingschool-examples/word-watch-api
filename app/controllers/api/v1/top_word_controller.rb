class Api::V1::TopWordController < ApplicationController
  def show
    render json: { word: Word.top }
  end
end

