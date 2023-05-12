class Rate < ApplicationRecord

	def self.transform_rates(response)
		all_rates = []
		response["RateReply"]["RateReplyDetails"].each do |rates|
			rates["RatedShipmentDetails"].each do |rate_detail|
				current_rate = {
					"price"=> rate_detail["ShipmentRateDetail"]["TotalNetCharge"]["Amount"],
					"currency"=> rate_detail["ShipmentRateDetail"]["TotalNetCharge"]["Currency"],
					"service_level"=> {
						"name"=> rates["ServiceType"],
						"token"=> rate_detail["ShipmentRateDetail"]["RateType"]
					}
				}
				all_rates.push(current_rate)
			end
		end
		return all_rates
	end

	def self.get_credentials(params)
		{
		  "fedex_key" => params["fedex_key"],
		  "fedex_password" => params["fedex_password"],
		  "fedex_account_number" => params["fedex_account_number"],
		  "fedex_meter_number" => params["fedex_meter_number"]
		}
	end

	def self.get_address(params)
		{
		  "address_from" => {
		    "street_name" => params.fetch("address_from_street_name",""),
		    "city" => params.fetch("address_from_city",""),
		    "state_or_province_code" => params.fetch("address_from_state_or_province_code",""),
		    "zip" => params["address_from_zip"],
		    "country" => params["address_from_country"]
		  },
		  "address_to" => {
		    "street_name" => params.fetch("address_to_street_name",""),
		    "city" => params.fetch("address_to_city",""),
		    "state_or_province_code" => params.fetch("address_to_state_or_province_code",""),
		    "zip" => params["address_to_zip"],
		    "country" => params["address_to_country"]
		  },
		  "parcel" => {
		    "mass_unit" => params["mass_unit"],
		    "weight" => params["weight"],
		    "length" => params["length"],
		    "width" => params["width"],
		    "height" => params["height"],
		    "distance_unit" => params["distance_unit"]
		  }
		}
	end
end
