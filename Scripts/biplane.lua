local pd <const> = playdate
local gfx <const> = playdate.graphics

import "libraries/AnimatedSprite"
import "CoreLibs/animator"
import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/graphics"


class('biplane').extends(AnimatedSprite)

-- Random plane cross the sky

function biplane:init()

-- crea imagen del avion

    planeSpriteSheet = gfx.imagetable.new("/images8bit/enemies/biplaneRightUp-table-90-70")

    plane.super.init(self, planeSpriteSheet)

    self: addState("flying", 1, 8, {tickStep = 8})

    self: addState("down", 9, 16, {tickStep = 8})

    self: setCenter(0,0)

    self: setCollideRect(20, 20, 50, 50)

    self: setZIndex(90)

    self.type = "biPlane"

    self: changeState("flying")

    self:playAnimation()

    --self: moveTo(600, 60)

    self:add()

    -- Creates Animator

    lineSegment = pd.geometry.lineSegment.new(400, 100, -1000, -500)
    lineAnimator = gfx.animator.new(15000, lineSegment)


-----------------------------------------
-- COLLISION DETECTION
-----------------------------------------

--[[
function rayCollisionResponse( self, other)

    --print (other.type)

-- HITTING THE BUILDINGS

   if (other.type =="smallbuilding") and (hitTime == true) then
    
 
--]]

   end -- DEL INIT


-- UPDATE

function biplane:update()

  self:moveTo(lineAnimator:currentValue()) 
  
  self:updateAnimation()

  gfx.sprite.update()


end

