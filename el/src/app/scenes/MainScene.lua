local ClockWidget = import("..widget.ClockWidget")
local TurnacleWidget = import("..widget.TurnacleWidget")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newColorLayer(cc.c4b(100, 100, 100, 255)):addTo(self)
    ClockWidget.new():addTo(self):center():setScale(0.5):setPosition({x=display.right-55, y=display.top-55})
    TurnacleWidget.new():addTo(self):center()
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
