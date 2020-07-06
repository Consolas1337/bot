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
            if (UnitIsEnemy("player",guid)) then
                lb.Unlock(TargetUnit,"player")
                lb.Unlock(CastSpellByName, 'Автоматическая атака')
                local x, y, z = lb.ObjectPosition(guid)
                lb.Navigator.MoveTo(x, y, z, 1)
            end
            if (lb.UnitIsLootable(guid)) then 
                print("Вижу лут!")
                local x, y, z = lb.ObjectPosition(guid)
                lb.Navigator.MoveTo(x, y, z, 1)
                lb.ObjectInteract(guid)
            end
        end
    end
end
 
SomeFrame = CreateFrame("Frame", "SomeFrame", nil)
SomeFrame:SetScript("OnUpdate", go_dungenon)


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


