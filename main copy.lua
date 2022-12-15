-- ISOMETRIC GAME AND LIBRARIES
-- IGO 750 LAND PATRICIO - FALMOUTH UNIVERSITY
-- VER 14. Dec 2022

import 'CoreLibs/object'
import 'CoreLibs/sprites'
import "CoreLibs/graphics"
import 'CoreLibs/timer'
import 'CoreLibs/animator'
import 'scripts/edificio'
import 'scripts/specialEdificio'
import 'scripts/squareMonuments'
import 'scripts/fallingCubes'
import 'scripts/mainUI'
import 'scripts/cloudCore'
import 'scripts/pathForPeople'
import 'scripts/ray'
import 'scripts/rain'
import 'scripts/score'
import 'scripts/parkCar'
import 'scripts/plane'
import 'scripts/biplane'
import 'scripts/introScreen'

import 'libraries/AnimatedSprite.lua'

local geo <const> = playdate.geometry
local pd <const> = playdate
local gfx <const> = pd.graphics



function init() -- needs to be called before update 

-- VARIABLES 

intro = true
reboot = false 
floorReady = false -- when true the cube tiles for the level are set in place
treesReady = true -- when false the trees are already in place
enterPlayer = false -- when true the player enters the level
levelReady = false -- when true the player and controls are activated


cameraUp = false
gameStart = false

rowToShake = 1
speed = 4
destino = 0
rowToMove = 1
colToMove = 1

posCubeDown = 1
posCubeUp = 1
posCube = 1

posXiso = 200
posYiso = -256

tileFloor = 256

separacion =0
columna =0 
xCenterPos = 0
yCenterPos = 0

contadorRecursividad = 0

incremento = 0
fila = 32
actualPosition = {}
randomDirection = 0

limiteY, limiteX = 6

spritesheet = nil -- this will be the image table

isoMap = nil -- this is the tile isoMap

-- WINDOW CONTROLLER VARIABLES 

current_milliseconds = nil
current_seconds = nil
times_triggered = 0
ten_second_timer = nil
initialised = false

initialWindCondition = false

-- GUYS VARIABLES

nroGuy = 0 
character1IsDead = false
character2IsDead = false

-- PLAYER VARIABLES

cloudLifeMarker = 0

playerCurrentPosX = 200
playerCurrentPosY = 80

playerInitialPosX = 200 -- initial player position over the Press A button to Start
playerInitialPosY = 80

desplazamientoPlayer = 0.4

fallingDownSpeed = 0.1

playerFloorLimit = 120

coreBumping = false -- activates / deacticates the cloudCore

--WIND VARIABLES

cloudPower = 0

--Wind direction 0 No wind 1 Up 2 Down 3 Left 4 Right

windDirection = 0
windSpeed = 0


-- SCROLL VARIABLES

scrollUpLimit = 130
scrollDownLimit = 40
scrollRightLimit = -240
scrollLeftLimit  = 150

--desplazamientoCamera = 1.5

-- Variables para el scroll arriba y abajo usado por DrawOffset

limiteScroll = 15
posYScroll = 0
posXScroll = 0
scrollDown = true
scrollUp = true


-- Variables for the TREES

possibleFreeTileX = 1
possibleFreeTileY = 1 
treesQuantity = 0

-- LEVEL VARIABLES

gameOver = false
goingUp = 0
carsInPlace = false

-- ATTACK VARIABLES

attackReady = true
sendPlane = true

-- Variables para los tipitos

characterIsWalking = false
guy1PositionX = 0
guy1PositionY = 0
guy2PositionX = 0
guy2PositionX = 0 

viajeIda1 = true
viajeIda2 = true
freeTile = true
tripCounter = 1

-- CRANK VARIABLES

valorY = 100


-- SCORE VARIABLES

score=0
currentScore = 0
maxScore = 0
minScore = 0

-- SUN COUNTER

mark = 0
sunStart = false

-- POWER ATTACKS LIST

maxPowerAttack = 9
currentPowerAttack = 1
energyAttack = 1
currentEnergyAttack = 0

powerAttack ={}
for i = 1, 9 do
  powerAttack [i] = {}
  for j = 1, 3 do
    powerAttack [i][j] = 0 --set the content to zeros  
  end
end

powerAttack [1] [1]="windPower"
powerAttack [2] [1]="rainPower"
powerAttack [3] [1]="granizoPower"
powerAttack [4] [1]="snowPower"
powerAttack [5] [1]="rayPower"
powerAttack [6] [1]="tornadoPower"
powerAttack [7] [1]="firePower"
powerAttack [8] [1]="floodPower"
powerAttack [9] [1]="tsunamiPower"

-- Individual attack quantity 

powerAttack [1] [2]= 5
powerAttack [2] [2]= 5
powerAttack [3] [2]= 1
powerAttack [4] [2]= 1
powerAttack [5] [2]= 5
powerAttack [6] [2]= 1
powerAttack [7] [2]= 1
powerAttack [8] [2]= 1
powerAttack [9] [2]= 1



-- Sprite to draw the score inside using the Score script

score = Score()
score:setZIndex(110)
score:addSprite()
score:setIgnoresDrawOffset(true)
score:moveTo(-200, -200) -- moves to limbo


-----------------------------------------
-- INTRO SCREEN
-----------------------------------------

  -- Custom Font
    
  local mynewfont = gfx.font.new("font/whiteglove-stroked")
  gfx.setFont(mynewfont)

 

introScreen()

-----------------------------------------
-- INIT START 
-----------------------------------------


-- PLAYER CLOUD 
  
  imagetable = playdate.graphics.imagetable.new("/images8bit/player/cloud-table-176-112.png")
  
  playerSprite  = AnimatedSprite.new(imagetable) -- Creating AnimatedSprite instance

  playerSprite.type ="player"

  playerSprite :addState("idle", 1, 5, {tickStep = 4}) -- Adding custom animation state
  playerSprite :addState("split", 6, 14, {tickStep = 12}) -- Adding custom animation state
  playerSprite :addState("holdRain", 15, 22, {tickStep = 4, nextAnimation="storm"}) -- Adding custom animation state
  playerSprite :addState("rain", 23, 24, {tickStep = 4}) -- Adding custom animation state
  playerSprite :addState("storm", 25, 29, {tickStep = 6, nextAnimation ="idle"}) -- Adding custom animation state
  playerSprite :addState("rays", 30, 34, {tickStep = 8, nextAnimation ="idle"}) -- Adding custom animation state
  playerSprite :addState("dead", 106, 114, {tickStep = 12, nextAnimation="dissapear"}) -- Adding custom animation state
  playerSprite :addState("dissapear", 114, 115, {tickStep = 20}) -- Adding custom animation state
  
  playerSprite :setCollideRect(50, 40, 60, 5)
  playerSprite: setCollisionsEnabled(true)
  playerSprite :moveWithCollisions(450,50)
  --playerSprite: setIgnoresDrawOffset(true)
 
  playerSprite :setCenter(.5,.5)
  playerSprite :changeState("idle")
  playerSprite :playAnimation()
  
  playerSprite :setZIndex(20)
  playerSprite :add()

------------------------------
------------------------------

  function playerSpriteCollisionResponse(self, other)

    --print("activa colisiones")
    print(other.type)

    if other.type == "smallbuilding" then

     -- print(other.type)

      --return gfx.sprite.kCollisionTypeFreeze
      return gfx.sprite.kCollisionTypeOverlap

    end

  end



-- Seed para los valores random

  math.randomseed(playdate.getSecondsSinceEpoch())


-- WIND GENERATOR 

-- TIME COUNTER 

  -- Cada 10 segundos hace un callback a la funcion que cambia el sprite de las mini mubes

  ten_second_timer = pd.timer.new(1500, timerCallback)

  ten_second_timer.repeats = true

  -- TIMER for CLOUD LIFE TIMER

  -- Read the Timer

  current_milliseconds = pd.getCurrentTimeMilliseconds()

  -- Convierte los milisegundos en segundos 

  current_seconds = math.floor(current_milliseconds / 1000) % 60

  -- Timer on Screen

  --gfx.drawText("TIMER: " .. current_seconds, 100, 200)



-- NORMAL MATRIX 
-- Se crea una matriz normal llena de letras G equivalentes a un tile vacia

 normalMap = {}

-- BORDERS 
-- Se crean bordes de cube tiles especiales 

  for i = 1, 16 do -- the matrix is of 16 x 16 
    normalMap [i] = {} -- creates a new row
    for j = 1, 16 do
      normalMap [i][j] = "G" -- set the content with the G image
    end
end


-- MATRIZ ISOMETRICA 
-- Se crea una matriz ISOMETRICA isoMAP 32 x 32 llena de sprites isometricos vacios G

isoMap = {}
for i = 1, 16 do
  isoMap [i] = {} -- se crea una nueva fila
  for j = 1, 16 do
    tileImage = gfx.image.new("/isoimages/G.png")
    isoMap [i][j] = gfx.sprite.new(tileImage)
    -- Pone el centro de cada sprite en el medio
  end
end

--[[

-- MATRIX 2D SPRITES
-- Se crea una matriz llena de sprites vacios de 8 x 8
spriteMap = {}
for i = 1, 16 do
  spriteMap [i] = {} -- se crea una nueva fila
  for j = 1, 16 do
    spriteMap [i][j] = gfx.sprite.new()
  end
end
--]]

-- MATRIX FOR BUILDINGS ATTRIBUTES 

edificioAttribute = {}   -- create the matrix for the building attributes

    for i= 1, 4 do -- there's a max of 4 buildingd 
      edificioAttribute[i] = {}     -- creates a new row
      for j = 1, 7 do -- each building has up to 5 attributes
        edificioAttribute[i][j] = 0 -- set the content to zeros  
      end
    end

    nroEdificio = 0 -- inicializa el nro de eficio para llevar cuenta de la cantidad de ellos
   
    --Crea un vector de sprites para los edificioSprite

    edificioSprite = {}
    for i = 1, 5 do
        spriteImage = gfx.image.new("/isoimages/buildings/edificioempty.png")
        edificioSprite [i] = gfx.sprite.new(spriteImage)
       -- edificioSprite [i]: setCollideRect(0,0, 64, 32)
        edificioSprite [i]: setCenter(0.5,0.5)
       -- edificioSprite [i]: add() --- agrega el sprite al vector edificioSprite
      end
   
  -- MATRIX FOR SQUARE MONUMENT OBJECTS

      squareAttribute = {}   -- create the matrix for the quare attributes and monuments
      for i= 1, 10 do -- there's a max of 10 decoration items 
        squareAttribute [i] = {}     -- creates a new row
        for j = 1, 4 do -- each building has up to 5 attributes
          squareAttribute [i][j] = 0 -- set the content to zeros  
        end
      end

      nroMonuments  = 0 -- inicializa el nro de monumentos para llevar cuenta de la cantidad de ellos

      squareSprite = {}
      for i = 1, 10 do
         spriteImage = gfx.image.new("/isoimages/monuments/monumentempty.png")
         squareSprite [i] = gfx.sprite.new(spriteImage)
         squareSprite [i]: setCenter(0.5,0.5)
         squareSprite [i]: add() -- agrega el sprite al vector squareSprite
        end


-- VECTOR FOR TREES and VEGETATION

treeSprite = {}
for i = 1, 10 do
  
  treeKind = math.random(1,3)
 
  if treeKind == 1 then  imagetable = playdate.graphics.imagetable.new("/isoimages/trees/treesgrowA-table-64-64") end
  if treeKind == 2 then  imagetable = playdate.graphics.imagetable.new("/isoimages/trees/treesgrowB-table-64-64") end
  if treeKind == 3 then  imagetable = playdate.graphics.imagetable.new("/isoimages/trees/treesgrowC-table-80-80") end

  treeSprite [i] = AnimatedSprite.new(imagetable) -- Creating AnimatedSprite instance
  treeSprite [i]:setCenter(0.5,0.5)
  treeSprite [i]:addState("idle", 1, 1, {tickStep = 2}) -- Adding custom animation state
  treeSprite [i]:addState("plop1", 2, 8, {tickStep = 12, nextAnimation ="grow"})
  treeSprite [i]:addState("plop2", 2, 8, {tickStep = 4, nextAnimation ="grow"})
  treeSprite [i]:addState("plop3", 2, 8, {tickStep = 20, nextAnimation ="grow"})
  treeSprite [i]:addState("grow", 8, 9, {tickStep = 60})
  treeSprite [i]:addState("blowLeft", 8, 9, {tickStep = 60})
  treeSprite [i]:addState("blowRight", 10, 11, {tickStep = 60})
  treeSprite [i]:addState("burnt", 12, 15, {tickStep = 4, loop = 5})
  treeSprite [i]:addState("dead", 15, 15, {tickStep = 60})

  treeSprite [i]:changeState("idle")
  treeSprite [i].type ="tree"
  treeSprite [i]:setCollideRect(15, 20, 20, 10)
  
  -- Temporary deactivate collisions with trees

  treeSprite [i]:setCollisionsEnabled(false)
  treeSprite [i]:moveTo(-100,-100) -- Limbo position
  treeSprite [i]:add()

end

-- HUMAN GUYS 

    --Crea un vector de sprites para los personajes humanos (hasta 4)

guyAttribute = {}   -- create the matrix for the human guys attributes

    for i= 1, 4 do -- there's a max of 4 humans
    guyAttribute[i] = {}     -- creates a new row
      
    for j = 1, 8 do -- each human character  has up to 5 attributes

        guyAttribute[i][j] = 0 -- set the content to zeros  
    
    end
  
  end

    --Crea un vector de sprites para los personajes humanos randomizando el genero 

    guySprite = {}

    for i = 1, 2 do

    guyGenre = math.random(1,2)

  if guyGenre == 1 then
    
    imagetable = playdate.graphics.imagetable.new("/images8bit/people/man-table-16-16.png") 
    guySprite[i]= AnimatedSprite.new(imagetable) -- Creating AnimatedSprite instance
    guySprite[i]: addState("walkFrontLeft", 1, 4, {tickStep = 12})
    guySprite[i]: addState("walkFrontRight", 5, 8, {tickStep = 12})
    guySprite[i]: addState("walkBackLeft", 9, 12, {tickStep = 12})
    guySprite[i]: addState("walkBackRight", 13, 16, {tickStep = 12})
    guySprite[i]: addState("rayImpact", 17, 18, {tickStep = 8, loop = 4, nextAnimation = "rayDead"})
    guySprite[i]: addState("rayDead", 19,21, {tickStep = 4})
    guySprite[i]: addState("lying", 22,25, {tickStep = 4})
    guySprite[i]: changeState("walkFrontLeft")
    guySprite[i].type ="man"
    guySprite[i]: setCenter(1,1)
    guySprite[i]: setZIndex(8)
    guySprite[i]: setCollideRect(1, 1, 10, 10)
    guySprite[i]: moveTo(-200, -200) -- Limbo position 
    guySprite[i]: add()
    
  end

  if guyGenre == 2 then
    imagetable = playdate.graphics.imagetable.new("/images8bit/people/woman-table-16-16.png") 
    guySprite[i]= AnimatedSprite.new(imagetable) -- Creating AnimatedSprite instance

   guySprite[i]: addState("walkFrontLeft", 1, 4, {tickStep = 12})
   guySprite[i]: addState("walkFrontRight", 5, 8, {tickStep = 12})
   guySprite[i]: addState("walkBackLeft", 9, 12, {tickStep = 12})
   guySprite[i]: addState("walkBackRight", 13, 16, {tickStep = 12})
   guySprite[i]: addState("rayImpact", 17, 18, {tickStep = 8, loop = 4, nextAnimation = "rayDead"})
   guySprite[i]: addState("rayDead",19,21, {tickStep = 4})
   guySprite[i]: addState("lying", 22,25, {tickStep = 4})
   guySprite[i]: changeState("walkFrontLeft")
   guySprite[i].type ="woman"
   guySprite[i]: setCenter(1,1)
   guySprite[i]: setZIndex(8)
   guySprite[i]: setCollideRect(1, 1, 10, 10)
   guySprite[i]: moveTo(-200, -200) -- Limbo position 
   guySprite[i]: add()
      

  end
end

   


-- L SYSTEM 
-- Asignacion manual de tiles a traves de frases
-- Comenzando por el centro de la matriz que se encuenta entre las celdas
-- 8,8 8,9 9,8 9,9
-- Ahi se coloca una Tile de Tipo H (Cruz)


math.randomseed(playdate.getSecondsSinceEpoch())

xCenterPos= math.random(8,9)
yCenterPos= math.random(8,9)

-- ORIGEN

--currentXPosition = xCenterPos
--currentYPosition = yCenterPos

xCenterPos= 8
yCenterPos= 8
xOriginPos= 8
yOriginPos= 8

--print ("START POSITION "..currentXPosition.." "..currentYPosition)


-- ROADS CONSTRUCCION

-- REFS:
-- OR ORIGEN - CE CENTRAL - SA SAVE POSITION - LD LOAD POSITION - BD BUILDING - SQ SQUARE 
-- UP UP - DW DOWN - LT LEFT - RT RIGHT 

-- axiom="OR CE UP UP UP CE SA CE LT LD RT OR DW DW DW CE SA LT LD RT"

-- WORLD CREATION PART 1

previousAxiom ="OR"

--axiom="OR CE UP UP UP CE SA CE LT LT LD RT RT OR DW DW DW CE SA LT LT LD RT RT"
--axiom="OR CE UP UP UP CE SA CE LT LT BD LD RT RT BD OR DW DW DW CE SA LT LT BD LD RT RT BD"
  axiom="OR CE UP UP UP CE SA CE LT LT BD LD RT RT OR DW DW DW DW CE SA LT LT SQ LD RT RT BD"



for currentAxiom in string.gmatch(axiom, "%a+") do

  --print ("Current Axiom "..currentAxiom)
  --print ("Previous Axiom "..previousAxiom)
  --print ("")

  if currentAxiom =="OR" then origenTile() end
  if currentAxiom =="CE" then centralTile() end
  if currentAxiom =="SA" then saveTile() end
  if currentAxiom =="LD" then loadTile() end
  if currentAxiom =="DW" then downTile() end
  if currentAxiom =="UP" then upTile() end
  if currentAxiom =="LT" then leftTile() end
  if currentAxiom =="RT" then rightTile() end
  if currentAxiom =="BD" then building() end
  if currentAxiom =="SQ" then square() end
  if currentAxiom =="SB" then specialBuilding() end

  
  -- Previous axiom keeps the previous element from the axiom

  previousAxiom = currentAxiom

  end


-- PART 2

xCenterPos= 5
yCenterPos= 11
xOriginPos= 5
yOriginPos= 11


axiom2="OR CE UP UP CE SA CE LT BD LD RT SB OR DW DW CE SA LD RT"

previousAxiom ="OR"

  for currentAxiom in string.gmatch(axiom2, "%a+") do

  --print ("Current Axiom "..currentAxiom)
  --print ("")

  if currentAxiom =="OR" then origenTile() end
  if currentAxiom =="CE" then centralTile() end
  if currentAxiom =="SA" then saveTile() end
  if currentAxiom =="LD" then loadTile() end
  if currentAxiom =="DW" then downTile() end
  if currentAxiom =="UP" then upTile() end
  if currentAxiom =="LT" then leftTile() end
  if currentAxiom =="RT" then rightTile() end
  if currentAxiom =="BD" then building() end
  if currentAxiom =="SQ" then square() end
  if currentAxiom =="SB" then specialBuilding() end


  previousAxiom = currentAxiom


end

--[[

-- PART 3

xCenterPos= 11
yCenterPos= 5
xOriginPos= 11
yOriginPos= 5


  axiom2="OR CE UP UP CE SA CE LT LD RT OR DW DW CE SA LT LD RT"

  for w in string.gmatch(axiom2, "%a+") do

  print ("Current Axiom "..w)
  print ("")

  if w =="OR" then origenTile() end
  if w =="CE" then centralTile() end
  if w =="SA" then saveTile() end
  if w =="LD" then loadTile() end
  if w =="DW" then downTile() end
  if w =="UP" then upTile() end
  if w =="LT" then leftTile() end
  if w =="RT" then rightTile() end


end

--]]


  -- Sube todos los cubos de lugar

  --[[
-- MUEVE CUBOS DE MANERA INDEPENDIENTE

-- mueve un cubo dada una posicion X, Y , una direccion y un limite de altura hacia arrriba
  moveCube(16, 16, 8, "up")

-- mueve un cubo dada una posicion X, Y , una direccion y un limite de altura hacia abajo
  moveCube(12, 2, 220, "down")

for movimiento = 1, 16, 1 do
moveCube(10, 1, 8, "up")
moveCube(10, 2, 16, "up")
moveCube(10, 3, 16, "up")

end

--]]


-- Creacion del L SYSTEM
-- A partir del centro del la matrix


--spriteMapCreation()

volcado()

isoMapCreation()

treesCreation()

buildingCreation()

squareDecoration()



-- UI SETUP

mainUI()

-- SET THE PLAYER setting the current x position way to the right out of screen, current Y position and the animation speed 

end -- OF INIT()


-----------------------------------------
-- FUNCTIONS DECLARATION START
-----------------------------------------


-- WIND MARKER CALLBACK for the UI

function timerCallback()

  -- As time pass by changes the Cloud life marker
  
  
    cloudLifeMarker += 1
  
    --print (cloudLifeMarker)
  
    imagetable = gfx.image.new("/images8bit/UI/timer/"..cloudLifeMarker)
   -- Change the sprite image for a new one
    lifeTimerUISprite:setImage(imagetable)
  
    end


function spriteMapCreation()
-- Visualizacion de la Matriz 2D

for i = 1, 16 do
  
  for j = 1, 16 do
    
   if normalMap [i][j] == "A" then         
    spriteImage = gfx.image.new("/images8bit/A.png")
   
  
   end

   if normalMap [i][j] == "B" then         
    spriteImage = gfx.image.new("/images8bit/B.png")
   
   end

   if normalMap [i][j] == "C" then         
    spriteImage = gfx.image.new("/images8bit/C.png")
    
   end

   if normalMap [i][j] == "D" then         
    spriteImage = gfx.image.new("/images8bit/D.png")
    
   end

   if normalMap [i][j] == "E" then         
    spriteImage = gfx.image.new("/images8bit/E.png")
    
   end

   if normalMap [i][j] == "F" then         
    spriteImage = gfx.image.new("/images8bit/F.png")
    
   end

   if normalMap [i][j] == "G" then         
    spriteImage = gfx.image.new("/images8bit/G.png")
    

   end

   if normalMap [i][j] == "H" then         
    spriteImage = gfx.image.new("/images8bit/H.png")
   
   end


   if normalMap [i][j] == "K" then

   spriteImage = gfx.image.new("/images8bit/K.png")
      
   end

   if normalMap [i][j] == "T" then

   spriteImage = gfx.image.new("/images8bit/T.png")
      
   end


   if normalMap [i][j] == "S" then
    spriteImage = gfx.image.new("/images8bit/S.png")
    
    end

  
   if normalMap [i][j] == "N" then
    spriteImage = gfx.image.new("/images8bit/N.png")
      
    end


   if normalMap [i][j] == "S0" then
      spriteImage = gfx.image.new("/images8bit/S.png")
      
      end

   if normalMap [i][j] == "S1" then
        spriteImage = gfx.image.new("/images8bit/S.png")
        
       end

   if normalMap [i][j] == "S3" then
        spriteImage = gfx.image.new("/images8bit/S.png")
        
       end

    if normalMap [i][j] == "S4" then
        spriteImage = gfx.image.new("/images8bit/S.png")
        
       end
       
    if normalMap [i][j] == "S5" then
        spriteImage = gfx.image.new("/images8bit/S.png")
        
       end
       
    if normalMap [i][j] == "S6" then
        spriteImage = gfx.image.new("/images8bit/S.png")
        
       end

     if normalMap [i][j] == "S7" then
        spriteImage = gfx.image.new("/images8bit/S.png")
        
       end

     if normalMap [i][j] == "S8" then
        spriteImage = gfx.image.new("/images8bit/S.png")
        
       end

      if normalMap [i][j] == "S9" then
        spriteImage = gfx.image.new("/images8bit/S.png")
        
       end

      if normalMap [i][j] == "S11" then
        spriteImage = gfx.image.new("/images8bit/S.png")
        
       end

      if normalMap [i][j] == "S12" then
        spriteImage = gfx.image.new("/images8bit/S.png")

       end


    spriteMap [i][j] = gfx.sprite.new(spriteImage)
    spriteMap [i][j]: add()

    spriteMap [i][j]:moveTo(-450 + columna, 50 + fila)

  columna = columna + 8
  
  end

  fila = fila + 8

  columna = 0

end

end


function isoMapCreation()


-- ORDENA LA MATRIZ ISOMETRICA EN PANTALLA

-- FILA 1

isoMap [1][1]:moveTo(posXiso, 16 + posYiso)

 -- FILA 2 
  
isoMap [2][1]:moveTo(posXiso - 16, 24 + posYiso)
isoMap [1][2]:moveTo(posXiso + 16, 24 + posYiso)


  -- FILA 3

isoMap [3][1]:moveTo(posXiso - 32, 32 + posYiso)
isoMap [2][2]:moveTo(posXiso, 32 + posYiso)
isoMap [1][3]:moveTo(posXiso + 32 , 32 + posYiso)

  
-- FILA 4


isoMap [4][1]:moveTo(posXiso - 48, 40 + posYiso)
isoMap [3][2]:moveTo(posXiso - 16, 40 + posYiso)
isoMap [2][3]:moveTo(posXiso + 16, 40 + posYiso)
isoMap [1][4]:moveTo(posXiso + 48, 40 + posYiso)


-- FILA 5

isoMap [5][1]:moveTo(posXiso - 64, 48 + posYiso)
isoMap [4][2]:moveTo(posXiso -32, 48 + posYiso)
isoMap [3][3]:moveTo(posXiso, 48 + posYiso)
isoMap [2][4]:moveTo(posXiso + 32, 48 + posYiso)
isoMap [1][5]:moveTo(posXiso + 64, 48 + posYiso)


-- FILA 6

isoMap [6][1]:moveTo(posXiso - 80, 56 + posYiso)
isoMap [5][2]:moveTo(posXiso - 48, 56 + posYiso)
isoMap [4][3]:moveTo(posXiso - 16, 56 + posYiso)
isoMap [3][4]:moveTo(posXiso + 16, 56 + posYiso)
isoMap [2][5]:moveTo(posXiso + 48, 56 + posYiso)
isoMap [1][6]:moveTo(posXiso + 80, 56 + posYiso)


-- FILA 7

isoMap [7][1]:moveTo(posXiso - 96, 64 + posYiso)
isoMap [6][2]:moveTo(posXiso - 64, 64 + posYiso)
isoMap [5][3]:moveTo(posXiso - 32, 64 + posYiso)
isoMap [4][4]:moveTo(posXiso , 64 + posYiso)
isoMap [3][5]:moveTo(posXiso + 32, 64 + posYiso)
isoMap [2][6]:moveTo(posXiso + 64, 64 + posYiso)
isoMap [1][7]:moveTo(posXiso + 96, 64 + posYiso)


-- FILA 8

isoMap [8][1]:moveTo(posXiso - 112, 72 + posYiso)
isoMap [7][2]:moveTo(posXiso - 80,  72 + posYiso)
isoMap [6][3]:moveTo(posXiso - 48,  72 + posYiso)
isoMap [5][4]:moveTo(posXiso - 16,  72 + posYiso)
isoMap [4][5]:moveTo(posXiso + 16,  72 + posYiso)
isoMap [3][6]:moveTo(posXiso + 48,  72 + posYiso)
isoMap [2][7]:moveTo(posXiso + 80,  72 + posYiso)
isoMap [1][8]:moveTo(posXiso + 112,  72 + posYiso)



-- FILA 9

isoMap [9][1]:moveTo(posXiso - 128, 80 + posYiso)
isoMap [8][2]:moveTo(posXiso - 96, 80 + posYiso)
isoMap [7][3]:moveTo(posXiso - 64, 80 + posYiso)
isoMap [6][4]:moveTo(posXiso - 32, 80 + posYiso)
isoMap [5][5]:moveTo(posXiso, 80 + posYiso)
isoMap [4][6]:moveTo(posXiso + 32 , 80 + posYiso)
isoMap [3][7]:moveTo(posXiso + 64 , 80 + posYiso)
isoMap [2][8]:moveTo(posXiso + 96 , 80 + posYiso)
isoMap [1][9]:moveTo(posXiso + 128 , 80 + posYiso)


-- FILA 10

isoMap [10][1]:moveTo(posXiso - 144, 88 + posYiso)
isoMap [9][2]:moveTo(posXiso - 112, 88 + posYiso)
isoMap [8][3]:moveTo(posXiso - 80, 88 + posYiso)
isoMap [7][4]:moveTo(posXiso - 48, 88 + posYiso)
isoMap [6][5]:moveTo(posXiso - 16, 88 + posYiso)
isoMap [5][6]:moveTo(posXiso + 16, 88 + posYiso)
isoMap [4][7]:moveTo(posXiso + 48, 88 + posYiso)
isoMap [3][8]:moveTo(posXiso + 80, 88 + posYiso)
isoMap [2][9]:moveTo(posXiso + 112, 88 + posYiso)
isoMap [1][10]:moveTo(posXiso + 144, 88 + posYiso)


-- FILA 11

isoMap [11][1]:moveTo(posXiso - 160, 96 + posYiso)
isoMap [10][2]:moveTo(posXiso - 128, 96 + posYiso)
isoMap [9][3]:moveTo(posXiso - 96, 96 + posYiso)
isoMap [8][4]:moveTo(posXiso - 64, 96 + posYiso)
isoMap [7][5]:moveTo(posXiso - 32, 96 + posYiso)
isoMap [6][6]:moveTo(posXiso, 96 + posYiso)
isoMap [5][7]:moveTo(posXiso + 32, 96 + posYiso)
isoMap [4][8]:moveTo(posXiso + 64, 96 + posYiso)
isoMap [3][9]:moveTo(posXiso + 96, 96 + posYiso)
isoMap [2][10]:moveTo(posXiso + 128, 96 + posYiso)
isoMap [1][11]:moveTo(posXiso + 160, 96 + posYiso)

-- FILA 12

isoMap [12][1]:moveTo(posXiso - 176, 104 + posYiso)
isoMap [11][2]:moveTo(posXiso - 144, 104 + posYiso)
isoMap [10][3]:moveTo(posXiso - 112, 104 + posYiso)
isoMap [9][4]:moveTo(posXiso - 80, 104 + posYiso)
isoMap [8][5]:moveTo(posXiso - 48, 104 + posYiso)
isoMap [7][6]:moveTo(posXiso - 16, 104 + posYiso)
isoMap [6][7]:moveTo(posXiso + 16, 104 + posYiso)
isoMap [5][8]:moveTo(posXiso + 48, 104 + posYiso)
isoMap [4][9]:moveTo(posXiso + 80, 104 + posYiso)
isoMap [3][10]:moveTo(posXiso + 112, 104 + posYiso)
isoMap [2][11]:moveTo(posXiso + 144, 104 + posYiso)
isoMap [1][12]:moveTo(posXiso + 176, 104 + posYiso)



-- FILA 13

isoMap [13][1]:moveTo(posXiso - 192, 112 + posYiso)
isoMap [12][2]:moveTo(posXiso - 160, 112 + posYiso)
isoMap [11][3]:moveTo(posXiso - 128, 112 + posYiso)
isoMap [10][4]:moveTo(posXiso - 96, 112 + posYiso)
isoMap [9][5]:moveTo(posXiso - 64, 112 + posYiso)
isoMap [8][6]:moveTo(posXiso - 32, 112 + posYiso)
isoMap [7][7]:moveTo(posXiso, 112 + posYiso)
isoMap [6][8]:moveTo(posXiso + 32, 112 + posYiso)
isoMap [5][9]:moveTo(posXiso + 64, 112 + posYiso)
isoMap [4][10]:moveTo(posXiso + 96, 112 + posYiso)
isoMap [3][11]:moveTo(posXiso + 128, 112 + posYiso)
isoMap [2][12]:moveTo(posXiso + 160, 112 + posYiso)
isoMap [1][13]:moveTo(posXiso + 192, 112 + posYiso)


-- FILA 14

isoMap [14][1]:moveTo(posXiso - 208, 120 + posYiso)
isoMap [13][2]:moveTo(posXiso - 176, 120 + posYiso)
isoMap [12][3]:moveTo(posXiso - 144, 120 + posYiso)
isoMap [11][4]:moveTo(posXiso - 112, 120 + posYiso)
isoMap [10][5]:moveTo(posXiso -  80, 120 + posYiso)
isoMap [9][6]:moveTo(posXiso -  48, 120 + posYiso)
isoMap [8][7]:moveTo(posXiso - 16, 120 + posYiso)
isoMap [7][8]:moveTo(posXiso + 16, 120 + posYiso)
isoMap [6][9]:moveTo(posXiso + 48, 120 + posYiso)
isoMap [5][10]:moveTo(posXiso + 80, 120 + posYiso)
isoMap [4][11]:moveTo(posXiso + 112, 120 + posYiso)
isoMap [3][12]:moveTo(posXiso + 144, 120 + posYiso)
isoMap [2][13]:moveTo(posXiso + 176, 120 + posYiso)
isoMap [1][14]:moveTo(posXiso + 208, 120 + posYiso)



-- FILA 15


isoMap [15][1]:moveTo(posXiso - 224, 128 + posYiso)
isoMap [14][2]:moveTo(posXiso - 192, 128 + posYiso)
isoMap [13][3]:moveTo(posXiso - 160, 128 + posYiso)
isoMap [12][4]:moveTo(posXiso - 128, 128 + posYiso)
isoMap [11][5]:moveTo(posXiso - 96, 128 + posYiso)
isoMap [10][6]:moveTo(posXiso - 64, 128 + posYiso)
isoMap [9][7]:moveTo(posXiso -32, 128 + posYiso)
isoMap [8][8]:moveTo(posXiso , 128 + posYiso)
isoMap [7][9]:moveTo(posXiso  + 32, 128 + posYiso)
isoMap [6][10]:moveTo(posXiso + 64, 128 + posYiso)
isoMap [5][11]:moveTo(posXiso + 96, 128 + posYiso)
isoMap [4][12]:moveTo(posXiso + 128, 128 + posYiso)
isoMap [3][13]:moveTo(posXiso + 160, 128 + posYiso)
isoMap [2][14]:moveTo(posXiso + 192, 128 + posYiso)
isoMap [1][15]:moveTo(posXiso + 224, 128 + posYiso)


-- FILA 16


isoMap [16][1]:moveTo(posXiso - 240, 136 + posYiso)
isoMap [15][2]:moveTo(posXiso - 208, 136 + posYiso)
isoMap [14][3]:moveTo(posXiso - 176, 136 + posYiso)
isoMap [13][4]:moveTo(posXiso - 144, 136 + posYiso)
isoMap [12][5]:moveTo(posXiso - 112, 136 + posYiso)
isoMap [11][6]:moveTo(posXiso - 80, 136 + posYiso)
isoMap [10][7]:moveTo(posXiso - 48, 136 + posYiso)
isoMap [9][8]:moveTo(posXiso - 16, 136 + posYiso)
isoMap [8][9]:moveTo(posXiso + 16, 136 + posYiso)
isoMap [7][10]:moveTo(posXiso + 48, 136 + posYiso)
isoMap [6][11]:moveTo(posXiso + 80, 136 + posYiso)
isoMap [5][12]:moveTo(posXiso + 112, 136 + posYiso)
isoMap [4][13]:moveTo(posXiso + 144, 136 + posYiso)
isoMap [3][14]:moveTo(posXiso + 176, 136 + posYiso)
isoMap [2][15]:moveTo(posXiso + 208, 136 + posYiso)
isoMap [1][16]:moveTo(posXiso + 240, 136 + posYiso)



-- FILA 17

isoMap [16][2]:moveTo(posXiso - 224, 144 + posYiso)
isoMap [15][3]:moveTo(posXiso - 192, 144 + posYiso)
isoMap [14][4]:moveTo(posXiso - 160, 144 + posYiso)
isoMap [13][5]:moveTo(posXiso - 128, 144 + posYiso)
isoMap [12][6]:moveTo(posXiso - 96, 144 + posYiso)
isoMap [11][7]:moveTo(posXiso - 64, 144 + posYiso)
isoMap [10][8]:moveTo(posXiso - 32, 144 + posYiso)
isoMap [9][9]:moveTo(posXiso, 144 + posYiso)
isoMap [8][10]:moveTo(posXiso + 32, 144 + posYiso)
isoMap [7][11]:moveTo(posXiso + 64, 144 + posYiso)
isoMap [6][12]:moveTo(posXiso + 96, 144 + posYiso)
isoMap [5][13]:moveTo(posXiso + 128, 144 + posYiso)
isoMap [4][14]:moveTo(posXiso + 160, 144 + posYiso)
isoMap [3][15]:moveTo(posXiso + 192, 144 + posYiso)
isoMap [2][16]:moveTo(posXiso + 224, 144 + posYiso)


-- FILA 18

isoMap [16][3]:moveTo(posXiso - 208, 152 + posYiso)
isoMap [15][4]:moveTo(posXiso - 176, 152 + posYiso)
isoMap [14][5]:moveTo(posXiso - 144, 152 + posYiso)
isoMap [13][6]:moveTo(posXiso - 112, 152 + posYiso)
isoMap [12][7]:moveTo(posXiso - 80, 152 + posYiso)
isoMap [11][8]:moveTo(posXiso - 48, 152 + posYiso)
isoMap [10][9]:moveTo(posXiso - 16, 152 + posYiso)
isoMap [9][10]:moveTo(posXiso + 16, 152 + posYiso)
isoMap [8][11]:moveTo(posXiso + 48, 152 + posYiso)
isoMap [7][12]:moveTo(posXiso + 80, 152 + posYiso)
isoMap [6][13]:moveTo(posXiso + 112, 152 + posYiso)
isoMap [5][14]:moveTo(posXiso + 144, 152 + posYiso)
isoMap [4][15]:moveTo(posXiso + 176, 152 + posYiso)
isoMap [3][16]:moveTo(posXiso + 208, 152 + posYiso)


-- FILA 19

isoMap [16][4]:moveTo(posXiso - 192, 160 + posYiso)
isoMap [15][5]:moveTo(posXiso - 160, 160 + posYiso)
isoMap [14][6]:moveTo(posXiso - 128, 160 + posYiso)
isoMap [13][7]:moveTo(posXiso - 96, 160 + posYiso)
isoMap [12][8]:moveTo(posXiso - 64, 160 + posYiso)
isoMap [11][9]:moveTo(posXiso - 32, 160 + posYiso)
isoMap [10][10]:moveTo(posXiso, 160 + posYiso)
isoMap [9][11]:moveTo(posXiso + 32, 160 + posYiso)
isoMap [8][12]:moveTo(posXiso + 64, 160 + posYiso)
isoMap [7][13]:moveTo(posXiso + 96, 160 + posYiso)
isoMap [6][14]:moveTo(posXiso + 128, 160 + posYiso)
isoMap [5][15]:moveTo(posXiso + 160, 160 + posYiso)
isoMap [4][16]:moveTo(posXiso + 192, 160 + posYiso)


-- FILA 20

isoMap [16][5]:moveTo(posXiso - 176, 168 + posYiso)
isoMap [15][6]:moveTo(posXiso - 144, 168 + posYiso)
isoMap [14][7]:moveTo(posXiso - 112, 168 + posYiso)
isoMap [13][8]:moveTo(posXiso - 80, 168 + posYiso)
isoMap [12][9]:moveTo(posXiso - 48, 168 + posYiso)
isoMap [11][10]:moveTo(posXiso - 16, 168 + posYiso)
isoMap [10][11]:moveTo(posXiso + 16, 168 + posYiso)
isoMap [9][12]:moveTo(posXiso + 48, 168 + posYiso)
isoMap [8][13]:moveTo(posXiso + 80, 168 + posYiso)
isoMap [7][14]:moveTo(posXiso + 112, 168 + posYiso)
isoMap [6][15]:moveTo(posXiso + 144, 168 + posYiso)
isoMap [5][16]:moveTo(posXiso + 176, 168 + posYiso)



-- FILA 21

isoMap [16][6]:moveTo(posXiso -  160, 176 + posYiso)
isoMap [15][7]:moveTo(posXiso - 128, 176 + posYiso)
isoMap [14][8]:moveTo(posXiso - 96, 176 + posYiso)
isoMap [13][9]:moveTo(posXiso - 64, 176 + posYiso)
isoMap [12][10]:moveTo(posXiso - 32, 176 + posYiso)
isoMap [11][11]:moveTo(posXiso , 176 + posYiso)
isoMap [10][12]:moveTo(posXiso + 32, 176 + posYiso)
isoMap [9][13]:moveTo(posXiso + 64, 176 + posYiso)
isoMap [8][14]:moveTo(posXiso + 96, 176 + posYiso)
isoMap [7][15]:moveTo(posXiso + 128, 176 + posYiso)
isoMap [6][16]:moveTo(posXiso + 160, 176 + posYiso)

-- FILA 22

isoMap [16][7]:moveTo(posXiso - 144, 184 + posYiso)
isoMap [15][8]:moveTo(posXiso - 112, 184 + posYiso)
isoMap [14][9]:moveTo(posXiso - 80, 184 + posYiso)
isoMap [13][10]:moveTo(posXiso - 48, 184 + posYiso)
isoMap [12][11]:moveTo(posXiso - 16, 184 + posYiso)
isoMap [11][12]:moveTo(posXiso + 16, 184 + posYiso)
isoMap [10][13]:moveTo(posXiso + 48, 184 + posYiso)
isoMap [9][14]:moveTo(posXiso + 80, 184 + posYiso)
isoMap [8][15]:moveTo(posXiso + 112, 184 + posYiso)
isoMap [7][16]:moveTo(posXiso + 144, 184 + posYiso)



-- FILA 23

isoMap [16][8]:moveTo(posXiso - 128, 192 + posYiso)
isoMap [15][9]:moveTo(posXiso - 96, 192 + posYiso)
isoMap [14][10]:moveTo(posXiso - 64, 192 + posYiso)
isoMap [13][11]:moveTo(posXiso - 32, 192 + posYiso)
isoMap [12][12]:moveTo(posXiso, 192 + posYiso)
isoMap [11][13]:moveTo(posXiso + 32, 192 + posYiso)
isoMap [10][14]:moveTo(posXiso + 64, 192 + posYiso)
isoMap [9][15]:moveTo(posXiso +  96, 192 + posYiso)
isoMap [8][16]:moveTo(posXiso + 128, 192 + posYiso)


-- FILA 24

isoMap [16][9]:moveTo(posXiso - 112, 200 + posYiso)
isoMap [15][10]:moveTo(posXiso - 80, 200 + posYiso)
isoMap [14][11]:moveTo(posXiso - 48, 200 + posYiso)
isoMap [13][12]:moveTo(posXiso - 16, 200 + posYiso)
isoMap [12][13]:moveTo(posXiso + 16, 200 + posYiso)
isoMap [11][14]:moveTo(posXiso + 48, 200 + posYiso)
isoMap [10][15]:moveTo(posXiso + 80, 200 + posYiso)
isoMap [9][16]:moveTo(posXiso + 112, 200 + posYiso)

-- FILA 25

isoMap [16][10]:moveTo(posXiso - 96 , 208 + posYiso)
isoMap [15][11]:moveTo(posXiso - 64, 208 + posYiso)
isoMap [14][12]:moveTo(posXiso - 32, 208 + posYiso)
isoMap [13][13]:moveTo(posXiso, 208 + posYiso)
isoMap [12][14]:moveTo(posXiso + 32, 208 + posYiso)
isoMap [11][15]:moveTo(posXiso + 64, 208 + posYiso)
isoMap [10][16]:moveTo(posXiso + 96, 208 + posYiso)


-- FILA 22

isoMap [16][11]:moveTo(posXiso - 80, 216 + posYiso)
isoMap [15][12]:moveTo(posXiso - 48, 216 + posYiso)
isoMap [14][13]:moveTo(posXiso - 16, 216 + posYiso)
isoMap [13][14]:moveTo(posXiso + 16, 216 + posYiso)
isoMap [12][15]:moveTo(posXiso + 48, 216 + posYiso)
isoMap [11][16]:moveTo(posXiso + 80, 216 + posYiso)



-- FILA 23

isoMap [16][12]:moveTo(posXiso - 64, 224 + posYiso)
isoMap [15][13]:moveTo(posXiso - 32, 224 + posYiso)
isoMap [14][14]:moveTo(posXiso, 224 + posYiso)
isoMap [13][15]:moveTo(posXiso + 32, 224 + posYiso)
isoMap [12][16]:moveTo(posXiso + 64, 224 + posYiso)

-- FILA 24

isoMap [16][13]:moveTo(posXiso - 48, 232 + posYiso)
isoMap [15][14]:moveTo(posXiso - 16, 232 + posYiso)
isoMap [14][15]:moveTo(posXiso + 16, 232 + posYiso)
isoMap [13][16]:moveTo(posXiso + 48, 232 + posYiso)



-- FILA 25

isoMap [16][14]:moveTo(posXiso - 32, 240 + posYiso)
isoMap [15][15]:moveTo(posXiso, 240 + posYiso)
isoMap [14][16]:moveTo(posXiso + 32, 240 + posYiso)

-- FILA 26


isoMap [16][15]:moveTo(posXiso - 16, 248 + posYiso)
isoMap [15][16]:moveTo(posXiso + 16, 248 + posYiso)

-- FILA 27

isoMap [16][16]:moveTo(posXiso, 256 + posYiso)


-- FIN DE LA CONSTRUCCION DE LA MATRIZ ISOMETRICA

-- Se revisa donde se deben poner los eficios

end



-- L SYSTEM FUNCTIONS

-- ORIGEN

function origenTile()

  currentXPosition = xOriginPos
  currentYPosition = yOriginPos

  --print("ORIGEN ".. currentXPosition.." "..currentYPosition)

end


-- SAVE POSITION

function saveTile()

  xCenterPos = currentXPosition
  yCenterPos = currentYPosition

  --print("SAVED ".. currentXPosition.." "..currentYPosition)

end

-- LOAD POSITION

function loadTile()

  currentXPosition = xCenterPos
  currentYPosition = yCenterPos

  --print("LOADED ".. currentXPosition.." "..currentYPosition)

end

function centralTile()

  --print("CENTRAL TILE Current Position ".. currentXPosition.." "..currentYPosition)

  normalMap [currentXPosition ][currentYPosition] = "H"

end



function upTile()
  
  -- Va hacia ARRIBA
  
  currentXPosition = currentXPosition - 1
  
  --print("UP TILE Current Position ".. currentXPosition.." "..currentYPosition)
  
  normalMap [currentXPosition ][currentYPosition] = "B"

  end



-- DOWN


function downTile()
  

  -- Va hacia ARRIBA
  
  currentXPosition = currentXPosition + 1
  
  --print("DOWN TILE Current Position ".. currentXPosition.." "..currentYPosition)
  
  normalMap [currentXPosition ][currentYPosition] = "B"

  end


-- RIGHT

    function rightTile()
  

      -- Va hacia la DERECHA
    
      currentYPosition = currentYPosition + 1
    
     -- print("RIGHT TILE Current Position ".. currentXPosition.." "..currentYPosition)
      
      normalMap [currentXPosition ][currentYPosition] = "D"

    
    
      end
 

      -- LEFT

    function leftTile()
  

      -- Va hacia la IZQUIERDA
    
      currentYPosition = currentYPosition - 1
    
    --  print("LEFT TILE Current Position ".. currentXPosition.." "..currentYPosition)

      normalMap [currentXPosition ][currentYPosition] = "D"


    
      end

-- NORMAL BUILDINGS (short ones)

      function building()


      -- Pone un Edificio en el fin del camino 

      if  previousAxiom  == "LT" then 

        currentYPosition = currentYPosition - 2

        normalMap [currentXPosition ][currentYPosition] = "K"
     
        normalMap [currentXPosition - 1 ][currentYPosition - 1] = "J"
           
        normalMap [currentXPosition ][currentYPosition - 1] = "J"
       
        normalMap [currentXPosition + 1 ][currentYPosition - 1] = "J"
     
      
        normalMap [currentXPosition - 1 ][currentYPosition ] = "J"
         
        normalMap [currentXPosition + 1 ][currentYPosition ] = "J"
   
        normalMap [currentXPosition - 1 ][currentYPosition + 1 ] = "J"
            
        normalMap [currentXPosition + 1][currentYPosition + 1 ] = "J"
       
        normalMap [currentXPosition ][currentYPosition + 1 ] = "J"

        end

   
      if  previousAxiom  == "RT" then 
 
        
        currentYPosition = currentYPosition + 2

        normalMap [currentXPosition ][currentYPosition] = "K"
     
        normalMap [currentXPosition - 1 ][currentYPosition - 1] = "J"
           
        normalMap [currentXPosition ][currentYPosition - 1] = "J"
       
        normalMap [currentXPosition + 1 ][currentYPosition - 1] = "J"
     
      
        normalMap [currentXPosition - 1 ][currentYPosition ] = "J"
         
        normalMap [currentXPosition + 1 ][currentYPosition ] = "J"
   
        normalMap [currentXPosition - 1 ][currentYPosition + 1 ] = "J"
            
        normalMap [currentXPosition + 1][currentYPosition + 1 ] = "J"

       normalMap [currentXPosition ][currentYPosition + 1 ] = "J"
       
      

      end


    end

      -- SPECIAL BUILDING (larger ones on the sides)

      function specialBuilding()


        -- Pone un Edificio en el fin del camino 
  
        if  previousAxiom  == "LT" then 
  
          currentYPosition = currentYPosition - 2
  
          normalMap [currentXPosition ][currentYPosition] = "L"
  
        
          end
  
    
        if  previousAxiom  == "RT" then 
  
          currentYPosition = currentYPosition + 2
  
          normalMap [currentXPosition ][currentYPosition] = "L"
  
  
        end
  
        end

      -- SQUARE

      function square()


        -- Pone una Plaza  en el fin del camino 

  
        if  previousAxiom  == "LT" then 
  
        

            -- Pone los tiles de la plaza grande

            normalMap [currentXPosition ][currentYPosition -1 ] = "S9"
            normalMap [currentXPosition  ][currentYPosition -2 ] = "S0"
            normalMap [currentXPosition + 2][currentYPosition -2 ] = "S2"
            normalMap [currentXPosition + 2][currentYPosition -3 ] = "S1"
            normalMap [currentXPosition + 2][currentYPosition -1 ] = "S13"
            normalMap [currentXPosition + 2][currentYPosition ] = "S3"
            
            normalMap [currentXPosition - 2][currentYPosition -3 ] = "S4"
            normalMap [currentXPosition - 2][currentYPosition -1] = "S5"
            normalMap [currentXPosition - 2][currentYPosition -2] = "S5"
            normalMap [currentXPosition - 2][currentYPosition ] = "S6"

            normalMap [currentXPosition ][currentYPosition - 3] = "S7"
            normalMap [currentXPosition ][currentYPosition] = "S8"
            normalMap [currentXPosition +1][currentYPosition - 3] = "S7"
            
            normalMap [currentXPosition -1][currentYPosition - 3] = "S7"

            normalMap [currentXPosition + 1 ][currentYPosition] = "S8"
            normalMap [currentXPosition - 1 ][currentYPosition] = "S8"

            normalMap [currentXPosition +1 ][currentYPosition -2 ] = "S12"
            normalMap [currentXPosition +1 ][currentYPosition -1 ] = "S11"

            normalMap [currentXPosition -1 ][currentYPosition -2 ] = "S10"
            normalMap [currentXPosition -1 ][currentYPosition -1 ] = "S12"

          end
  
    
        if  previousAxiom  == "RT" then 
  
     

            -- Pone los tiles de la plaza chica

            normalMap [currentXPosition ][currentYPosition +2 ] = "S0"
            normalMap [currentXPosition + 1][currentYPosition + 1 ] = "S1"
            normalMap [currentXPosition + 1][currentYPosition + 2 ] = "S2"
            normalMap [currentXPosition +1 ][currentYPosition + 3] = "S3"
            normalMap [currentXPosition -1][currentYPosition + 1 ] = "S4"
            normalMap [currentXPosition - 1][currentYPosition + 2 ] = "S5"
            normalMap [currentXPosition -1][currentYPosition + 3] = "S6"
            normalMap [currentXPosition ][currentYPosition + 1 ] = "S7"
            normalMap [currentXPosition ][currentYPosition + 3] = "S8"

         
        end
  
        end
  

-- CUBE TILES VISUALISATION 

function moveCube(rowToMove, colToMove, cubeLimit, cubeDirection, incremento)

-- Obtiene la posición X e Y del tile a desplazar 

  tileposX = isoMap [rowToMove][colToMove].x

  tileposY = isoMap [rowToMove][colToMove].y


  if (cubeDirection == "up") and (cubeLimit  ~= tileposY ) then
  
-- Incrementa en Y la posición del tile de la misma columna fila en 1 a 16 (valor del indice del for)

  isoMap [rowToMove][colToMove]:moveTo(tileposX, tileposY - incremento) 


 -- print ("CUBO UP "..tileposY)

  end


  if (cubeDirection == "down") and (cubeLimit ~= tileposY) then

-- Incrementa en Y la posición del tile de la misma columna fila en 1 a 16 (valor del indice del for)

 isoMap [rowToMove][colToMove]:moveTo(tileposX, tileposY + incremento) 

--print ("CUBO DOWN "..tileposY)

  end

end

 
function volcado()

-- VOLCADO DE LA MATRIZ 2D y a la Matriz ISOMETRICA

for i = 1, 16 do
  
  for j = 1, 16 do
    
   if normalMap [i][j] == "A" then         
  
    tileImage = gfx.image.new("/isoimages/A.png")

   end
  
   if normalMap [i][j] == "B" then         

    tileImage = gfx.image.new("/isoimages/B.png")
   end

   if normalMap [i][j] == "C" then         
   
    tileImage = gfx.image.new("/isoimages/C.png")
   end

   if normalMap [i][j] == "D" then         
   
    tileImage = gfx.image.new("/isoimages/D.png")
   end

   if normalMap [i][j] == "E" then         

    tileImage = gfx.image.new("/isoimages/E.png")
   end

   if normalMap [i][j] == "F" then         
 
    tileImage = gfx.image.new("/isoimages/F.png")
   end

   if normalMap [i][j] == "G" then         
   
    tileImage = gfx.image.new("/isoimages/G.png")

   end

   if normalMap [i][j] == "H" then         
   
    tileImage = gfx.image.new("/isoimages/H.png")
    
   end

   if normalMap [i][j] == "K" then         

    tileImage = gfx.image.new("/isoimages/K.png")

   end

   if normalMap [i][j] == "J" then         
   
    tileImage = gfx.image.new("/isoimages/J.png")

   end

   if normalMap [i][j] == "T" then         

     tileImage = gfx.image.new("/isoimages/T.png")
 
    end

    if normalMap [i][j] == "N" then         

      tileImage = gfx.image.new("/isoimages/N.png")
  
     end

   if normalMap [i][j] == "S0" then         
  
    tileImage = gfx.image.new("/isoimages/S0.png")

   end

   if normalMap [i][j] == "S1" then         
   
    tileImage = gfx.image.new("/isoimages/S1.png")
   
  end


   if normalMap [i][j] == "S2" then         
   
    tileImage = gfx.image.new("/isoimages/S2.png")

   end

   if normalMap [i][j] == "S3" then         
  
    tileImage = gfx.image.new("/isoimages/S3.png")

   end


   if normalMap [i][j] == "S4" then         

    tileImage = gfx.image.new("/isoimages/S4.png")

   end

   if normalMap [i][j] == "S5" then         
 
    tileImage = gfx.image.new("/isoimages/S5.png")
   end

   if normalMap [i][j] == "S6" then         

    tileImage = gfx.image.new("/isoimages/S6.png")
   end

   if normalMap [i][j] == "S7" then         
  
    tileImage = gfx.image.new("/isoimages/S7.png")

   end  
   
   if normalMap [i][j] == "S8" then         

    tileImage = gfx.image.new("/isoimages/S8.png")

   end

    if normalMap [i][j] == "S9" then         
   
      tileImage = gfx.image.new("/isoimages/S9.png")
  
     end

     if normalMap [i][j] == "S10" then         
   
      tileImage = gfx.image.new("/isoimages/S10.png")
  
     end
   
     if normalMap [i][j] == "S11" then         
   
      tileImage = gfx.image.new("/isoimages/S11.png")
  
     end

     if normalMap [i][j] == "S12" then         
   
      tileImage = gfx.image.new("/isoimages/S12.png")
  
     end

     if normalMap [i][j] == "S13" then         
   
      tileImage = gfx.image.new("/isoimages/S13.png")
  
     end

   isoMap [i][j] = gfx.sprite.new(tileImage)

   isoMap [i][j]: setCenter(.5,.5)
   isoMap [i][j]: setZIndex(5)

   isoMap [i][j]:add()

  columna = columna + 32
  
  end

  fila = fila + 32
  columna = 0

end


end


-- VOLCADO DE EDIFICIOS 

function buildingCreation()

-- Se lee la matriz normalMap, donde hay un element  K  o L se debe poner un eficio. K = edificio normal L = edificio grande

  for i = 1, 16 do
  
    for j = 1, 16 do
      
     if normalMap [i][j] == "K" then 
    
        buildingPositionX = isoMap [i][j].x
        buildingPositionY = isoMap [i][j].y
       
 
        -- Usa la funcion edificio para crear un sprite de edificio, pasando la ubicacion de tile cube correspondiente

        edificio(buildingPositionX, buildingPositionY)


        end


        if normalMap [i][j] == "L" then 
    
          buildingPositionX = isoMap [i][j].x
          buildingPositionY = isoMap [i][j].y
  
   
          -- Usa la funcion edificio para crear un sprite de edificio especial , pasando la ubicacion de tile cube correspondiente
  
          specialEdificio(buildingPositionX, buildingPositionY)
  
  
          end

                  end

                  end

end


  function squareDecoration()

-- Se lee la matriz isometrica, donde hay un element S0  se debe poner un monumento de plaza 

--print ("SQUARE DECORATION")

  for h= 1, 16 do
  
    for k = 1, 16 do
      
     if normalMap [h][k] == "S0" then 
    
                squarePositionX = isoMap [h][k].x
                squarePositionY = isoMap [h][k].y
                monumentType="S0" 
                squareMonuments(squarePositionX, squarePositionY, monumentType ) 

                                 end


    if normalMap [h][k] == "S9" then 
    
                squarePositionX = isoMap [h][k].x
                squarePositionY = isoMap [h][k].y
                monumentType="S9" 

                squareMonuments(squarePositionX, squarePositionY, monumentType) 
              
                                end


     if normalMap [h][k] == "S10" then 
                  squarePositionX = isoMap [h][k].x
                  squarePositionY = isoMap [h][k].y
                  monumentType="S10" 
  
                  squareMonuments(squarePositionX, squarePositionY, monumentType) 
                
                                  end
  
     if normalMap [h][k] == "S11" then 
                  squarePositionX = isoMap [h][k].x
                  squarePositionY = isoMap [h][k].y
                  monumentType="S11" 
                    
                 squareMonuments(squarePositionX, squarePositionY, monumentType) 
                                  
                                  end

                                    
     if normalMap [h][k] == "S12" then 
                squarePositionX = isoMap [h][k].x
                squarePositionY = isoMap [h][k].y
                monumentType="S12" 
        
                squareMonuments(squarePositionX, squarePositionY, monumentType) 
                      
                      end

     if normalMap [h][k] == "S13" then 
                 squarePositionX = isoMap [h][k].x
                 squarePositionY = isoMap [h][k].y
                 monumentType="S13" 
                
                  squareMonuments(squarePositionX, squarePositionY, monumentType) 
                              
                              end

   end

end

end



-- TREES

function treesCreation()


  treesQuantity = 10

  for forest = 1, treesQuantity do

-- Elije un cube tile al azar y verifica que esté vacio

  possibleFreeTileX =  math.random( 2, 15 )
  possibleFreeTileY =  math.random( 2, 15 )

-- If the tile cube is free (G) then put a tree on that tile cube


if (normalMap [ possibleFreeTileX ][possibleFreeTileY] == "G") then
  
  -- Chequeo de las diagonales 

   if (normalMap [ possibleFreeTileX + 1][possibleFreeTileY -1 ] == "G") and (normalMap [ possibleFreeTileX -1  ][possibleFreeTileY +1 ] == "G") then

   if (normalMap [ possibleFreeTileX - 1][possibleFreeTileY -1 ] == "G") and (normalMap [ possibleFreeTileX +1  ][possibleFreeTileY +1 ] == "G") then


  -- Chequeo de las adyacentes

  if (normalMap [ possibleFreeTileX ][possibleFreeTileY -1 ] == "G") and (normalMap [ possibleFreeTileX ][possibleFreeTileY +1 ] == "G") then

  if (normalMap [ possibleFreeTileX - 1][possibleFreeTileY ] == "G") and (normalMap [ possibleFreeTileX + 1  ][possibleFreeTileY ] == "G") then
    
-- This are the good ones:


     normalMap [ possibleFreeTileX ][possibleFreeTileY] = "T"
     
     treeSprite [forest]: moveTo(isoMap [ possibleFreeTileX ][possibleFreeTileY].x, (isoMap [ possibleFreeTileX ][possibleFreeTileY].y -32 )+ 254)


-- Dependiendo de las coordenadas Y de donde el arbol haya caido debera tener un diferente valor de ZIndex

   limiteZ = (isoMap [ possibleFreeTileX ][possibleFreeTileY].y -32 + 254)

    if   limiteZ  <= 50 then  treeSprite[forest]: setZIndex(5) end

    if   (limiteZ > 50)  and  (limiteZ <= 150) then treeSprite[forest]: setZIndex(15) end
    
    if   limiteZ  > 150 then  treeSprite[forest]: setZIndex(30) end

 
end
end
end
end
end

end

end -- de la function




function fallingBuildings(nroEdificioAbajar, buildingSpeedFalling)

  -- Hace descender los eficios desde la posicion de Limbo -200 a su correcta ubicacion determinada por el Axiom
  -- Cada eficios tiene una configuracion diferente de tamanio, se selecciona segun corresponda

--edificioSprite[nroEdificioAbajar]: moveTo( edificioAttribute[nroEdificioAbajar][2], edificioSprite[nroEdificioAbajar].y + buildingSpeedFalling)
edificioSprite[nroEdificioAbajar]: moveWithCollisions( edificioAttribute[nroEdificioAbajar][2], edificioSprite[nroEdificioAbajar].y + buildingSpeedFalling)
end

function fallingMonuments(nroMonumentoAbajar, monumentSpeedFalling)

  -- Hace descender los monumentos y adornos desde la posicion de Limbo -200 a su correcta ubicacion determinada por el Axiom
  -- Cada monumento tiene una configuracion diferente de tamanio, se selecciona segun corresponda

  squareSprite [nroMonumentoAbajar]: moveTo( squareAttribute[nroMonumentoAbajar][2], squareSprite [nroMonumentoAbajar].y + monumentSpeedFalling)

end


--score:moveTo(410, 10)


----------------------------------------
--SUN timer
----------------------------------------

function timerCallback()

  if (sunStart) then  mark += 1 end
  
    if mark >= 5 then
      sunUISprite:moveTo(sunUISprite.x, sunUISprite.y - 6)
      backgroundSprite:moveTo(backgroundSprite.x, backgroundSprite.y -2)
   -- print ("Sol"..sunUISprite.y)
    end

    if sunUISprite.y <= 40 then sunUISprite:setZIndex(0) end
    if sunUISprite.y <= 80 then sunUISprite:setZIndex(3) end

    if mark >= 30 then 
   
      sunUISprite: changeState("shining")
      gameOver = true
      --print ("GAME OVER")
     sunStart = false 
    end
      

   -- print (mark)


end



-- LLAMADO AL  INIT 

init ()


score:moveTo(410, 0)

-----------------------------------------
-- UPDATE START
-----------------------------------------


function playdate.update()


-- LEVEL ISO TILES PLACEMENT

fallingCubes()

-- BUIDLING PLACEMENT 1-4 BUILDINGS

-- Baja los edificios del limbo (-200) al nivel del cubo tile que le corresponda segun el axiom. Para eso el piso ya
-- debe estar creado en su lugar y cada edificio baja de a una vez, segun el valor de edificioAttribute[nroEdificio]
-- Si el valor de edificioAttribute[nroEdificio] es true, puede bajar.
-- Como cada edificio tiene un tamanio diferente el punto de contacto se calcula a partir del height del sprite /2 ya
-- que el pivot esta en el centro de edificio y del cubo tile

if (floorReady) then

  if (edificioSprite[1].y)  ~=  ((edificioAttribute[1][4]) - (edificioSprite[1].height/2)) then fallingBuildings(1,2) end
 
  if (edificioSprite[2].y)  ~=  ((edificioAttribute[2][4]) - (edificioSprite[2].height/2)) then fallingBuildings(2,2) end

  if (edificioSprite[3].y)  ~=  ((edificioAttribute[3][4]) - (edificioSprite[3].height/2)) then fallingBuildings(3,2) end

  if (edificioSprite[4].y)  ~=  ((edificioAttribute[4][4]) - (edificioSprite[4].height/2)) then fallingBuildings(4,2) end

  --print (squareSprite[1].y)
  --print (squareAttribute[1][4])
 
  if (squareSprite[1].y)  ~=  ((squareAttribute[1][4]) - (squareSprite[1].height/2)) then fallingMonuments(1,4) end
  if (squareSprite[2].y)  ~=  ((squareAttribute[2][4]) - (squareSprite[2].height/2)) then fallingMonuments(2,2) end
  if (squareSprite[3].y)  ~=  ((squareAttribute[3][4]) - (squareSprite[3].height/2)) then fallingMonuments(3,2) end
  if (squareSprite[4].y)  ~=  ((squareAttribute[4][4]) - (squareSprite[4].height/2)) then fallingMonuments(4,2) end
  if (squareSprite[5].y)  ~=  ((squareAttribute[5][4]) - (squareSprite[3].height/2)) then fallingMonuments(5,2) end
  if (squareSprite[6].y)  ~=  ((squareAttribute[6][4]) - (squareSprite[4].height/2)) then fallingMonuments(6,2) end
  if (squareSprite[7].y)  ~=  ((squareAttribute[7][4]) - (squareSprite[4].height/2)) then fallingMonuments(7,2) end

  -- Verifica que el ultimo objeto haya sido posicionado para mostrar los arboles, una vez que se ponen todos los arboles la
  -- variable treesReady se pone en false para evitar que se repita el proceso cada vez que pasa por el update

  if (squareSprite[7].y)  >=  ((squareAttribute[7][4]) - (squareSprite[4].height/2)) and (treesReady) then 

    -- Solo se animan las arboles habilitados cuya cantidad esta en nroTrees



    for i = 1, 10  do
  
      treeSpeed = math.random( 1, 3 )
      treeSprite [i]:changeState("plop"..treeSpeed)
      treesReady = false


       -- Si ya se han colocado todos los arboles hace entrar al player en la pantalla

      enterPlayer = true
      carsInPlace = true

               end
 
              end
   
                
-- PUT THE CAR

-- CARS

  -- Choose a set of free spots to put the car on 

if (carsInPlace) then 

  carSpot= math.random( 1, 4 )

  if carSpot == 1 then 
  carPossibleFreeTileX =  10
  carPossibleFreeTileY =  2
  carZindex = 30
  print(carSpot)
  end

  if carSpot == 2 then 
  carPossibleFreeTileX =  15
  carPossibleFreeTileY =  15
  carZindex = 30
  print(carSpot)
  end


  if carSpot == 3 then 
  carPossibleFreeTileX =  15
  carPossibleFreeTileY =  10
  carZindex = 30
  print(carSpot)
  end

  if carSpot == 4 then 
  carPossibleFreeTileX =  10
  carPossibleFreeTileY =  13
  carZindex = 7
  print(carSpot)
  end

  -- Then checks if the spot is  free, if so puts a car on it

  parkCar(carPossibleFreeTileX , carPossibleFreeTileY , carZindex) 
  
  carsInPlace = false

end



     -- Se hace ingresar el sprite por la derecha de la pantalla hasta la posicion de destino. Luego se activan los controles y el nivel


     if (enterPlayer) then
        

     
      if (playerSprite.x) >= playerInitialPosX then 


       playerSprite: moveWithCollisions(playerSprite.x - 2, playerInitialPosY) 
     
      
      end

    end

end



-- LEVEL START 


-- Player is in place, a new level can start

if (playerSprite.x) == playerInitialPosX then 
      
        levelReady = true 

        -- Se setea enterPlayer en false para que no se modifique su valor y no vuelva a entrar en enterPlayer

        enterPlayer = false


--INITIAL WIND CONDITIONS 
-- Genera la direccion del viento 1 = Right to Left - 2 = Left to Right

if initialWindCondition == false then 


  windDirection = math.random(1, 2)
 
  if windDirection == 1 then 
    
    windSpeed = 0.6


    roosterUISprite: changeState("turnLeft") 
  
  else
    
    windSpeed = -0.6


    roosterUISprite: changeState("turnRight") end

  end

  initialWindCondition = true

end

-- Se chequea que todo esté listo para comenzar el nivel 

if (levelReady) then 

-- CLOUD IS FORCED TO GO UP



if goingUp <= 10 then 

   playerSprite: moveWithCollisions(playerSprite.x , playerSprite.y - goingUp) 

   attitudeUIUp(0.05)

  goingUp += 1 

   end

   -- Press A button To Start message displays
  

   if not lineAnimatorStartTitle:ended() then
    
    thunderUISprite: changeState("charging")
    
    pressStartUISprite: moveTo(lineAnimatorStartTitle:currentValue()) end
    
  

-- MAIN LOOP STARTS

-- PEOPLE WALKING AROUND
-- Walking people: generate paths and set people in


if (characterIsWalking == false) then

pathForPeople()

-- GUY 1

guyAttribute[1][2] = isoMap [ startingFreeTileX ] [ startingFreeTileY ].x -- Posicion de origen X
guyAttribute[1][3] = isoMap [ startingFreeTileX ] [ startingFreeTileY ].y -- Posicion de origen Y

guyAttribute[1][4] = destinationPathX 
guyAttribute[1][5] = destinationPathY

guyAttribute[1][6] = walkSpeed
guyAttribute[1][7] = animationIda
guyAttribute[1][8] = animationVuelta

guySprite[1]: moveTo(guyAttribute[1][2], guyAttribute[1][3])


lineSegmentGo = pd.geometry.lineSegment.new(guyAttribute[1][2] , guyAttribute[1][3] , guyAttribute[1][4] , guyAttribute[1][5])
lineAnimatorGo = gfx.animator.new(guyAttribute[1][6], lineSegmentGo)

  
-- GUY 2

pathForPeople()

guyAttribute[2][2] = isoMap [ startingFreeTileX ] [ startingFreeTileY ].x -- Posicion de origen X
guyAttribute[2][3] = isoMap [ startingFreeTileX ] [ startingFreeTileY ].y -- Posicion de origen Y

guyAttribute[2][4] = destinationPathX 
guyAttribute[2][5] = destinationPathY

guyAttribute[2][6] = walkSpeed
guyAttribute[2][7] = animationIda
guyAttribute[2][8] = animationVuelta

guySprite[2]: moveTo(guyAttribute[2][2], guyAttribute[2][3])


lineSegmentGo2 = pd.geometry.lineSegment.new(guyAttribute[2][2] , guyAttribute[2][3] , guyAttribute[2][4] , guyAttribute[2][5])
lineAnimatorGo2 = gfx.animator.new(guyAttribute[2][6], lineSegmentGo2)


characterIsWalking = true


end



if (characterIsWalking) then

  -- Checks if Character has been killed by the cloud, if not they start walking around

if (character1IsDead) then

 

else
  

   -- Once the path is calculated the characters can move around 
  

   
  if (viajeIda1) then
    
   guySprite[1]: changeState(guyAttribute[1][7])
  
   if not lineAnimatorGo:ended() then guySprite [1]: moveTo(lineAnimatorGo:currentValue()) 
  
          else 

    lineSegmentBack = pd.geometry.lineSegment.new(guyAttribute[1][4] , guyAttribute[1][5], guyAttribute[1][2] , guyAttribute[1][3])
    lineAnimatorBack = gfx.animator.new( guyAttribute[1][6] , lineSegmentBack)

    viajeIda1 = false
  
           end


  end
  

  if (viajeIda1) == false then
    
    guySprite[1]: changeState(guyAttribute[1][8])

    if not lineAnimatorBack:ended() then guySprite [1]: moveTo(lineAnimatorBack:currentValue())

    else

      lineSegmentGo = pd.geometry.lineSegment.new(guyAttribute[1][2] , guyAttribute[1][3] , guyAttribute[1][4] , guyAttribute[1][5])
      lineAnimatorGo = gfx.animator.new(guyAttribute[1][6], lineSegmentGo)
      viajeIda1 = true


    end

  end

end -- of CHARACTER 1 IS DEAD

 
-- Checks if Character 2 has been killed by the cloud, if not they start walking around

if (character2IsDead) then


else


  if (viajeIda2) then
    


   guySprite[2]: changeState(animationIda)
  
   if not lineAnimatorGo2:ended() then guySprite[2]: moveTo(lineAnimatorGo2:currentValue())  

   else

  
    lineSegmentBack2 = pd.geometry.lineSegment.new(guyAttribute[2][4] , guyAttribute[2][5], guyAttribute[2][2] , guyAttribute[2][3])
    lineAnimatorBack2 = gfx.animator.new( guyAttribute[2][6] , lineSegmentBack2)

    viajeIda2 = false


  end

  end

 if (viajeIda2) == false then
    
    guySprite[2]: changeState(animationVuelta)

    if not lineAnimatorBack2:ended() then guySprite [2]: moveTo(lineAnimatorBack2:currentValue())

    else

      lineSegmentGo2 = pd.geometry.lineSegment.new(guyAttribute[2][2] , guyAttribute[2][3] , guyAttribute[2][4] , guyAttribute[2][5])
      lineAnimatorGo2 = gfx.animator.new(guyAttribute[2][6], lineSegmentGo2)
      viajeIda2 = true


    end

  end

end

end -- of CHARACTER 2 IS DEAD

-- END OF WALKING GUYS


-- WAIT FOR BUTTON TO START LEVEL 


if pd.buttonIsPressed(pd.kButtonA) and (gameStart == false) then 
  
  pressStartUISprite: remove()

    -- Remove title sprites 
    logoUISprite: remove()
    thunderUISprite: remove()
    creditsUISprite: remove()

    -- Remove frame borders

    mainScreenSpriteUp : remove()

    -- Put some UI elements up front

    score:moveTo(410, 10)
    roosterUISprite: setZIndex(100)
    powerAttackUISprite: setZIndex(102)
    lifeTimerUISprite: setZIndex(100)
    weatherUISprite: setZIndex(100)


  cameraUp = true end


-- SUBE LA CAMARA HASTA DONDE ESTA LA NUBE PLAYER

if (cameraUp) and (posYScroll <= 180) then posYScroll += 1  end

attitudeUIUp(0.05)

pd.graphics.setDrawOffset(posXScroll , posYScroll)

if posYScroll >= 100 then

  cameraUp = false
  gameStart = true
  sunStart = true



  --print ("CLOUD POSITIO X "..playerSprite.x)
  --print ("CLOUD POSITIO y "..playerSprite.y)

  -- REACTIVATE ALL COLLISIONS FOR BUILDINGS


  for i = 1, 4 do 

    edificioSprite [i] : setCollisionsEnabled(true)
    
    end
    
    for i = 1, 10 do
    treeSprite [i]: setCollisionsEnabled(true)
    end


    playerSprite:setCollisionsEnabled(false)

  -- SETS THE CLOUD CORE


    
end


-- GAME IS ON!


if (gameStart == true) then

-- DISPLAYS THE SCORE 

-- KEYBOARD INPUT FOR SCROLL UP AND DOWN

-- El valor que permite subir y bajar el scroll es controlado por la variable posYiso que va de 1 a limiteScroll 
-- cuando sube mas que n solo puede voler a bajar  y viceverza

-- FALLING DOWN
-- PLAYER CLOUD is loosing attitude constantly


playerSprite: moveWithCollisions(playerSprite.x + windSpeed, playerSprite.y + fallingDownSpeed)

  -- Also actualises the Attitude Marker on the UI

  attitudeUIDown(0.1)

-- CAMERA FOLLOWS PLAYER

-- Recalculates camera position conforming the player position

 --fallingDownSpeed += 0.001

--posXScroll = posXScroll - windSpeed

--pd.graphics.setDrawOffset( posXScroll, posYScroll) 

-- PLAYER LIMIT TO LEFT AND RIGHT

if playerSprite.x >= 300 then windSpeed = -0.6 end

if playerSprite.x <= 100 then windSpeed = 0.6 end

-- PLAYER LIMIT DOWN 



if (gameOver) then
  
  playerSprite: changeState("dead")
  

  -- wait for game over message


  playdate.timer.performAfterDelay(3500, function ()

    playerSprite:remove()

    gameOverUISprite: moveTo(150, 100)
   
 end)


   -- wait to reboot level 
   
 playdate.timer.performAfterDelay(15000, function ()

 

 reboot = true
 
end)

 -----------------------------------------
 -- IF REBOOT GAME IS TRUE GAME RESTARTS
 -----------------------------------------

if (reboot) then 
  
  local allTimers = pd.timer.allTimers()
  for _, timer in ipairs(allTimers) do timer:remove() end


  gfx.clear()


 gfx.sprite.removeAll()

 init()

end



end

-- PLAYER LIMIT UP


-- WIND PUSH
--[[
if pd.buttonJustPressed(pd.kButtonB)  then

  --attitudeUIUp(1)

  windDirection = math.random(1, 2)
  
   if windDirection == 1 then 
     
     windSpeed = 0.6
 

     roosterUISprite: changeState("turnLeft") 
   
   else
     
     windSpeed = -0.6

     roosterUISprite: changeState("turnRight") 
    
    end
 
   -- attitudeUIUp(1)

   end
 
--]]
-------------------------------
-- CLOUD ATTACKS
-------------------------------

   if pd.buttonJustPressed(pd.kButtonA) then

        -- Shows the current power attack of the selected attack

      if (currentPowerAttack == 0) then currentPowerAttack = 1 end

      currentEnergyAttack = powerAttack [currentPowerAttack][2]

    
       if (currentEnergyAttack > 1) and (currentEnergyAttack <=5) then
       
       if (attackReady) then 

      -- attitudeUIUp(3)

      -------------------------------------
      -- KIND OF ATTACK 
      -------------------------------------

      -- RAY POWER

      if  powerAttack [currentPowerAttack][1] == "rayPower" then 

      playerSprite: changeState("rays")
      
      ray (playerSprite.x, playerSprite.y , 1, 1)
      

      imagetable = gfx.image.new("/images8bit/UI/power/"..currentEnergyAttack)
  
      powerAttackUISprite: setImage(imagetable)

      powerAttack [currentPowerAttack][2] -= 1

      end

      -- RAIN POWER


      if  powerAttack [currentPowerAttack][1] == "rainPower" then 
        
        playerSprite: changeState("holdRain")

        rain (playerSprite.x, playerSprite.y , 1, 1)
        
        imagetable = gfx.image.new("/images8bit/UI/power/"..currentEnergyAttack)
    
        powerAttackUISprite: setImage(imagetable)
  
        powerAttack [currentPowerAttack][2] -= 1

      end


      -- WIND POWER


      if  powerAttack [currentPowerAttack][1] == "windPower" then 
        
        playerSprite: changeState("holdRain")

        imagetable = gfx.image.new("/images8bit/UI/power/"..currentEnergyAttack)
    
        powerAttackUISprite: setImage(imagetable)
  
        powerAttack [currentPowerAttack][2] -= 1

        windDirection = math.random(1, 2)
  
        if windDirection == 1 then 
          
          windSpeed = 0.6
      
     
          roosterUISprite: changeState("turnLeft") 

          -- Changes tree animations 
          for w= 1, 10 do  treeSprite [w]:changeState("blowLeft") end 


        else
          
          windSpeed = -0.6
     
          roosterUISprite: changeState("turnRight") 
            -- Changes tree animations 
            for w= 1, 10 do  treeSprite [w]:changeState("blowRight") end 
         
         end
      
    
      

      end

    
      end 

    end

  end

--[[
-------------------------------
-- UP & DOWN 
-------------------------------

if pd.buttonJustPressed(pd.kButtonUp)  then

print ("baja"..posYScroll)

 if posYScroll >= -20 then

 posYScroll -=5
 
 pd.graphics.setDrawOffset( posXScroll, posYScroll) 
end




end

-- UP & DOWN 
-------------------------------

if pd.buttonJustPressed(pd.kButtonDown)  then

  print ("sube"..posYScroll)

  if posYScroll <= 110 then 

  posYScroll +=5

  pd.graphics.setDrawOffset( posXScroll, posYScroll) 

    end


 
 --]]




-------------------------------
-- CRANK UP & DOWN 
-------------------------------

change, acceleratedChange = playdate.getCrankChange()

upJump = acceleratedChange / 40

--print (posYScroll) 

if (upJump > 0) and  (posYScroll <= scrollUpLimit ) then  
  attitudeUIUp(0.1)
  --print ("up".. posYScroll) 
  playerSprite: moveWithCollisions(playerSprite.x, playerSprite.y + 1)
  posYScroll += 1 

end


if (upJump < 0) and  (posYScroll >= scrollDownLimit ) then 
 -- attitudeUIDown(0.1)
  --print ("down"..posYScroll) 
  playerSprite: moveWithCollisions(playerSprite.x, playerSprite.y - 1)

  posYScroll -= 1

end


  
 

-------------------------------
-- SPECIAL POWERS ATTACKS
-------------------------------

if pd.buttonJustPressed(pd.kButtonUp)  then

  if currentPowerAttack == 9 then currentPowerAttack = 0 end
  
  currentPowerAttack += 1
   
  if currentPowerAttack < 10 then 
  
  -- Each time the button is pressed the power attacks changes from 1 to 9
  
  --print (powerAttack [currentPowerAttack] [1] .. " cantidad  " .. powerAttack [currentPowerAttack] [2]) 

  weatherUISprite:changeState(powerAttack [currentPowerAttack] [1])

  -- Shows de energy level for the current attack
  
  energyAttack =  powerAttack [currentPowerAttack][2]

  print (energyAttack)

  imagetable = gfx.image.new("/images8bit/UI/power/"..energyAttack)
  
  powerAttackUISprite: setImage(imagetable)

  end
  
  end -- if Button UP
  

-------------------------------
-- AVION ATTACK 
-------------------------------


if (playerSprite.y >=30) and (playerSprite.y <= 60) then 


if (sendPlane) then 

  -- Generates random plane 
  planeType = math.random(1,2)

if planeType == 1 then 
  plane() 
  sendPlane = false

end

if planeType == 2 then 
  biplane() 
  sendPlane = false

end


end

end


end


-- END MAIN LOOP


end


  gfx.sprite.update()
  pd.timer.updateTimers()
  playerSprite.collisionResponse = playerSpriteCollisionResponse
 -- playdate.drawFPS(0,0)

end



-- FIN DEL UPDATE
