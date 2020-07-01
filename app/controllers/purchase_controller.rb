class PurchaseController < ApplicationController
  require 'payjp'
  layout 'no-header',only: [:done,:show]
  before_action :authenticate_user!
  before_action :set_item
  before_action :not_access_item

  def pay
    card = CreditCard.find_by(user_id: current_user.id)
    Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
    Payjp::Charge.create(
    :amount => @item.price,
    :customer => card.customer_id,
    :currency => 'jpy',
  )
  redirect_to action: 'done'
  end
  def show
    card = CreditCard.find_by(user_id: current_user.id)
    
    if card.blank?
      redirect_to controller: "credit_cards", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
      
      customer = Payjp::Customer.retrieve(card.customer_id)
      
      @default_card_information = customer.cards.retrieve(card.card_id)
      @items = Item.includes(:images).order('created_at DESC')
    end
  end
  def done
    @item_purchaser= Item.find(params[:id])
    @item_purchaser.update(purchaser_id: current_user.id)
  end
  private
  def set_item
    @item = Item.find(params[:id])
  end
  def not_access_item
    if @item.user_id == current_user.id || @item.purchaser_id
      redirect_to root_url
    end
  end
end