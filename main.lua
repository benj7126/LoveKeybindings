local SCM = require "ShortcutHandler"

function love.load()
    SCM.load()
end

function love.textinput(t)
    SCM.textinput(t)
end

function love.draw()
    SCM.draw()
end

function love.keypressed(key)
    SCM.keypressed(key)
end

function love.quit()
    SCM.savePref()
end