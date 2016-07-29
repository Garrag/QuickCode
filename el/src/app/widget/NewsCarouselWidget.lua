--卡片类
local News = class("News", function ()
	return display.newNode()
end)
function News:ctor(color)
	display.newRect(cc.rect(-50, -35, 100, 70),
        {fillColor = color, borderColor = color, borderWidth = 0}):addTo(self)
	display.newTTFLabel({text='卡片',color = cc.c3b(255, 255, 255),size=20, x=posx, y=posy}):addTo(self)
end




--卡片盒子类
local NewsCarouselWidget = class("NewsCarouselWidget", function()
    return display.newNode()
end)

function NewsCarouselWidget:ctor()
	self.vx = 0
	self.kapian = News.new(cc.c4f(1,0.5,0,1)):addTo(self)

    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
    self:scheduleUpdate()
end

function NewsCarouselWidget:tick(dt)
	self.vx = self.vx + 50*dt
	self.kapian:setRotation3D(cc.vec3(0,self.vx,0))
end


function NewsCarouselWidget:addFiche()
	
end


return NewsCarouselWidget