class CardInfosController < ApplicationController
  include CardInfosHelper

  # GET /card_infos
  def index
  end

  # GET /show?accountNumber=
  def show
    @accountNumber = params[:accountNumber]
    @card_infos = PcmAccount.find(@accountNumber).try(:PcmCard)
  end

  # GET /cvv?card_uid=&exp_date=
  def cvv
    if params[:id]
      pcm_card = PcmCard.find(params[:id]) || error_id_not_found
      cvv = get_cvv(request_cvv(pcm_card.id, pcm_card.expirydate))
      render json: { cvv: cvv }
    else
      error_id_not_found
    end
  end

  private
    def error_id_not_found
      render json: { error: 'Id not found.' }
    end
end
