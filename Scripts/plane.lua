local pd <const> = playdate
local gfx <const> = playdate.graphics

import "libraries/AnimatedSprite"
import "CoreLibs/animator"
import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/graphics"


class('plane').extends(AnimatedSprite)

-- Random plane cross the sky

function plane:init()

-- crea imagen del avion

    planeSpriteSheet = gfx.imagetable.new("/images8bit/enemies/planeRightUp-table-96-64")

    plane.super.init(self, planeSpriteSheet)

    self: addState("flying", 1, 2, {tickStep = 8})

    self: addState("down", 4, 15, {tickStep = 8})

    self: setCenter(0,0)

    self: setCollideRect(20, 20, 50, 50)

    self: setZIndex(90)

    self.type = "plane"

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

function plane:update()

  self:moveTo(lineAnimator:currentValue()) 
  
  self:updateAnimation()

  gfx.sprite.update()


end

