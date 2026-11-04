 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
local PolicyService = game:GetService("PolicyService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Values = require(ReplicatedStorage.Shared.Tables.Values);
local PlrStats = require(ReplicatedStorage.Shared.Tables.PlrStats);
local LocalPlayer = game.Players.LocalPlayer;
local v1 = Knit.CreateController({
    Name = "Network"
});

function v1.Device(p2) -- Line: 17
    -- upvalues: UserInputService (copy), ReplicatedStorage (copy)
    if UserInputService.GamepadEnabled then
        ReplicatedStorage.Controllers.Device.Value = "Console";
    elseif UserInputService.TouchEnabled then
        ReplicatedStorage.Controllers.Device.Value = "Mobile";
    else
        ReplicatedStorage.Controllers.Device.Value = "PC";
    end;

    UserInputService.LastInputTypeChanged:Connect(function(p3) -- Line: 26
        -- upvalues: ReplicatedStorage (ref)
        local _ = ReplicatedStorage.Controllers.Device.Value;

        if p3 == Enum.UserInputType.Keyboard then
            ReplicatedStorage.Controllers.Device.Value = "PC";

            return;
        end;

        if p3 == Enum.UserInputType.Touch then
            ReplicatedStorage.Controllers.Device.Value = "Mobile";

            return;
        end;

        if p3 == Enum.UserInputType.Gamepad1 then
            ReplicatedStorage.Controllers.Device.Value = "Console";
        end;
    end);
end;

function v1.SomeoneScoredWithinXSecondsAgo(p4, p5) -- Line: 39
    if typeof(p5) ~= "number" then
        error((`{p5} is not a number!`));
    end;

    return tick() - p4._LastScoreTimestamp <= p5;
end;

function v1.Signals(u6) -- Line: 47
    -- upvalues: ReplicatedStorage (copy), Knit (copy)
    ReplicatedStorage.Remotes.Network.OnClientEvent:Connect(function(p7: string, p8: any) -- Line: 48
        -- upvalues: ReplicatedStorage (ref), u6 (copy)
        ReplicatedStorage.Controllers.NewData.Value = not ReplicatedStorage.Controllers.NewData.Value;
        u6.CharValues[p7] = p8;
    end);
    ReplicatedStorage.Remotes.UnreliableNetwork.OnClientEvent:Connect(function(p9: string, p10: any) -- Line: 52
        -- upvalues: ReplicatedStorage (ref), u6 (copy)
        ReplicatedStorage.Controllers.NewData.Value = not ReplicatedStorage.Controllers.NewData.Value;
        u6.CharValues[p9] = p10;
    end);
    ReplicatedStorage.Remotes.PlrNetwork.OnClientEvent:Connect(function(p11, p12) -- Line: 56
        -- upvalues: u6 (copy), ReplicatedStorage (ref)
        if typeof(p11) == "table" then
            local Player = u6.Player;
            local v13 = tonumber(p11[#p11]) or p11[#p11];

            for i, v in p11 do
                if i == #p11 then
                    break;
                end;

                Player = Player[tonumber(v)] or Player[v];
            end;

            Player[v13] = p12;
        else
            u6.Player[p11] = p12;
        end;

        ReplicatedStorage.Controllers.NewData.Value = not ReplicatedStorage.Controllers.NewData.Value;
    end);
    u6._LastScoreTimestamp = tick();
    Knit.GetService("ScoreService").Scored:Connect(function(p14) -- Line: 115
        -- upvalues: u6 (copy)
        u6._LastScoreTimestamp = tick();
    end);
end;

function v1.KnitInit(u15) -- Line: 134
    -- upvalues: Knit (copy), Values (copy), PlrStats (copy), PolicyService (copy), LocalPlayer (copy)
    local Service = Knit.GetService("StatsService");
    local Service2 = Knit.GetService("CustomServerService");
    u15.Gamemode = Service2:GetGamemode();
    u15.ServerType = Service2:GetServerType();
    u15.Environment = Service2:GetEnvironment();
    warn((`Gamemode: {u15.Gamemode}\nServerType: {u15.ServerType}\nEnvironment: {u15.Environment}\n`));
    u15.CharValues = {};
    u15.Player = {};

    for i, v in Values do
        u15.CharValues[i] = v.Value;
    end;

    for i, v in PlrStats do
        u15.Player[i] = v;
    end;

    local _, result = pcall(function() -- Line: 156
        -- upvalues: PolicyService (ref), LocalPlayer (ref)
        return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);
    end);
    LocalPlayer.PlayerGui:WaitForChild("Shop"):WaitForChild("BG");
    local v16 = 0;

    while v16 < 10 and result == nil do
        task.wait(0.05);
        local v17;
        v17, result = pcall(function() -- Line: 165
            -- upvalues: PolicyService (ref), LocalPlayer (ref)
            print("GetPolicyInfoForPlayerAsync");

            return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);
        end);
        v16 = v16 + 1;
    end;

    u15.Player = Service:GetData();

    while u15.Player == nil do
        task.wait(0.25);
        u15.Player = Service:GetData();
    end;

    if result then
        u15.Policy = result.ArePaidRandomItemsRestricted;
    else
        u15.Policy = true;
    end;

    u15:Device();
    u15:Signals();

    local function OnCharacterAdded(p18) -- Line: 188
        -- upvalues: u15 (copy), Values (ref), Service (copy)
        for i, _ in u15.CharValues do
            u15.CharValues[i] = Values[i].Value;
        end;

        u15.CharValues.Blocked = tick();
        local Data = Service:GetData();

        if Data then
            u15.Player = Data;
        end;
    end;

    if LocalPlayer.Character then
        task.spawn(OnCharacterAdded, LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(OnCharacterAdded);
end;

return v1;