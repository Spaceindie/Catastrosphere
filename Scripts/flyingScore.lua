local pd <const> = playdate
local gfx <const> = playdate.graphics

import "libraries/AnimatedSprite"
class('flyingScore').extends(AnimatedSprite)


scoreGoUp = 120

function flyingScore:init(xSpawn, ySpawn)


-- crea imagen del rayo 
print (scoreBanner)

if scoreBanner == 0 then 
    imagetable = playdate.graphics.imagetable.new("/images8bit/UI/scoreZero-table-48-16.png")
end

if scoreBanner == 5 then 
    imagetable = playdate.graphics.imagetable.new("/images8bit/UI/scoreFive-table-40-30.png")
end

if scoreBanner == 10 then 
    imagetable = playdate.graphics.imagetable.new("/images8bit/UI/scoreTen-table-30-40.png")
end

if scoreBanner == 50 then
    imagetable = playdate.graphics.imagetable.new("/images8bit/UI/scoreFifty-table-40-30.png")
end

if scoreBanner == 100 then
    imagetable = playdate.graphics.imagetable.new("/images8bit/UI/scoreHundred-table-40-40.png")
end

if scoreBanner == 150 then
    imagetable = playdate.graphics.imagetable.new("/images8bit/UI/scoreTwoHundred-table-40-40.png")
end


    flyingScore.super.init(self, imagetable)

    self: addState("scoring", 1, 2, {tickStep = 12})

    self: setCenter(0,0)

    self: setZIndex(110)

    self.speed = 1

    self.type = "scoreUnitTen"

   -- Se posiciona el objeto a disparar

      self.xPosition = xSpawn

      self.yPosition = ySpawn

      self: moveTo( self.xPosition ,  self.yPosition )

    self: add()
    self: changeState("scoring")
    self: playAnimation()

    scoreGoUp = 100

end -- DEL INIT

-- UPDATE

function flyingScore:update()

 if scoreGoUp <= 250 then

  self: moveTo( self.xPosition + 5 ,  self.yPosition - scoreGoUp)

  scoreGoUp  += 1

 else self:remove() end

 --print (scoreGoUp)
 
self:updateAnimation()
gfx.sprite.update()
pd.graphics.sprite.update()

end

