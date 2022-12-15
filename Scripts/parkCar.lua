local pd <const> = playdate
local gfx <const> = playdate.graphics

import "libraries/AnimatedSprite"
import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/graphics"


class('parkCar').extends(AnimatedSprite)

function parkCar:init(carPosX, carPosY, carZindex)

carNumber = math.random( 1, 2 )

if carNumber == 1 then carType ="carA-table-48-48" end

if carNumber == 2 then carType ="carB-table-48-48" end

carImage = gfx.imagetable.new("/isoimages/monuments/"..carType)

parkCar.super.init(self, carImage)

self:setCenter(0,0)

self.type ="car"


--self: moveTo(carPosX, carPosY)

self: setCollideRect(5, 5, 30, 20)

self: addState("parked", 1, 1, {tickStep = 4})
self: addState("ruined", 2, 3, {tickStep = 12})
self: addState("destroyed", 2, 4, {tickStep = 12, nextAnimation="idle"})
self: addState("idle",4,4, {tickStep = 12})

self: changeState("parked")

self:playAnimation()

self:setZIndex(carZindex)

-- Calculates car position on isometric grid

self: moveTo(isoMap [ carPosX ][carPosY].x, (isoMap [ carPosX ][carPosY].y -48 ))


self: add()

end


