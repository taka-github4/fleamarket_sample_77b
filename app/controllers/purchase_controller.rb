class PurchaseController < ApplicationController
  require 'payjp'

  def index
    @items = Item.includes(:images).order('created_at DESC')
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

  def pay
    @item = Item.find(params[:id])
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
    @item = Item.find(params[:id])
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
    @item = Item.find(params[:id])
  end

end
