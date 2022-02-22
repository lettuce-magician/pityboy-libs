return function(super)
    local cls = {}
    cls.__index = cls
    cls.__super = super
    cls.__tostring = function(self)
        return self.__type or "class: "..tostring(self)
    end

    if cls.__super then
        for Key, Value in pairs(cls.__super) do
            if not cls[Key] then
                 cls[Key] = Value
            end
         end
    end

    function cls:init()
    end

    function cls.new(...)
        local self = setmetatable({}, cls)
        self:init(...)
        return self
    end

    return cls
end