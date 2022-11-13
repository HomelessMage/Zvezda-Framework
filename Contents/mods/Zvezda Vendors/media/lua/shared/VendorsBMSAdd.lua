if getActivatedMods():contains("BetterMoneySystem") then
    print ("MYMODID: BetterMoneySystem detected, updating money table to support MYMODNAME")
    if ( BMSATM and BMSATM.Money ) then 
        print ("MYMODID: BetterMoneySystem money table found, updating")
        local money = BMSATM.Money or {}
        money.Values = {}
        money.Values["Vendors.OneDollar"] = { v = 1 }
        money.Values["Vendors.TenDollar"] = { v = 10 }
        money.Values["Vendors.HundredDollar"] = { v = 100 }
        money.Values["Vendors.ThousandDollar"] = { v = 1000 }
    else
        print ("MYMODID: unable to find BetterMoneySystem money table!")
    end 
end