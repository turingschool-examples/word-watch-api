class Api::V1::WordsController < ApplicationController
  def create
    word = Word.new(word_params)
    if word.save
      render json: { message: "#{word.value} added!" }, status: 201
    else
      render json: { message: word.errors.full_messages.join(", ") }, status: 422
    end
  end

  private

  def word_params
    params.require(:word).permit(:value)
  end
end

