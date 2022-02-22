package.path = package.path..";../?.lua;../?;"
local class = require('src.Class')
local Event = require('src.Event')

local Account = class()
Account.__type = "Account"
Account.balance = 100
Account.inDebt = false

Account.Changed = Event.new()
Account.Debt = Event.new()

function Account:debtCheck()
    if self.balance < 0 then
        self.inDebt = true
        Account.Debt:Fire()
    else
        self.inDebt = false
    end
end

function Account:init(balance)
    self.balance = balance
end

function Account:withdraw(amount)
    Account.Changed:Fire(self.balance, self.balance - amount)
    self.balance = self.balance - amount
    self:debtCheck()
end

function Account:deposit(amount)
    Account.Changed:Fire(self.balance, self.balance + amount)
    self.balance = self.balance + amount
    self:debtCheck()
end

local JoeAcc = Account.new(0)

JoeAcc.Changed:Connect(function (old, new)
    print("Old Balance: "..old.."\n".."New Balance: "..new)
end)

JoeAcc.Debt:Connect(function()
    print("In Debt!")
end)

JoeAcc:deposit(100)
JoeAcc:withdraw(150)
JoeAcc:deposit(50)