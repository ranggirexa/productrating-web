module FormatHelper

  def format_price(price)
    # TODO: Format the price. #done
    # - Display a dollar sign
    # - Display two decimal places
    number_to_currency(price, { unit: "$ ", delimiter: ".", separator: ",", precision: 2 })
  end

end
