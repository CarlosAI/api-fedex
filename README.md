# FedEx API Wrapper

This project is a simple API that wraps around the FedEx API. It provides a way to request shipping rate information for a given delivery. This API uses the [fedex-api gem](https://github.com/CarlosAI/fedex-api) to communicate with the FedEx API.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Before you begin, ensure you have installed:

* Ruby 2.7.0 or later
* Rails 6.1.0 or later

### Installing

Firstly, clone this repository to your local machine:

```bash
git clone https://github.com/CarlosAI/api-fedex
```

Then, navigate to the project directory and install the required gems:

```bash
cd fedex-api
bundle install
```

Finally, start the Rails server:

```bash
rails server
```

The application should now be running at http://localhost:3000.

### Usage

The API exposes a single endpoint, /rates, which accepts a GET request with the following parameters:

FedEx credentials (fedex_key, fedex_password, fedex_account_number, fedex_meter_number)

Addresses (address_from_zip, address_from_country, address_to_zip, address_to_country)

Parcel dimensions (mass_unit, weight, length, width, height, distance_unit)

Example request:
```bash
curl -X GET 'http://localhost:3000/rates?fedex_key=KEY&fedex_password=PASSWORD&fedex_account_number=ACCOUNT_NUMBER&fedex_meter_number=METER_NUMBER&address_from_zip=ZIP_FROM&address_from_country=COUNTRY_FROM&address_to_zip=ZIP_TO&address_to_country=COUNTRY_TO&mass_unit=MASS_UNIT&weight=WEIGHT&length=LENGTH&width=WIDTH&height=HEIGHT&distance_unit=DISTANCE_UNIT'
```

This will return a JSON object with the available shipping rates for the given parameters.

### Contributing
We welcome contributions to this project. Please feel free to open an issue or submit a pull request.

### License
This project is licensed under the MIT License. See the LICENSE.md file for details.