local class = require('src.Class')

local Event = class()
Event.__type = "Event"
Event.Callbacks = {}

function Event:Fire(...)
    for _, Callback in ipairs(self.Callbacks) do
        coroutine.resume(coroutine.create(Callback), ...)
    end
end

function Event:Connect(fn)
    table.insert(self.Callbacks, fn)
end

function Event:Disconnect(i)
    table.remove(self.Callbacks, i or #self.Callbacks)
end

return Event