class VM

  def initialize()
    @sales     = 0
    @all_coin  = 0
    @juice_arr = {'cola' => 120, 'cola_stock' => 5}   #2-1 초기상태
    @juice_list = ["cola"]
  end

  def coin_input(coin)
    #0-0 투입
    if coin == 10 or coin == 50 or coin == 100 or coin == 500 or coin == 1000
      @all_coin += coin
    else
      #1-0 상정 외 돈 반환 함수 호출
      rt_coin(coin)
    end
  end

  #0-2 총금 확인
  def now_coin()
    return @all_coin
  end

  #0-3 환불
  def refund()
    all_coin_save = @all_coin
    @all_coin = 0

    #거슬러 주는 기능
    printf('Refund : ',all_coin_save)
    return all_coin_save;
  end

  #1-0 상정 외 돈 반환 기능
  def rt_coin(coin)
    print("Please check the money. - ",coin)
    return coin
  end

  #2-0 1종류 격납가능
  def stock_input(name, price, stock)
    @juice_arr[name] = price
    @juice_arr[name+"_stock"] = stock
    @juice_list << name
  end

  #2-2 주스 정보 획득
  def get_stock()
    return @juice_arr
  end

  #3-0 콜라 구입 할 수 있는지 여부 취득
  def check_cola()
    if check("cola")
      return true
    else
      return false
    end
  end

  #3-1, 3-2 구입 조작 = 확인, 구입, 매상, 재고, 총액수
  def purchase(name)
    if check(name)
      stock = @juice_arr[name+"_stock"]
      price = @juice_arr[name]

      @all_coin -= price
      @sales = price
      @juice_arr[name+"_stock"] -= 1

      #5-0 구매후 반환
      refund()
    else
      #Nothing
    end
  end

  #3-3 현재 매상 금액 취득
  def get_sales()
    return @sales
  end

  #4-0, 4-1 레드불, 물 추가
  def add_juice()
    stock_input("redbull", 200, 5)
    stock_input("water", 100, 5)
  end

  #4-2 투입금액, 재고면 구입 가능 목록
  def check_Purchase_list()
    ture_Purchase_list = Array.new()

    for index in 0 ... @juice_list.size
      if check(@juice_list[index])
        ture_Purchase_list << @juice_list[index]
      end
    end

    return ture_Purchase_list
  end

  #살수 있는지 확인
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

c1 = VM.new()

p c1.check_Purchase_list()
p c1.add_juice()
p c1.get_stock()
p c1.coin_input(500)
p c1.now_coin()
p c1.check_Purchase_list()
p c1.purchase("cola")
p c1.now_coin()
p c1.get_sales()
p c1.get_stock()
