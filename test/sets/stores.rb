module Contexts
  module Stores 

    def create_stores
      @panda = FactoryBot.create(:store)
      @walmart = FactoryBot.create(:store, name: "Walmart", active: false)
      @target = FactoryBot.create(:store, name: "Target", phone: "5731231235")
      @trader = FactoryBot.create(:store, name: "Trader Joes", state: "Ohio")
      
    end 

    def destroy_stores
      @panda.destroy
      @target.destroy
      @trader.destroy
      @walmart.destroy
    end


  end 
end  