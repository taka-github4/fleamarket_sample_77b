class PurchaseController < ApplicationController
  require 'payjp'

  def index
    @items = Item.includes(:images).order('created_at DESC')
    card = CreditCard.where(user_id: current_user.id).first
    索
    if card.blank?
      
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
      
      customer = Payjp::Customer.retrieve(card.customer_id)
      めインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
      @items = Item.includes(:images).order('created_at DESC')
    end
  end

  def pay
    @item = Item.find(params[:id])
    card = CreditCard.where(user_id: current_user.id).first
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
    @user = User.find(current_user.id)
    card = CreditCard.where(user_id: current_user.id).first
    
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