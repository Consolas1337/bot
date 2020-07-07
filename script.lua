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


function findAround(range)
   for x, guid in pairs(lb.GetObjects(range,5)) do
      local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid)
      local playerPosX, playerPosY, playerPosZ = lb.ObjectPosition("player")
      local x1, y1, z1 = lb.ObjectPosition(guid)
      local distance = lb.GetDistance3D(playerPosX, playerPosY, playerPosZ, x1, y1, z1)

   
      --[[if not UnitIsEnemy("player", guid)  then
         print('Враг замечен')
         lb.UnitTagHandler(TargetUnit, guid)             таргетит и бьет врага
         lb.Unlock(CastSpellByName, 'Frostbolt')
      end]]--
      if UnitIsDead(guid) then
         print('чел мертв', type)
      else
         print('жив', type)
      end
      if lb.UnitIsLootable(guid) then
         if (distance > 2) then
            lb.Navigator.MoveTo(x1, y1, z1, 1)
         else
            lb.UnitTagHandler(TargetUnit, guid)
            lb.ObjectInteract(guid)
         end
      --print(type, npc_id, lb.ObjectType(guid), x1,y1,z1)
      end

   end
end
findAround(20)
--[[SomeFrame = CreateFrame("Frame", "SomeFrame", nil)
SomeFrame:SetScript("OnUpdate", findAround)]]--
