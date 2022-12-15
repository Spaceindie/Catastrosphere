local screenWidth = playdate.display.getWidth()
local gfx = playdate.graphics

class('Score').extends(playdate.graphics.sprite)


function Score:init()

	Score.super.init(self)
	--self.scoreFont = gfx.font.new('Score/Roobert-24-Medium-Numerals');
	self:setCenter(1,0)
	self:setScore(0)
	self:setZIndex(0)
	self:add()
end


function Score:addOne()
	self:setScore(self.score + 1)
end

function Score:addFive()
	self:setScore(self.score + 5)
end


function Score:addTen()
	self:setScore(self.score + 10)
end

function Score:addFifty()
	self:setScore(self.score + 50)
end

function Score:addHundred()
	self:setScore(self.score + 100)
end



function Score:addTwoHundred()
	self:setScore(self.score + 150)
end



function Score:setScore(newNumber)
	self.score = newNumber

	self:setSize(100, 100)
	self:moveTo(410, 10)
	self:markDirty()
end


-- draw callback from the sprite library
function Score:draw(x, y, width, height)
	
	gfx.setFont(self.scoreFont)
	gfx.drawText("Score  "..self.score, 0, 0);
		
end
