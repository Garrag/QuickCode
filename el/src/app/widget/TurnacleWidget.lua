local TurnacleWidget = class("TurnacleWidget", function()
    return display.newNode()
end)

function TurnacleWidget:ctor()
	self.indexAngle = 0 --当前为位置
	self.angleSpeed = 0 --当前速度
	self.acceleratedSpeed = 0 --加速度
	self.maxSpeed = 600 --转盘最大速度
	local r = 100 --半径大小
	local totla = 8
	--根据多边形来确定 三角形的点
	for i=1,totla,1 do
		local x1 = -r*math.tan(math.pi/totla)
		local x2 = r*math.tan(math.pi/totla)
		local bg = display.newDrawNode():drawTriangle(cc.p(0,0), cc.p(x1,r), cc.p(x2,r), self:randomColor()):setRotation(360/totla*i):addTo(self)
		display.newTTFLabel({text= i,color = cc.c3b(255, 255, 255),size=18, x=0, y=r/2+25}):addTo(bg)
	end

	local button = display.newDrawNode():drawRect(cc.p(-18,18), cc.p(18,18), cc.p(18,-18), cc.p(-18,-18), self:randomColor()):addTo(self):setTouchEnabled(true)
	display.newTTFLabel({text='启动', size=12}):addTo(button)

	button:addNodeEventListener(cc.NODE_TOUCH_EVENT, function ()
		self.fsm__:doEvent("run")
	end, 'touch')

	-- 状态机
    cc(self):addComponent("components.behavior.StateMachine")
    self.fsm__ = self:getComponent("components.behavior.StateMachine")

    local defaultEvents = {
        {name = "start",  from = "none",    to = "stop" },
        {name = "run",  from = "stop",    to = "accelerating" }, --开始从零加速
        {name = "keep",  from = "accelerating",    to = "uniforming" }, --保持匀速
        {name = "decelerate",  from = "uniforming",    to = "decelerating" }, --开始减速
        {name = "end",  from = "decelerating",    to = "stop" }, --开始减速
    }
    -- 设定状态机的默认回调
    local defaultCallbacks = {
        onchangestate = handler(self, self.onChangeState_),
        onrun = handler(self, self.onRun_),
        onkeep = handler(self, self.onKeep_),
        ondecelerate = handler(self, self.onDecelerate_),
        onend = handler(self, self.onEnd_),
    }
    self.fsm__:setupState({
        events = defaultEvents,
        callbacks = defaultCallbacks
    })

    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
  	self:scheduleUpdate()

    self.fsm__:doEvent("start") -- 启动状态机
end
	

function TurnacleWidget:onChangeState_(event)
	printf("转盘状态变更 %s to %s", event.from, event.to)
    -- event = {name = Actor.CHANGE_STATE_EVENT, from = event.from, to = event.to}
    -- self:dispatchEvent(event)
end

function TurnacleWidget:onRun_(event)
	self.acceleratedSpeed = 100
end

function TurnacleWidget:onKeep_(event)
	self.angleSpeed = self.maxSpeed
	self.acceleratedSpeed = 0
end

function TurnacleWidget:onDecelerate_(event)
	self.acceleratedSpeed = -100
end

function TurnacleWidget:onEnd_(event)
	self.angleSpeed = 0
	self.acceleratedSpeed = 0
end

function TurnacleWidget:tick(dt)
	if self.angleSpeed > self.maxSpeed then
		self.fsm__:doEvent("keep")
		self:performWithDelay(function ()
			self.fsm__:doEvent("decelerate")
		end, 1)
	else 
		self.angleSpeed = self.angleSpeed + self.acceleratedSpeed*dt
	end
	if self.angleSpeed < 0 then
		self.fsm__:doEvent("end")
	end
	self.indexAngle = self.indexAngle + self.angleSpeed*dt
	self:setRotation(self.indexAngle)
end



function TurnacleWidget:randomColor()
	return cc.c4f(math.random(10, 245), math.random(10, 245), math.random(10, 245), 1)
end



return TurnacleWidget