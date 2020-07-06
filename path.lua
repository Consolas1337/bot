print("Script started")
if (not lb.Navigator) then
   lb.LoadScript("TypescriptNavigator")
   print("Navigator loaded")
end

PRECISION = 2
MODE = 1
PATH = {
    {-568,-315,268},
    {-449,-334.5,269},
    {-445.3,-370.2,269},
    {-532,-373,269},
    {-638,-396,269},
    {-615,-330,269},
    {-714.500,-405.233,268.767},
    {-672,-426,269},
    {-701,-440,269},
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
    if (MODE > 10) then
        lb.Unlock(CastSpellByName, 'Жар преисподней')
        for i, guid in ipairs(lb.GetObjects(10)) do
            if (lb.UnitIsLootable(guid)) then 
                print("Вижу лут!")
                lb.ClickPosition(lb.ObjectPosition(guid))
            end
        end
    end
end
 
SomeFrame = CreateFrame("Frame", "SomeFrame", nil)
SomeFrame:SetScript("OnUpdate", go_dungenon)


-- -568,-315,268
-- -449,-334.5,269
-- -445.3,-370.2,269
-- -532,-373,269
-- -638,-396,269
-- -615,-330,269
-- -703,388,269
-- -672,-426,269
-- -701,-440,269


