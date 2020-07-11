print("Script started")
if (not lb.Navigator) then
   lb.LoadScript("TypescriptNavigator")
   print("Navigator loaded")
end

PRECISION = 2
MODE = 1
LOOT_FINDING_RANGE = 30
PATH = {
    {-570.279,  -316.950, 269.366, "1"},
    {-447.442, -325.829, 268.730, "2"},
    {-442.452, -368.761, 269.240, "3"},
    {-532.746, -375.154, 269.120, "4"}, 
    {-640.084, -396.635, 268.789, "5"}, 
    {-609.768, -328.620, 268.803, "6"}, 
    {-711.097, -399.384, 268.768, "7"}, 
    {-670.993, -422.877, 268.769, "8"}, 
    {-703.780, -441.262, 269.148, "9(boss)"}, 
    {-575.234, -504.128, 276.597, "10"}, 
    {-573.173, -504.215, 276.597, "11"}, 
    {-566.032, -471.564, 276.597, "12"}, 
    {-533.368, -484.164, 276.867, "13"}, 
    {-478.677, -487.920, 271.912, "14"}, 
    {-474.526, -559.717, 271.908, "15"}, 
    {-532.378, -578.262, 276.866, "16"}, 
    {-568.749, -555.944, 276.597, "17"}, 
    {-703.550, -607.683, 268.766, "18(boss)"}, 
    {-680.677, -646.186, 268.767, "19"}, 
    {-653.442, -726.783, 269.119, "20"}, 
    {-618.234, -724.752, 268.768, "21"},
    {-639.021, -665.334, 268.768, "22"}, 
    {-532.344, -690.429, 269.120, "23"}, 
    {-451.156, -670.666, 269.120, "24"}, 
    {-420.305, -680.318, 267.498, "25"}, 
    {-404.426, -671.638, 266.333, "26(boss)"}, 
    {-478.599, -740.425, 268.768, "27"}, 
    {-559.014, -746.119, 268.768, "28"}, 
    {-726.532, -792.138, 232.439, "29"}, 
    {-776.793, -824.259, 233.232, "30(boss)"}, 
    {-731.865, -870.378, 232.495, "31"}, 
}
EXCLUDE_NPC = {
    39900,
    39450,
    42608,
    39390,
    42495,
    42496,
}
INCLUDE_NPC = 40177

local function sort_alg(a, b)
    return a[2] < b[2]
end
 
local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    
    return false
end

local function has_boss(tab, val)
    for index, value in ipairs(tab) do
        if lb.ObjectId(value[1]) == val then
            return true
        end
    end
    
    return false
end

function get_enemies(range)
    local list = {}
    local posX, posY, posZ = lb.ObjectPosition("player")
 
    for _, guid in pairs(lb.GetObjects(range, 5)) do
        if (lb.UnitTagHandler(UnitIsEnemy, guid) and (not lb.UnitTagHandler(UnitIsDead, guid)) and (not has_value(EXCLUDE_NPC, lb.ObjectId(guid)))) then
            local enemyPosX, enemyPosY, enemyPosZ = lb.ObjectPosition(guid)
            local distance = lb.GetDistance3D(posX, posY, posZ, enemyPosX, enemyPosY, enemyPosZ)
            table.insert(list, {guid, distance})
        end
    end
   table.sort(list, sort_alg)
   print("Найдено "..table.getn(list).." врагов. ИДУ БИТЬ ЕБУЧКУ!!!")
   return list
end

function get_loot()
    local loot_list = {}
    local posX, posY, posZ = lb.ObjectPosition("player")

    for _, guid in pairs(lb.GetObjects(LOOT_FINDING_RANGE)) do
        if lb.UnitIsLootable(guid) then
            local lootPosX, lootPosY, lootPosZ = lb.ObjectPosition(guid)
            local loot_distance = lb.GetDistance3D(posX, posY, posZ, lootPosX, lootPosY, lootPosZ)
            table.insert(loot_list, {guid, loot_distance})
        end
    end
   table.sort(loot_list, sort_alg)
   print("Найдено "..table.getn(loot_list).." точек лута")
   return loot_list
end



function boss_action(range)
    list = get_enemies(range)
    loot_list = get_loot()
    if (table.getn(list) > 0 or table.getn(loot_list) > 0) then

        if table.getn(loot_list) > 0 then
            local lootX, lootY, lootZ = lb.ObjectPosition(loot_list[1][1])
            if (loot_list[1][2] < 5) then
                lb.ObjectInteract(loot_list[1][1])
            else
                lb.MoveTo(lootX, lootY, lootZ)
            end

        elseif table.getn(list) > 0 then
            lb.UnitTagHandler(TargetUnit, list[1][1])
            state = IsCurrentAction(2)
            _, duration = GetSpellCooldown('Жар преисподней')

            if (list[1][2] > 5) then
                local enemyPosX, enemyPosY, enemyPosZ = lb.ObjectPosition(list[1][1])
                lb.MoveTo(enemyPosX, enemyPosY, enemyPosZ)
            else 
                if (state == false) then 
                    print("автоатака")
                    lb.Unlock(CastSpellByName, 'Автоматическая атака') 
                end
                if (duration == 0) then 
                    print("каст спелла")
                    lb.Unlock(CastSpellByName, 'Жар преисподней') 
                end
            end
        end
    else
        MODE = MODE + 1
    end
end

function go_dungenon()
    if not lb.Navigator then
        print("Navigator is not loaded!")
        return
    end

    local X = PATH[MODE][1]
    local Y = PATH[MODE][2]
    local Z = PATH[MODE][3]

    local playerPosX, playerPosY, playerPosZ = lb.ObjectPosition("player")
    local distance = lb.GetDistance3D(playerPosX, playerPosY, playerPosZ, X, Y, Z)
    if (distance > PRECISION) then
        if (MODE == 10) then 
            boss_action(30) 
        elseif (MODE > 12) and (MODE <18) then
            list_stage_12 = get_enemies(20)
            if  has_boss(list_stage_12, INCLUDE_NPC) then
                boss_action(30) ---неработает
            end

        else  
            lb.Navigator.MoveTo(X, Y, Z, 1)
        end
    else
        MODE = MODE + 1
        print("Going to: "..PATH[MODE][4])
    end

end

SomeFrame = CreateFrame("Frame", "SomeFrame", nil)
SomeFrame:SetScript("OnUpdate", go_dungenon)
-- SomeFrame:SetScript("OnUpdate", nil)

--40177


-- if (MODE == 11) then
--     lb.Unlock(CastSpellByName, 'Жар преисподней')
--     for i, guid in ipairs(lb.GetObjects(20)) do
--         print(guid)
--         if (lb.UnitIsLootable(guid)) then 
--             print("Вижу лут!")
--             lb.ObjectInteract(guid)
--         end
--     end
-- end
-- if (UnitIsEnemy("player", guid)) then
--     print("Enemy found!")
--     lb.Unlock(TargetUnit, lb.UnitTarget('target'))
--     lb.Unlock(CastSpellByName, 'Автоматическая атака')
--     local x, y, z = lb.ObjectPosition(guid)
--     lb.Navigator.MoveTo(x, y, z, 1)
-- end
--  lb.ObjectId('player')




-- if (UnitIsEnemy("player", guid)) then
--     print("Enemy found!")
--     lb.Unlock(TargetUnit,"player")
--     lb.Unlock(CastSpellByName, 'Автоматическая атака')
--     local x, y, z = lb.ObjectPosition(guid)
--     lb.Navigator.MoveTo(x, y, z, 1)
-- end

-- -570.279,-316.950,269.366
-- -447.442,-325.829,268.730
-- -442.452,-368.761,269.240
-- -532.746,-375.154,269.120
-- -640.084,-396.635,268.789
-- -609.768,-328.620,268.803
-- -711.097,-399.384,268.768
-- -670.993,-422.877,268.769
-- -703.780,-441.262,269.148 --boss 1
-- -575.234,-504.128,276.597
-- -573.173,-504.215,276.597
-- -566.032,-471.564,276.597
-- -533.368,-484.164,276.867
-- -478.677,-487.920,271.912
-- -474.526,-559.717,271.908
-- -532.378,-578.262,276.866
-- -568.749,-555.944,276.597
-- -703.550,-607.683,268.766
-- -680.677,-646.186,268.767
-- -653.442,-726.783,269.119
-- -616.884,-731.549,268.7684
-- -638.462,-664.547,268.767
-- -532.344,-690.429,269.120
-- -451.156,-670.666,269.120 --pre boss
-- -420.305,-680.318,267.498
-- -404.426,-671.638,266.333 -- boss
-- -478.599,-740.425,268.768
-- -559.014,-746.119,268.768
-- -726.532,-792.138,232.439
-- -776.793,-824.259,233.232 --boss pos
-- -731.865,-870.378,232.495
-- -732.905,-899.418,229.272 --die in lava