local pd <const> = playdate
local gfx <const> = pd.graphics


function fallingCubes()

  speed = 32

    moveCube(16,16, tileFloor, "down", speed)

    
    if isoMap [16][16].y == tileFloor  then 
    
      moveCube(16,15, tileFloor - 8, "down",speed)
      moveCube(15,16, tileFloor - 8, "down",speed)

    end
    
    speed = 32

    if isoMap [16][15].y == tileFloor - 8 then 
        
      moveCube(16,14, tileFloor - 16, "down",speed)
      moveCube(15,15, tileFloor - 16, "down",speed)
      moveCube(14,16, tileFloor - 16, "down",speed)

    end
    


    if isoMap [16][14].y == tileFloor - 16 then 
    
      moveCube(16,13, tileFloor - 24, "down",speed)
      moveCube(15,14, tileFloor - 24, "down",speed)
      moveCube(14,15, tileFloor - 24, "down",speed)
      moveCube(13,16, tileFloor - 24, "down",speed)
    end
    
      
    if isoMap [16][13].y == tileFloor - 24 then 
    
      moveCube(16,12, tileFloor - 32, "down",speed)
      moveCube(15,13, tileFloor - 32, "down",speed)
      moveCube(14,14, tileFloor - 32, "down",speed)
      moveCube(13,15, tileFloor - 32, "down",speed)
      moveCube(12,16, tileFloor - 32, "down",speed)
    
    end
    
    

    speed = 32

    if isoMap [16][12].y == tileFloor - 32 then 
    
      moveCube(16,11, tileFloor - 40, "down",speed)
      moveCube(15,12, tileFloor - 40, "down",speed)
      moveCube(14,13, tileFloor - 40, "down",speed)
      moveCube(13,14, tileFloor - 40, "down",speed)
      moveCube(12,15, tileFloor - 40, "down",speed)
      moveCube(11,16, tileFloor - 40, "down",speed)
       
    end
    
    
    if isoMap [16][11].y == tileFloor - 40 then 
    
      moveCube(16,10, tileFloor - 48, "down",speed)
      moveCube(15,11, tileFloor - 48, "down",speed)
      moveCube(14,12, tileFloor - 48, "down",speed)
      moveCube(13,13, tileFloor - 48, "down",speed)
      moveCube(12,14, tileFloor - 48, "down",speed)
      moveCube(11,15, tileFloor - 48, "down",speed)
      moveCube(10,16, tileFloor - 48, "down",speed)
    
    end
    
    
    if isoMap [16][10].y == tileFloor - 48 then 
    
      
    
      moveCube(16,9,  tileFloor - 56, "down",speed)
      moveCube(15,10, tileFloor - 56, "down",speed)
      moveCube(14,11, tileFloor - 56, "down",speed)
      moveCube(13,12, tileFloor - 56, "down",speed)
      moveCube(12,13, tileFloor - 56, "down",speed)
      moveCube(11,14, tileFloor - 56, "down",speed)
      moveCube(10,15, tileFloor - 56, "down",speed)
      moveCube(9,16,  tileFloor - 56, "down",speed)
    
    end
    
    
    if isoMap [16][9].y == tileFloor - 56 then 
    
      moveCube(16,8,  tileFloor - 64, "down",speed)
      moveCube(15,9,  tileFloor - 64, "down",speed)
      moveCube(14,10, tileFloor - 64, "down",speed)
      moveCube(13,11, tileFloor - 64, "down",speed)
      moveCube(12,12, tileFloor - 64, "down",speed)
      moveCube(11,13, tileFloor - 64, "down",speed)
      moveCube(10,14, tileFloor - 64, "down",speed)
      moveCube(9,15,  tileFloor - 64, "down",speed)
      moveCube(8,16,  tileFloor - 64, "down",speed)
    
    end
     
    speed = 32
    
    if isoMap [16][8].y == tileFloor - 64 then 
    
    
      moveCube(16,7,  tileFloor - 72, "down",speed)
      moveCube(15,8,  tileFloor - 72, "down",speed)
      moveCube(14,9,  tileFloor - 72, "down",speed)
      moveCube(13,10, tileFloor - 72, "down",speed)
      moveCube(12,11, tileFloor - 72, "down",speed)
      moveCube(11,12, tileFloor - 72, "down",speed)
      moveCube(10,13, tileFloor - 72, "down",speed)
      moveCube(9,14,  tileFloor - 72, "down",speed)
      moveCube(8,15,  tileFloor - 72, "down",speed)
      moveCube(7,16,  tileFloor - 72, "down",speed)
    
    end
    
    
    if isoMap [16][7].y == tileFloor - 72 then 
    
      moveCube(16,6,  tileFloor - 80, "down",speed)
      moveCube(15,7,  tileFloor - 80, "down",speed)
      moveCube(14,8,  tileFloor - 80, "down",speed)
      moveCube(13,9,  tileFloor - 80, "down",speed)
      moveCube(12,10, tileFloor - 80, "down",speed)
      moveCube(11,11, tileFloor - 80, "down",speed)
      moveCube(10,12, tileFloor - 80, "down",speed)
      moveCube(9,13,  tileFloor - 80, "down",speed)
      moveCube(8,14,  tileFloor - 80, "down",speed)
      moveCube(7,15,  tileFloor - 80, "down",speed)
      moveCube(6,16,  tileFloor - 80, "down",speed)
    
    end
    
    if isoMap [16][6].y == tileFloor - 80 then 
    
      moveCube(16,5,  tileFloor - 88, "down",speed)
      moveCube(15,6,  tileFloor - 88, "down",speed)
      moveCube(14,7,  tileFloor - 88, "down",speed)
      moveCube(13,8,  tileFloor - 88, "down",speed)
      moveCube(12,9,  tileFloor - 88, "down",speed)
      moveCube(11,10, tileFloor - 88, "down",speed)
      moveCube(10,11, tileFloor - 88, "down",speed)
      moveCube(9,12,  tileFloor - 88, "down",speed)
      moveCube(8,13,  tileFloor - 88, "down",speed)
      moveCube(7,14,  tileFloor - 88, "down",speed)
      moveCube(6,15,  tileFloor - 88, "down",speed)
      moveCube(5,16,  tileFloor - 88, "down",speed)
    
    end
    
    if isoMap [16][5].y == tileFloor - 88 then 
    
      moveCube(16,4,  tileFloor - 96, "down",speed)
      moveCube(15,5,  tileFloor - 96, "down",speed)
      moveCube(14,6,  tileFloor - 96, "down",speed)
      moveCube(13,7,  tileFloor - 96, "down",speed)
      moveCube(12,8,  tileFloor - 96, "down",speed)
      moveCube(11,9,  tileFloor - 96, "down",speed)
      moveCube(10,10, tileFloor - 96, "down",speed)
      moveCube(9,11,  tileFloor - 96, "down",speed)
      moveCube(8,12,  tileFloor - 96, "down",speed)
      moveCube(7,13,  tileFloor - 96, "down",speed)
      moveCube(6,14,  tileFloor - 96, "down",speed)
      moveCube(5,15,  tileFloor - 96, "down",speed)
      moveCube(4,16,  tileFloor - 96, "down",speed)
    
    end
    
    if isoMap [16][4].y == tileFloor - 96 then 
    
     
    
      moveCube(16,3,  tileFloor - 104, "down",speed)
      moveCube(15,4,  tileFloor - 104, "down",speed)
      moveCube(14,5,  tileFloor - 104, "down",speed)
      moveCube(13,6,  tileFloor - 104, "down",speed)
      moveCube(12,7,  tileFloor - 104, "down",speed)
      moveCube(11,8,  tileFloor - 104, "down",speed)
      moveCube(10,9,  tileFloor - 104, "down",speed)
      moveCube(9,10,  tileFloor - 104, "down",speed)
      moveCube(8,11,  tileFloor - 104, "down",speed)
      moveCube(7,12,  tileFloor - 104, "down",speed)
      moveCube(6,13,  tileFloor - 104, "down",speed)
      moveCube(5,14,  tileFloor - 104, "down",speed)
      moveCube(4,15,  tileFloor - 104, "down",speed)
      moveCube(3,16,  tileFloor - 104, "down",speed)
    
    end
    
    
    if isoMap [16][3].y == tileFloor - 104 then 
    
      moveCube(16,2,  tileFloor - 112, "down",speed)
      moveCube(15,3,  tileFloor - 112, "down",speed)
      moveCube(14,4,  tileFloor - 112, "down",speed)
      moveCube(13,5,  tileFloor - 112, "down",speed)
      moveCube(12,6,  tileFloor - 112, "down",speed)
      moveCube(11,7,  tileFloor - 112, "down",speed)
      moveCube(10,8,  tileFloor - 112, "down",speed)
      moveCube(9,9,   tileFloor - 112, "down",speed)
      moveCube(8,10,  tileFloor - 112, "down",speed)
      moveCube(7,11,  tileFloor - 112, "down",speed)
      moveCube(6,12,  tileFloor - 112, "down",speed)
      moveCube(5,13,  tileFloor - 112, "down",speed)
      moveCube(4,14,  tileFloor - 112, "down",speed)
      moveCube(3,15,  tileFloor - 112, "down",speed)
      moveCube(2,16,  tileFloor - 112, "down",speed)
    
    end
    

    speed = 64


    if isoMap [16][2].y == tileFloor - 112 then 
    
      moveCube(16,1,  tileFloor - 120, "down",speed)
      moveCube(15,2,  tileFloor - 120, "down",speed)
      moveCube(14,3,  tileFloor - 120, "down",speed)
      moveCube(13,4,  tileFloor - 120, "down",speed)
      moveCube(12,5,  tileFloor - 120, "down",speed)
      moveCube(11,6,  tileFloor - 120, "down",speed)
      moveCube(10,7,  tileFloor - 120, "down",speed)
      moveCube(9,8,   tileFloor - 120, "down",speed)
      moveCube(8,9,   tileFloor - 120, "down",speed)
      moveCube(7,10,  tileFloor - 120, "down",speed)
      moveCube(6,11,  tileFloor - 120, "down",speed)
      moveCube(5,12,  tileFloor - 120, "down",speed)
      moveCube(4,13,  tileFloor - 120, "down",speed)
      moveCube(3,14,  tileFloor - 120, "down",speed)
      moveCube(2,15,  tileFloor - 120, "down",speed)
      moveCube(1,16,  tileFloor - 120, "down",speed)
    
      
    end
    
    if isoMap [16][1].y == tileFloor - 120 then 
    
      moveCube(15,1,  tileFloor - 128, "down",speed)
      moveCube(14,2,  tileFloor - 128, "down",speed)
      moveCube(13,3,  tileFloor - 128, "down",speed)
      moveCube(12,4,  tileFloor - 128, "down",speed)
      moveCube(11,5,  tileFloor - 128, "down",speed)
      moveCube(10,6,  tileFloor - 128, "down",speed)
      moveCube(9,7,   tileFloor - 128, "down",speed)
      moveCube(8,8,   tileFloor - 128, "down",speed)
      moveCube(7,9,   tileFloor - 128, "down",speed)
      moveCube(6,10,  tileFloor - 128, "down",speed)
      moveCube(5,11,  tileFloor - 128, "down",speed)
      moveCube(4,12,  tileFloor - 128, "down",speed)
      moveCube(3,13,  tileFloor - 128, "down",speed)
      moveCube(2,14,  tileFloor - 128, "down",speed)
      moveCube(1,15,  tileFloor - 128, "down",speed)
    
    end
    
    if isoMap [15][1].y == tileFloor - 128 then 
    
      moveCube(14,1,  tileFloor - 136, "down",speed)
      moveCube(13,2,  tileFloor - 136, "down",speed)
      moveCube(12,3,  tileFloor - 136, "down",speed)
      moveCube(11,4,  tileFloor - 136, "down",speed)
      moveCube(10,5,  tileFloor - 136, "down",speed)
      moveCube(9,6,   tileFloor - 136, "down",speed)
      moveCube(8,7,   tileFloor - 136, "down",speed)
      moveCube(7,8,   tileFloor - 136, "down",speed)
      moveCube(6,9,   tileFloor - 136, "down",speed)
      moveCube(5,10,  tileFloor - 136, "down",speed)
      moveCube(4,11,  tileFloor - 136, "down",speed)
      moveCube(3,12,  tileFloor - 136, "down",speed)
      moveCube(2,13,  tileFloor - 136, "down",speed)
      moveCube(1,14,  tileFloor - 136, "down",speed)
    
    end
    
     
    if isoMap [14][1].y == tileFloor - 136 then 
    
      moveCube(13,1,  tileFloor - 144, "down",speed)
      moveCube(12,2,  tileFloor - 144, "down",speed)
      moveCube(11,3,  tileFloor - 144, "down",speed)
      moveCube(10,4,  tileFloor - 144, "down",speed)
      moveCube(9,5,   tileFloor - 144, "down",speed)
      moveCube(8,6,   tileFloor - 144, "down",speed)
      moveCube(7,7,   tileFloor - 144, "down",speed)
      moveCube(6,8,   tileFloor - 144, "down",speed)
      moveCube(5,9,   tileFloor - 144, "down",speed)
      moveCube(4,10,  tileFloor - 144, "down",speed)
      moveCube(3,11,  tileFloor - 144, "down",speed)
      moveCube(2,12,  tileFloor - 144, "down",speed)
      moveCube(1,13,  tileFloor - 144, "down",speed)
    
    end
    
    if isoMap [13][1].y == tileFloor - 144 then 
    
      moveCube(12,1,  tileFloor - 152, "down",speed)
      moveCube(11,2,  tileFloor - 152, "down",speed)
      moveCube(10,3,  tileFloor - 152, "down",speed)
      moveCube(9,4,   tileFloor - 152, "down",speed)
      moveCube(8,5,   tileFloor - 152, "down",speed)
      moveCube(7,6,   tileFloor - 152, "down",speed)
      moveCube(6,7,   tileFloor - 152, "down",speed)
      moveCube(5,8,   tileFloor - 152, "down",speed)
      moveCube(4,9,   tileFloor - 152, "down",speed)
      moveCube(3,10,  tileFloor - 152, "down",speed)
      moveCube(2,11,  tileFloor - 152, "down",speed)
      moveCube(1,12,  tileFloor - 152, "down",speed)
    
    end
    
    
    if isoMap [12][1].y == tileFloor - 152 then 
    
      moveCube(11,1,  tileFloor - 160, "down",speed)
      moveCube(10,2,  tileFloor - 160, "down",speed)
      moveCube(9,3,   tileFloor - 160, "down",speed)
      moveCube(8,4,   tileFloor - 160, "down",speed)
      moveCube(7,5,   tileFloor - 160, "down",speed)
      moveCube(6,6,   tileFloor - 160, "down",speed)
      moveCube(5,7,   tileFloor - 160, "down",speed)
      moveCube(4,8,   tileFloor - 160, "down",speed)
      moveCube(3,9,   tileFloor - 160, "down",speed)
      moveCube(2,10,  tileFloor - 160, "down",speed)
      moveCube(1,11,  tileFloor - 160, "down",speed)

    end
    
    
    
    if isoMap [11][1].y == tileFloor - 160 then 
    
      moveCube(10,1,  tileFloor - 168, "down",speed)
      moveCube(9,2,   tileFloor - 168, "down",speed)
      moveCube(8,3,   tileFloor - 168, "down",speed)
      moveCube(7,4,   tileFloor - 168, "down",speed)
      moveCube(6,5,   tileFloor - 168, "down",speed)
      moveCube(5,6,   tileFloor - 168, "down",speed)
      moveCube(4,7,   tileFloor - 168, "down",speed)
      moveCube(3,8,   tileFloor - 168, "down",speed)
      moveCube(2,9,   tileFloor - 168, "down",speed)
      moveCube(1,10,  tileFloor - 168, "down",speed)
    
    end
    
    if isoMap [10][1].y == tileFloor - 168 then 
    
      moveCube(9,1,   tileFloor - 176, "down",speed)
      moveCube(8,2,   tileFloor - 176, "down",speed)
      moveCube(7,3,   tileFloor - 176, "down",speed)
      moveCube(6,4,   tileFloor - 176, "down",speed)
      moveCube(5,5,   tileFloor - 176, "down",speed)
      moveCube(4,6,   tileFloor - 176, "down",speed)
      moveCube(3,7,   tileFloor - 176, "down",speed)
      moveCube(2,8,   tileFloor - 176, "down",speed)
      moveCube(1,9,   tileFloor - 176, "down",speed)
    
    end
    
    
      if isoMap [9][1].y == tileFloor - 176 then 
    
      moveCube(8,1,   tileFloor - 184, "down",speed)
      moveCube(7,2,   tileFloor - 184, "down",speed)
      moveCube(6,3,   tileFloor - 184, "down",speed)
      moveCube(5,4,   tileFloor - 184, "down",speed)
      moveCube(4,5,   tileFloor - 184, "down",speed)
      moveCube(3,6,   tileFloor - 184, "down",speed)
      moveCube(2,7,   tileFloor - 184, "down",speed)
      moveCube(1,8,   tileFloor - 184, "down",speed)



      end
    
    
      if isoMap [8][1].y == tileFloor - 184 then 
    
      moveCube(7,1,   tileFloor - 192, "down",speed)
      moveCube(6,2,   tileFloor - 192, "down",speed)
      moveCube(5,3,   tileFloor - 192, "down",speed)
      moveCube(4,4,   tileFloor - 192, "down",speed)
      moveCube(3,5,   tileFloor - 192, "down",speed)
      moveCube(2,6,   tileFloor - 192, "down",speed)
      moveCube(1,7,   tileFloor - 192, "down",speed)
    
      end
    
      --speed = 32

    if isoMap [7][1].y == tileFloor - 192 then 
    
      moveCube(6,1,   tileFloor - 200, "down",speed)
      moveCube(5,2,   tileFloor - 200, "down",speed)
      moveCube(4,3,   tileFloor - 200, "down",speed)
      moveCube(3,4,   tileFloor - 200, "down",speed)
      moveCube(2,5,   tileFloor - 200, "down",speed)
      moveCube(1,6,   tileFloor - 200, "down",speed)
    
    end
    
    if isoMap [6][1].y == tileFloor - 200 then 
    
      moveCube(5,1,   tileFloor - 208, "down",speed)
      moveCube(4,2,   tileFloor - 208, "down",speed)
      moveCube(3,3,   tileFloor - 208, "down",speed)
      moveCube(2,4,   tileFloor - 208, "down",speed)
      moveCube(1,5,   tileFloor - 208, "down",speed)
    
    end
    
    if isoMap [5][1].y == tileFloor - 208 then 
    
      moveCube(4,1,   tileFloor - 216, "down",speed)
      moveCube(3,2,   tileFloor - 216, "down",speed)
      moveCube(2,3,   tileFloor - 216, "down",speed)
      moveCube(1,4,   tileFloor - 216, "down",speed)
    
    end
    
    
    if isoMap [4][1].y == tileFloor - 216 then 
    
      moveCube(3,1,   tileFloor - 224, "down",speed)
      moveCube(2,2,   tileFloor - 224, "down",speed)
      moveCube(1,3,   tileFloor - 224, "down",speed)
    
    end
    
    if isoMap [3][1].y == tileFloor - 224 then 
    
      moveCube(2,1,   tileFloor - 232, "down",speed)
      moveCube(1,2,   tileFloor - 232, "down",speed)

    
    end
    
    if isoMap [2][1].y == tileFloor - 232 then 
    
      moveCube(1,1,   tileFloor - 240, "down",speed)
    
    end

    -- If all the cubes are set in position, then the floor is ready and buildings can start falling down
    
    if isoMap [1][1].y == 16 then  floorReady = true end

end


