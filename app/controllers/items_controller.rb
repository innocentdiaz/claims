class ItemsController < ApplicationController
  def index; end

  def create
    item = Item.new(params.expect(item: [ :title, :description ]))
    if item.save
      redirect_to root_path, notice: "Reported."
    else
      redirect_to root_path, alert: item.errors.full_messages.to_sentence
    end
  end
end
