print("---------")
print("Script started")

if (not lb.Navigator) then
   print("Load navigator")
   lb.LoadScript("TypescriptNavigator")
end

function findAround()
   for x, guid in pairs(lb.GetObjects(100,5)) do
      local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid)
      lb.UnitTagHandler(TargetUnit, guid)
      local playerPosX, playerPosY, playerPosZ = lb.ObjectPosition("player")
      local x1, y1, z1 = lb.ObjectPosition(guid)
      local distance = lb.GetDistance3D(playerPosX, playerPosY, playerPosZ, x1, y1, z1)
      if (lb.UnitTagHandler(UnitIsEnemy, guid)) then
         --lb.UnitTagHandler(TargetUnit, guid)

         if distance > 30 then
            lb.Navigator.MoveTo(x1, y1, z1, 1)
         end

function sort_alg(a, b)
   return a[2] < b[2]
end


         if (lb.UnitTagHandler(UnitIsDead, guid) and lb.UnitIsLootable("target")) then
            if (distance > 2) then
               lb.Navigator.MoveTo(x1, y1, z1, 1)
            else
               --lb.UnitTagHandler(TargetUnit, guid)
               lb.ObjectInteract(guid)
            end
         end
      end
   end
end

SomeFrame = CreateFrame("Frame", "SomeFrame", nil)
SomeFrame:SetScript("OnUpdate", findAround)


