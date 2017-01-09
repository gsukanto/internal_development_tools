class CardInfosController < ApplicationController
  include CardInfosHelper

  # GET /card_infos
  def index
  end

  # GET /show?cardNumber=
  def show
    @cardNumber = params[:cardNumber]
    @card_infos = PcmAccount.find_by_productcode(@cardNumber).try(:PcmCard)
  end

  # GET /cvv?card_uid=&exp_date=
  def cvv
    pcm_card = PcmCard.find(params[:id])
    cvv = get_cvv(request_cvv(pcm_card.id, pcm_card.expirydate))
    render json: { cvv: cvv }
  end
end
