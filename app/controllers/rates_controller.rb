class RatesController < ApplicationController
  before_action :set_rate, only: %i[ show update destroy ]
  before_action :validate_params

  # GET /rates
  def index
    
    credentials = Rate.get_credentials(params)
    rate_params = Rate.get_address(params)

    response = Fedex::Rates.get(credentials, rate_params)

    if response[:code].to_i == 200 && response[:body]["RateReply"].present? && response[:body]["RateReply"]["RateReplyDetails"].present?
      res = Rate.transform_rates(response[:body])
      render json: res, status: :ok
    else
      render json: response[:body], status: response[:code]
    end
  end

  # GET /rates/1
  def show
    render json: @rate.errors, status: :unprocessable_entity
  end

  # POST /rates
  def create
    render json: @rate.errors, status: :unprocessable_entity
  end

  # PATCH/PUT /rates/1
  def update
    render json: @rate.errors, status: :unprocessable_entity
  end

  # DELETE /rates/1
  def destroy
    render json: @rate.errors, status: :unprocessable_entity
  end

  private

    def validate_params
      # Validate fedex_values
      fedex_keys = %w[fedex_key fedex_password fedex_account_number fedex_meter_number]
      unless fedex_keys.all? { |key| params[key].present? }
        render json: { error: "Missing FedEx credentials" }, status: :unprocessable_entity and return
      end

      # Validate address zip and country
      address_keys = %w[address_from_zip address_from_country address_to_zip address_to_country]
      unless address_keys.all? { |key| params[key].present? }
        render json: { error: "Missing address zip or country" }, status: :unprocessable_entity and return
      end

      # Validate parcel dimensions
      parcel_keys = %w[mass_unit weight length width height distance_unit]
      unless parcel_keys.all? { |key| params[key].present? }
        render json: { error: "Missing parcel dimensions" }, status: :unprocessable_entity and return
      end
    end

    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_params
      params.permit(
        :fedex_key, 
        :fedex_password, 
        :fedex_account_number, 
        :fedex_meter_number,
        :address_from_street_name, 
        :address_from_city, 
        :address_from_state_or_province_code, 
        :address_from_zip, 
        :address_from_country,
        :address_to_street_name, 
        :address_to_city, 
        :address_to_state_or_province_code, 
        :address_to_zip, 
        :address_to_country,
        :mass_unit, 
        :weight, 
        :length, 
        :width, 
        :height, 
        :distance_unit
      )
    end
end
