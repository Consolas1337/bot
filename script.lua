print("---------")
print("Script started")

if (not lb.Navigator) then
   print("Load navigator")
   lb.LoadScript("TypescriptNavigator")
end
-- while(not lb.Navigator)
-- do
-- ;
-- end


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