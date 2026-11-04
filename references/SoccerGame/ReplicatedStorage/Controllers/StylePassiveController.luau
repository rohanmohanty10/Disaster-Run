  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Teams = game:GetService("Teams");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
require(ReplicatedStorage.Packages.Trove);
local u1 = {
    Velocity = require(script.Passive_Velocity),
    LandingMetavision = require(script.Passive_LandingMetavision),
    CooldownMetavision = require(script.Passive_CooldownMetavision)
};
local u2 = {
    Loki = { "Velocity", "LandingMetavision" },
    Nagi = { "LandingMetavision" },
    Aiku = { "CooldownMetavision", "LandingMetavision" },
    Reo = { "CooldownMetavision" },
    ["Krampus Barou"] = { "CooldownMetavision" },
    ["Subzero Loki"] = { "Velocity", "LandingMetavision" }
};
local u3 = { "LandingMetavision" };
local LocalPlayer = Players.LocalPlayer;
local PlayerData = ClientGlobals.PlayerData;
local u4 = {};
local v5 = {
    Name = "CharacterPassiveController"
};

local function cleanup() -- Line: 45
    -- upvalues: u4 (copy)
    for _, v in u4 do
        v.trove:Destroy();
    end;

    table.clear(u4);
end;

local function refresh() -- Line: 52
    -- upvalues: u4 (copy), LocalPlayer (copy), Teams (copy), PlayerData (copy), u2 (copy), u3 (copy), u1 (copy)
    for _, v in u4 do
        v.trove:Destroy();
    end;

    table.clear(u4);
    local Character = LocalPlayer.Character;
    local v6;

    if Character then
        v6 = Character:FindFirstChild("Values");
    else
        v6 = Character;
    end;

    local v7;

    if Character then
        v7 = Character:FindFirstChildOfClass("Humanoid");
    else
        v7 = Character;
    end;

    local v8 = v6 and v6:FindFirstChild("Goalie") and v6.Goalie.Value;

    if v7 then
        if v7.Health > 0 then
            v7 = LocalPlayer.Team ~= Teams.Visitor;
        else
            v7 = false;
        end;
    end;

    if not v7 then
        return;
    end;

    local v9 = PlayerData.Data.StyleSlots[PlayerData.Data.StyleSlots.SlotEquipped];
    local v10 = {};

    if u2[v9] then
        table.move(u2[v9], 1, #u2[v9], 1, v10);
    end;

    if v8 then
        table.move(u3, 1, #u3, #v10 + 1, v10);
    end;

    if #v10 == 0 then
        return;
    end;

    for _, v in v10 do
        local v11, v12 = u1[v]:hook(Character);
        u4[v] = {
            trove = v11,
            reader = v12
        };
    end;
end;

function v5.Read(p13: table, p14: string, p15: string) -- Line: 94
    -- upvalues: u4 (copy)
    if u4[p14] then
        return u4[p14].reader(p15);
    end;
end;

function v5.KnitStart(p16) -- Line: 100
    -- upvalues: refresh (copy), LocalPlayer (copy), PlayerData (copy)
    local function onCharacterAdded(p17) -- Line: 102
        -- upvalues: refresh (ref)
        local Humanoid = p17:WaitForChild("Humanoid", 60);
        local Values = p17:WaitForChild("Values", 60);

        if Values and Humanoid then
            Humanoid.Died:Connect(refresh);
            Values:WaitForChild("Goalie").Changed:Connect(refresh);
            refresh();
        end;
    end;

    if LocalPlayer.Character then
        task.spawn(onCharacterAdded, LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(onCharacterAdded);
    LocalPlayer.CharacterRemoving:Connect(refresh);
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(refresh);
    PlayerData:Listen({ "StyleSlots" }, refresh);
end;

return KnitClient.CreateController(v5);