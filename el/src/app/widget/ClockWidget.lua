local ClockWidget = class("ClockWidget", function()
    return display.newNode()
end)


function ClockWidget:ctor()
	local r = 100 -- 半径100
    self.vfen = 0
    self.vmiao = 0
    self.vshi = 0
    display.newSolidCircle(r, { x=0, y=0, color=cc.c4f(0, 0, 0, 1)}):addTo(self)
	self.miao = display.newDrawNode():drawSegment(cc.p(0,-10), cc.p(0,(r-5)), 1, cc.c4f(163/255, 95/255, 41/255, 1)):addTo(self) --秒
    self.fen = display.newDrawNode():drawSegment(cc.p(0,-5), cc.p(0,(r-30)), 2, cc.c4f(1, 1, 1, 1)):addTo(self) --分
    self.shi = display.newDrawNode():drawSegment(cc.p(0,-5), cc.p(0,(r-50)), 2, cc.c4f(1, 1, 1, 1)):addTo(self) --时
    display.newSolidCircle(1, {color=cc.c4f(0,0,0,1)}):addTo(self)
    for i=1,12,1 do
    	local angle = -(2*math.pi)/12*i + math.pi/2
    	-- 根据角度计算位置
    	local posx = math.cos(angle)*(r-25)
    	local posy = math.sin(angle)*(r-25)
    	display.newTTFLabel({text=i,color = cc.c3b(255, 255, 255),size=18, x=posx, y=posy}):addTo(self)
    end

    for i=1,60,1 do
    	local angle = -(2*math.pi)/60*i + math.pi/2
    	-- 根据角度计算位置
    	local posx = math.cos(angle)*(r-10)
    	local posy = math.sin(angle)*(r-10)
    	if i % 5 == 0 then
    		display.newTTFLabel({text= i,color = cc.c3b(255, 255, 255),size=8, x=posx, y=posy}):addTo(self)--:setRotation(90-angle*180/math.pi)
    	else 
    		display.newTTFLabel({text='|',color = cc.c3b(255, 255, 255),size=9, x=posx, y=posy}):addTo(self):setRotation(90-angle*180/math.pi)
    	end
    end

    -- self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
  	-- self:scheduleUpdate()

  	self:schedule(handler(self, self.setTime), 0.5)
end

function ClockWidget:setTime(timeStr)
	local arr = os.date("%H:%M:%S"):split(':')
	self:setHour(arr[1])
	self:setMinute(arr[2])
	self:setSecond(arr[3])
end

function ClockWidget:setHour(hour)
	local angle = checkint(hour)*360/12
	self.shi:setRotation(angle)
end

function ClockWidget:setMinute(minute)
	local angle = checkint(minute)*360/60
	self.fen:setRotation(angle)
end

function ClockWidget:setSecond(second)
	local angle = checkint(second)*360/60
	self.miao:setRotation(angle)
end


function ClockWidget:tick(dt)
	self.vmiao = self.vmiao + 50*dt
	self.vfen = self.vfen + 50/60*dt
	self.vshi = self.vshi + 50/3600*dt
	self.miao:setRotation(self.vmiao)
	self.fen:setRotation(self.vfen)
	self.shi:setRotation(self.vshi)
end


return ClockWidget