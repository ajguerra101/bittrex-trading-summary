# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trade do
    user
    coin
    amount_bought 100
    price_bought 1
    amount_sold 90
    price_sold 1.8
    amount_left 10
    amount_value 0.2
    profit 0.8
    percent "9.99"
    average_price_bought 0.01
    average_price_sold 0.02
    round_number nil
    current_round_number 1
    rounds [1]

    after(:create) do |trade|
      round = Round.where(coin: trade.coin, user: trade.user, round_number: 1).first
      create_list(:sell_order, 3, user: trade.user, coin: trade.coin, trade: trade, round: round)
      create_list(:buy_order, 4, user: trade.user, coin: trade.coin, trade: trade, round: round)
      create_list(:buy_order, 1, :manual, user: trade.user, coin: trade.coin, trade: trade, round: round)
      trade.user.update_attributes(btc_invested: 1, btc_received: 1.8, btc_investing: 0.2)
    end

  end
end