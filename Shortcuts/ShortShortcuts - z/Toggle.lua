local json = require "dkjson"
local s = require "Shortcut"

local MyKey = s:new()

MyKey.key = "t"

local cuts = {}
local isToggled = true

function MyKey:onActivate()
    isToggled = not isToggled
end

function MyKey:setup()
    local func = self.handler.keypressed
    self.handler.keypressed = function (key)
        func(key)
        if isToggled and self.handler.curKeybind == nil and self.handler.writingTo == nil then
            if cuts[key] then
                self:tryRunKeybind(cuts[key])
            end
        end
    end
end

function MyKey:tryRunKeybind(keyCombo)
    local kurKeybind = self.handler.keybindings
    for Key in string.gmatch(keyCombo.." ", "(.-) ") do
        if kurKeybind[Key] then
            if kurKeybind[Key].keybindings then
                kurKeybind = kurKeybind[Key].keybindings
            else
                if kurKeybind[Key].onActivate then
                    kurKeybind[Key]:onActivate()
                    kurKeybind = self.handler.keybindings
                end
            end
        end
    end
end

function MyKey:getRelevant()
    return cuts
end

function MyKey:loadString(v)
    cuts = json.decode(v)
end

function MyKey:saveString()
    return json.encode(cuts)
end

return MyKey