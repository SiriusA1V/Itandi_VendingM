
#########################################################################
# PROJECT : Itandi_VendingMachine
# Data    : 2018-10-15
# Name    : Choe Yohan
#
# --- 関数整理 ---
# coin_input(coin)                 # お金の投入
# now_coin()                       # 投入金額の総計
# refund()                         # 払い戻し
# rt_coin(coin)                    # 想定外のもの払い戻し
# stock_input(name, price, stock)  # ジュース１種類格納
# get_stock()                      # ジュースの情報を取得
# check_cola()                     # コーラの購入できるか確認
# purchase(name)                   # 購入
# get_sales()                      # 売上金額を取得
# add_juice()                      # レッドブル, 水を追加
# check_Purchase_list()            # 購入可能なドリンクのリストを取得
# check(name)                      # 買えるのか確認
#
#########################################################################



class VM

  def initialize()
    @sales     = 0    # 売上金額
    @all_coin  = 0    # 投入金額
    @juice_arr = {'cola' => 120, 'cola_stock' => 5}   #2-1 初期状態
    @juice_list = ["cola"]
  end

  #0-0 お金の投入
  def coin_input(coin)
    if coin == 10 or coin == 50 or coin == 100 or coin == 500 or coin == 1000
      @all_coin += coin
    else
      #1-0 想定外のもの払い戻しの関数を呼ぶ
      rt_coin(coin)
    end
  end

  #0-2 投入金額の総計
  def now_coin()
    return @all_coin
  end

  #0-3 払い戻し
  def refund()
    all_coin_save = @all_coin
    @all_coin = 0

    printf('Refund : ',all_coin_save)
    return all_coin_save;
  end

  #1-0 想定外のもの払い戻し
  def rt_coin(coin)
    print("Please check the money. - ",coin)
    return coin
  end

  #2-0 ジュース１種類格納
  def stock_input(name, price, stock)
    @juice_arr[name] = price
    @juice_arr[name+"_stock"] = stock
    @juice_list << name
  end

  #2-2 ジュースの情報を取得
  def get_stock()
    return @juice_arr
  end

  #3-0 コーラの購入できるか確認
  def check_cola()
    if check("cola")
      return true
    else
      return false
    end
  end

  #3-1, 3-2 購入
  def purchase(name)
    if check(name)　　　　#　買えるのか確認した後購入作業実行
      stock = @juice_arr[name+"_stock"]
      price = @juice_arr[name]

      @all_coin -= price
      @sales = price
      @juice_arr[name+"_stock"] -= 1

      #5-0 購入後、払い戻し
      refund()
    else
      #Nothing
    end
  end

  #3-3 売上金額を取得
  def get_sales()
    return @sales
  end

  #4-0, 4-1 レッドブル, 水を追加
  def add_juice()
    stock_input("redbull", 200, 5)
    stock_input("water", 100, 5)
  end

  #4-2 購入可能なドリンクのリストを取得
  def check_Purchase_list()
    ture_Purchase_list = Array.new()

    for index in 0 ... @juice_list.size
      if check(@juice_list[index])    # 買えるのか確認した後リストに追加
        ture_Purchase_list << @juice_list[index]
      end
    end

    return ture_Purchase_list
  end

  #買えるのか確認
  def check(name)
    stock = @juice_arr[name+"_stock"]
    price = @juice_arr[name]

    if @all_coin >= price && stock > 0
      return true;
    else
      return false;
    end
  end

end
