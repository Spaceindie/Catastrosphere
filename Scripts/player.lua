import 'CoreLibs/object'
import 'CoreLibs/sprites'
import "CoreLibs/graphics"
import 'libraries/AnimatedSprite.lua'

local geo <const> = playdate.geometry
local pd <const> = playdate
local gfx <const> = pd.graphics

function player (playerCurrentPosX, playerCurrentPosY, playerAnimationSpeed) 

-- CREA EL PLAYER CLOUD y lo pone en pantalla

imagetable = playdate.graphics.imagetable.new("/images8bit/player/cloud-table-176-112.png")

playerSprite  = AnimatedSprite.new(imagetable) -- Creating AnimatedSprite instance
playerSprite.type ="nube"
playerSprite :addState("idle", 1, 5, {tickStep = playerAnimationSpeed}) -- Adding custom animation state
playerSprite :addState("split", 6, 14, {tickStep = 12}) -- Adding custom animation state
playerSprite :addState("holdRain", 15, 22, {tickStep = 4, nextAnimation="storm"}) -- Adding custom animation state
--playerSprite :addState("holdgrain", 15, 22, {tickStep = 4, nextAnimation ="rain"}) -- Adding custom animation state
playerSprite :addState("rain", 23, 24, {tickStep = 4}) -- Adding custom animation state
playerSprite :addState("storm", 25, 29, {tickStep = 6, nextAnimation ="idle"}) -- Adding custom animation state
playerSprite :addState("rays", 30, 34, {tickStep = 8, nextAnimation ="idle"}) -- Adding custom animation state
playerSprite :addState("dead", 106, 114, {tickStep = 14, nextAnimation="dissapear"}) -- Adding custom animation state
playerSprite :addState("dissapear", 114, 115, {tickStep = 20}) -- Adding custom animation state

playerSprite :setCollideRect(1, 1, 1, 11)

playerSprite :moveTo(playerCurrentPosX, playerCurrentPosY)
--playerSprite :moveWithCollisions(playerCurrentPosX, playerCurrentPosY)
playerSprite: setIgnoresDrawOffset(true)


playerSprite :setCenter(.5,.5)
playerSprite :changeState("idle")
playerSprite :playAnimation()

-- Player original position off screen

playerSprite :setZIndex(20)
playerSprite :add()


--[[

-- CREA EL SHADOW CLOUD y lo pone en pantalla

imagetable = playdate.graphics.imagetable.new("/images8bit/player/shadowtrama-table-80-16.png")

shadowSprite  = AnimatedSprite.new(imagetable) -- Creating AnimatedSprite instance

shadowSprite :addState("idle", 1, 5, {tickStep = playerAnimationSpeed}) -- Adding custom animation state
--shadowSprite :addState("split", 6, 14, {tickStep = 12}) -- Adding custom animation state

--shadowSprite :setScale(0.5, 0.5)
shadowSprite :moveTo(playerCurrentPosX +100, playerCurrentPosY - 200)
shadowSprite: setIgnoresDrawOffset(true)

shadowSprite :setCenter(0,0)
shadowSprite :changeState("idle")
shadowSprite :playAnimation()

playerSprite :setZIndex(20)
playerSprite :add()

--]]

function windRight(currentPlayerPosX, playerCurrentPosY, windSpeed)
    playerSprite :moveTo(playerCurrentPosX + windSpeed, playerCurrentPoxY)
end

function windLeft(windSpeed)
    playerSprite :moveTo(playerCurrentPosX - windSpeed, playerCurrentPosY)
end



end



