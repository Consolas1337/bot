print("Script started")
if (not lb.Navigator) then
   lb.LoadScript("TypescriptNavigator")
   print("Navigator loaded")
end

PRECISION = 2
MODE = 1
PATH = {
    {-570.279,-316.950,269.366},
    {-447.442,-325.829,268.730},
    {-442.452,-368.761,269.240},
    {-532.746,-375.154,269.120},
    {-640.084,-396.635,268.789},
    {-609.768,-328.620,268.803},
    {-711.097,-399.384,268.768},
    {-670.993,-422.877,268.769},
    {-703.780,-441.262,269.148},  -- BOSS 1
}

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

    if ((distance > PRECISION) and (MODE <= 10)) then
        lb.Navigator.MoveTo(X, Y, Z, 1)
    else
        MODE = MODE + 1
        if (MODE == 10) then
            SomeFrame:SetScript("OnUpdate", nil)
            print("Waiting boss...")
            MODE = MODE + 1
        else 
            print("Stage: "..MODE)
        end
    end

    if (MODE == 11) then
        lb.Unlock(CastSpellByName, 'Жар преисподней')
        for i, guid in ipairs(lb.GetObjects(20)) do
            print(guid)
            if (lb.UnitIsLootable(guid)) then 
                print("Вижу лут!")
                lb.ObjectInteract(guid)
            end
        end
    end

end

-- if (UnitIsEnemy("player", guid)) then
--     print("Enemy found!")
--     lb.Unlock(TargetUnit, lb.UnitTarget('target'))
--     lb.Unlock(CastSpellByName, 'Автоматическая атака')
--     local x, y, z = lb.ObjectPosition(guid)
--     lb.Navigator.MoveTo(x, y, z, 1)
-- end
--  lb.ObjectId('player')
SomeFrame = CreateFrame("Frame", "SomeFrame", nil)
SomeFrame:SetScript("OnUpdate", go_dungenon)



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


