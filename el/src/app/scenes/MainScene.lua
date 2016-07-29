local ClockWidget = import("..widget.ClockWidget")
local TurnacleWidget = import("..widget.TurnacleWidget")
local NewsCarouselWidget = import("..widget.NewsCarouselWidget")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newColorLayer(cc.c4b(100, 100, 100, 255)):addTo(self)
    
    ClockWidget.new():addTo(self):center():setScale(0.5):setPosition({x=display.right-55, y=display.top-55})
    TurnacleWidget.new():addTo(self):center():setScale(0.5):setPosition({x=display.left+55, y=display.top-55})
    NewsCarouselWidget.new():addTo(self):setPosition({x=display.cx, y=display.cy})

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
