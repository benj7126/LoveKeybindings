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
            if love.keyboard.isDown("tab") then
                if self.sortedList[1] then
                    local str = self.sortedList[1][1] or self.sortedList[1]
                    self.handler.keybindTxt = str
                end
            end
            
            local yOffset = 5
            yOffset = math.min(yOffset, #self.sortedList)
            yOffset = yOffset*20+20

            local h, w = self.handler.h, self.handler.w

            for i = yOffset, 1, -1 do
                if self.sortedList[i] then
                    love.graphics.setColor(self.sortedList[i][2] or self.handler.colors["GhostTextColor2"])
                    if type(self.sortedList[i]) == "string" then
                        love.graphics.printf(self.sortedList[i], 2, h-yOffset+i*20-18, w, "left")
                    else
                        love.graphics.printf(self.sortedList[i][1], 2, h-yOffset+i*20-18, w, "left")
                    end
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
    for _, obj in pairs(self.listToPass) do
        local str = obj[1] or obj
        if string.match(string.lower(str), string.lower(text)) then
            table.insert(self.sortedList, obj)
        end
    end
end

function Dropdown:contains(text)
    self.sortedList = {}
    for _, obj in pairs(self.listToPass) do
        local str = obj[1] or obj
        if string.lower(str) == string.lower(text) then
            return true
        end
    end
    return false
end


return Dropdown