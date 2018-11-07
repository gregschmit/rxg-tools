# Day Trial Usage Plan

## The Idea

The goal of a day trial usage plan is to permit a certain amount of data usage for 24 hours. If the user uses more than their quota then the rXg should not permit the user to purchase the free plan until the 24 hour period has elapsed.

We will accomplish this by adding a usage plan which is free and which has a lifetime of 1 day (i.e., 24 hours). We will also add some portal controller code to perform the backend logic.

## The Implementation

In your portal, edit the `<portalname>_controller.rb` file and add the following code to the class `Portal::<portalname>Controller`:

```rb
  def daytrial_plan_purchasable(account, usage_plan)
    # for this account, determine if the plan is purchasable. This is not the
    #  case if the usage plan is free and the usage expiration of the account
    #  is in the future.
    if usage_plan.price == 0 && account.usage_expiration.future?
      return false
    end
    return true
  end

  def daytrial_check_plans(account, usage_plans)
    # for this account, iterate over the usage plans and remove unpurchasable.
    usage_plans.each do |p|
      if not daytrial_plan_purchasable(account, p)
        usage_plans.delete p
      end
    end
    return usage_plans
  end

  def usage_plan_list
    daytrial_check_plans(@account, @usage_plans)
  end

  def usage_plan_charge
    @usage_plan = UsagePlan.find(params[:id])
    if @account && !daytrial_plan_purchasable(@account, @usage_plan)
       flash[:notice] = :no_current_account
       redirect_to_back_or_index
       return
    end
    super
  end
```
