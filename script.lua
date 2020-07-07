print("---------")
print("Script started")

if (not lb.Navigator) then
   print("Load navigator")
   lb.LoadScript("TypescriptNavigator")
end

function GoTo(X,Y,Z)
   if not lb.Navigator then 
       print("Navigator is not loaded!") 
       return
   end
   local playerPosX, playerPosY, playerPosZ = lb.ObjectPosition("player")
   local distance = lb.GetDistance3D(playerPosX, playerPosY, playerPosZ, X, Y, Z)
   if distance > 2 then
       lb.Navigator.MoveTo(X, Y, Z, 1)
   end
end

function Update()
   GoTo(-9230.193, -107.940, 71.213)
end

SomeFrame = CreateFrame("Frame", "SomeFrame", nil)
SomeFrame:SetScript("OnUpdate", Update)

function findAround(range)
   for x, y in pairs(lb.GetObjects(range)) do
      print(x,y)
      local lockTypes = lb.GameObjectLockTypes(y) --Вот тут крч свойства можно как-то выуживать но я тут хз дальше
      print("-------")
   end
end

-- GoTo(-9155.133,-15.702,78.994)
print("End of script")










-- Functions

-- lb.NavMgr_MoveTo(x, y, z, targetId)
-- lb.Navigator.MoveTo(x, y, z, pathIndex)

-- TODO: pathIndex?????



-- function GoTo(X,Y,Z)
--    if (not lb.Navigator) then 
--       print("Navigator is not loaded!") 
--    end
--    -- lb.Navigator.MoveTo(X, Y, Z, 1)
--    print("Starting navigation")
--    startPosX, startPosY, startPosZ = lb.ObjectPosition("player")
--    print(startPosX, startPosY, startPosZ)
--    paths = lb.NavMgr_GetPath(startPosX, startPosY, startPosZ, X, Y, Z)

--    branch = 1
--    print("While started")
--    while (paths[branch] ~= nil) 
--    do
--       startPosX, startPosY, startPosZ = lb.ObjectPosition("player")
--       pathX["x"], pathY, pathZ = paths[branch]
--       distance = lb.GetDistance3D(startPosX, startPosY, startPosZ, pathX, pathY, pathZ)
--       if (distance < 1) then
--          branch = branch + 1
--          print("Changing angle...")
--       else
--          lb.MoveTo(pathX, pathY, pathZ)
--          print("Moving...")
--          break
--       end
--    end
--    print("func has been ended")
-- end



-- function GoTo(X,Y,Z)
--    if (not lb.Navigator) then 
--       print("Navigator is not loaded!") 
--    end
--    lb.Navigator.MoveTo(X, Y, Z, 1)
--    playerPosX, playerPosY, playerPosZ = lb.ObjectPosition("player")
--    distance = lb.GetDistance3D(playerPosX, playerPosY, playerPosZ, X, Y, Z)
--    while (distance > 2) 
--    do
--       playerPosX, playerPosY, playerPosZ = lb.ObjectPosition("player")
--       distance = lb.GetDistance3D(playerPosX, playerPosY, playerPosZ, X, Y, Z)
--    end
-- end

   -- while (MODE==1) 
   -- do
   --    x,y,z = lb.ObjectPosition('player')
   --    local distance = lb.GetDistance3D(x,y,z,-9155.133,-15.702,78.994)
   --    if (distance<=1) then
   --       print("reached!")
   --       break
   --    end
   -- end

-- for i, guid in ipairs(lb.GetObjects()) do
--    print(guid)
-- end

-- function getObjectTypes()
--    for name, id in pairs(lb.EGameObjectTypes) do
--       print(id, name)
--    end
-- end

-- function getObjectTypes()
--    for name, id in pairs(lb.ClientTypes) do
--       print(id, name)
--    end
-- end

-- while(not lb.Navigator)
-- do
-- ;
-- end

-- /run LB.Unlock(CastSpellByName, 'Огненный взрыв')
-- lb.Navigator.MoveTo(coords[1][1], coords[1][2], coords[1][3], 10)

-- while(1)
-- do
--    x=__LB__.ObjectPosition('player')[1]-coords[1][1]
--    y=__LB__.ObjectPosition('player')[2]-coords[1][2]
--    z=__LB__.ObjectPosition('player')[3]-coords[1][3]
--    print(x,y,z)
-- end

-- function Navigation:MoveToPosition(x, y, z)
--    if not lb.Navigator then return end    
--    return lb.Navigator.MoveTo(x, y, z, 1)
-- end
-- lb.NavMgr_MoveTo(-9726.102, -321.956, 52.995)
-- lb.NavMgr_MoveTo(-9699.689, -308.131, 55.567)

-- function Navigation:MoveToObjectRange(Object, Range)
--    if not lb.Navigator then return end

--    if lb.GetDistance3D("player", Object) < Range then
--        return lb.Navigator.Stop()
--    end

--    return self:GoTo(lb.ObjectPosition(Object))
-- end


--[[function findAround(range)
   for _, guid in ipairs(__LB__.GetObjects(100, __LB__.ObjectTypes.EGameObject)) do
      local lockTypes = __LB__.GameObjectLockTypes(guid)
      if lockTypes then
          for _, lockType in ipairs(lockTypes) do
              print('Guid:', guid, 'LockType:', lockType)
          end
      end
   end
end

findAround(15)]]--

function findAround(range)
   for x, guid in pairs(lb.GetObjects(range,5)) do
      local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid)
      local playerPosX, playerPosY, playerPosZ = lb.ObjectPosition("player")
      local x1, y1, z1 = lb.ObjectPosition(guid)
      local distance = lb.GetDistance3D(playerPosX, playerPosY, playerPosZ, x1, y1, z1)

      

      if not(UnitIsDead(guid)) then
         --print(x, type, npc_id, lb.ObjectType(guid), x1,y1,z1)
         lb.Unlock(TargetUnit, guid)
       --  lb.Unlock(CastSpellByName, "Frostbolt")
      end

      if (lb.UnitIsLootable(guid) and UnitIsDead(guid)) then
         if (distance > 2) then
            lb.Navigator.MoveTo(x1, y1, z1, 1)
         else
            TargetUnit(guid)
            lb.ObjectInteract(guid)
         end
      --print(type, npc_id, lb.ObjectType(guid), x1,y1,z1)
      end

      

      --[[if lb.UnitIsLootable(guid) then
         print("колв-во предметов у " , npc_id , GetNumLootItems())
      end]]--
   end
end
findAround(50)
--[[SomeFrame = CreateFrame("Frame", "SomeFrame", nil)
SomeFrame:SetScript("OnUpdate", findAround)]]--


-- Functions

-- lb.NavMgr_MoveTo(x, y, z, targetId)
-- lb.Navigator.MoveTo(x, y, z, pathIndex)

-- TODO: pathIndex?????
