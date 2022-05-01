local SCM = require "ShortcutHandler"

function love.load()
    SCM.load()
end

function love.textinput(t)
    SCM.textinput(t)
end

function love.draw(t)
    SCM.draw(t)
end

function love.keypressed(t)
    SCM.keypressed(t)
end

function love.quit()
    SCM.savePref()
end