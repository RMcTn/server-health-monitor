class DemoController < ApplicationController
  @@count = 0

  def failing
    if @@count >= 5
      @@count = 0
      redirect_to root_url, status: 500
    else
      @@count += 1
      redirect_to root_url, status: 200
    end
  end
end
