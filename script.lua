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


function sort_alg(a, b)
   return a[2] < b[2]
end

function get_enemies(range)
   list = {}
   local playerPosX, playerPosY, playerPosZ = lb.ObjectPosition("player")

   for _, guid in pairs(lb.GetObjects(range, 5)) do
      if (lb.UnitTagHandler(UnitIsEnemy, guid)) then
         print("add enemy")
         if (not lb.UnitTagHandler(UnitIsDead, guid)) then
            print("add not dead") 
            local enemyPosX, enemyPosY, enemyPosZ = lb.ObjectPosition(guid)
            local distance = lb.GetDistance3D(playerPosX, playerPosY, playerPosZ, enemyPosX, enemyPosY, enemyPosZ)
            table.insert(list, {guid, distance})
         end
      end
   end
  table.sort(list, sort_alg)
  print("Function is complete!")
  print(table.getn(list).." units added")
  return list
end


function findAround()
   if table.getn(list) == 0 then
      get_enemies(50)
   end
   for i, k in pairs(list) do
      guid = k[1]
      distance = k[2]
      if not UnitIsEnemy("player", guid) then
         print('Враг замечен')
         lb.UnitTagHandler(TargetUnit, guid) 
         if UnitIsDead("target") then
            if lb.UnitIsLootable(guid) then
               if (distance > 2) then
                  lb.Navigator.MoveTo(x1, y1, z1, 1)
               else
                  lb.UnitTagHandler(TargetUnit, guid)
                  lb.ObjectInteract(guid)
               end
            --print(type, npc_id, lb.ObjectType(guid), x1,y1,z1)
            end
         else 
         lb.Unlock(CastSpellByName, 'Frostbolt')
         end
      end 
   end
end
SomeFrame = CreateFrame("Frame", "SomeFrame", nil)
SomeFrame:SetScript("OnUpdate", findAround)
