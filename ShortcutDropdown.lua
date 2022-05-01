local s = require "Shortcut"
local Dropdown = s:new()

Dropdown.listToPass = {}
Dropdown.sortedList = {}

local textbox = nil

function Dropdown:startText(StartText, Message, ignoreNextKey)
    if textbox == nil then
        textbox = self.handler.txtDraw
        self.handler.txtDraw = function ()
            self:sort(self.handler.keybindTxt)
            
            local yOffset = 5
            yOffset = math.min(yOffset, #self.sortedList)
            yOffset = yOffset*20+20

            local h, w = self.handler.h, self.handler.w
            love.graphics.setColor(self.handler.colors["BackgroundColor"])
            love.graphics.rectangle("fill", 0, h-yOffset, w, yOffset)

            for i = 1,yOffset do
                if self.sortedList[i] then
                    love.graphics.setColor(self.handler.colors["GhostTextColor2"])
                    love.graphics.printf(self.sortedList[i], 2, h-yOffset+i*20-18, w, "left")
                end
            end

            textbox()
            
            if self.handler.writingTo == nil then
                self.handler.txtDraw = textbox
                textbox = nil
            end
        end
    end
    
    self.handler.startTxt(self, StartText, Message, ignoreNextKey)
end

function Dropdown:sort(text)
    self.sortedList = {}
    for _, str in pairs(self.listToPass) do
        if string.sub(str, 1, #text) == text then
            table.insert(self.sortedList, str)
        end
    end
end

function Dropdown:contains(text)
    self.sortedList = {}
    for _, str in pairs(self.listToPass) do
        if str == text then
            return true
        end
    end
    return false
end


return Dropdown