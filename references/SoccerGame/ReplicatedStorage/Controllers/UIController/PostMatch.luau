  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local _ = HumanoidRootPart:WaitForChild("RootJoint").C0;
require(ReplicatedStorage.Shared.environment);
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local v3 = Knit.CreateController({
    Name = "PostMatch"
});

local function format(p4) -- Line: 25
    return string.format("%02d", p4);
end;

local function convertToHMS(p5) -- Line: 29
    local math_floor_ret = math.floor(p5);
    local math_floor_ret2 = math.floor(math_floor_ret / 3600);
    local math_floor_ret3 = math.floor(math_floor_ret % 3600 / 60);
    local v6 = math_floor_ret % 60;

    if math_floor_ret2 > 0 then
        return string.format("%02d", math_floor_ret2) .. ":" .. string.format("%02d", math_floor_ret3) .. ":" .. string.format("%02d", v6);
    end;

    if math_floor_ret3 > 0 then
        return string.format("%02d", math_floor_ret3) .. ":" .. string.format("%02d", v6);
    end;

    return tostring(v6);
end;

function v3.KnitStart(p7) -- Line: 47
    -- upvalues: Knit (copy), LocalPlayer (copy), TweenService (copy), Essentials (copy), SoundManager (copy), Players (copy)
    p7.MatchService = Knit.GetService("MatchService");
    local PostMatch = LocalPlayer.PlayerGui.PostMatch;
    p7.BaseTrove:Connect(p7.MatchService.SendStats, function(p8, p9, p10, p11) -- Line: 52
        -- upvalues: LocalPlayer (ref), PostMatch (copy), TweenService (ref), Essentials (ref), SoundManager (ref)
        if require(game:GetService("ReplicatedStorage").Shared.environment).mode == "Ranked" then
            return;
        end;

        LocalPlayer.PlayerGui.HUD.Enabled = false;

        if p8 then
            PostMatch.Enabled = true;
            local v12 = math.random(15, 25) / 10;
            local NumberValue = Instance.new("NumberValue");
            local u13 = TweenService:Create(NumberValue, TweenInfo.new(v12, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = LocalPlayer.ProfileStats.Money.Value
            });
            u13:Play();
            local NumberValue2 = Instance.new("NumberValue");
            local u14 = TweenService:Create(NumberValue2, TweenInfo.new(v12, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = LocalPlayer.ProfileStats.Exp.Value
            });
            u14:Play();
            local NumberValue3 = Instance.new("NumberValue");
            local u15 = TweenService:Create(NumberValue3, TweenInfo.new(v12, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = LocalPlayer.ProfileStats.Level.Value
            });
            u15:Play();
            local u16 = TweenService:Create(LocalPlayer.PlayerGui.PostMatch.Currencies.Level.Exp.Bar, TweenInfo.new(v12, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = UDim2.new(LocalPlayer.ProfileStats.Exp.Value / (LocalPlayer.ProfileStats.Level.Value * 80), 0, 1, 0)
            });
            u16:Play();
            task.spawn(function() -- Line: 81
                -- upvalues: NumberValue (copy), LocalPlayer (ref), Essentials (ref), NumberValue3 (copy), NumberValue2 (copy), u13 (copy), u14 (copy), u15 (copy), u16 (copy)
                while NumberValue.Value < LocalPlayer.ProfileStats.Money.Value - 1 do
                    task.wait();
                    LocalPlayer.PlayerGui.PostMatch.Currencies.Yen.Amount.Text = Essentials:formatNumberWithCommas(NumberValue.Value);
                    local LevelAmount = LocalPlayer.PlayerGui.PostMatch.Currencies.Level.LevelAmount;
                    local math_round_ret = math.round(NumberValue3.Value);
                    LevelAmount.Text = "Level " .. tostring(math_round_ret);
                    local EXPAmount = LocalPlayer.PlayerGui.PostMatch.Currencies.Level.EXPAmount;
                    local math_round_ret2 = math.round(NumberValue2.Value);
                    local v17 = tostring(math_round_ret2);
                    local math_round_ret3 = math.round(LocalPlayer.ProfileStats.Level.Value * 80);
                    EXPAmount.Text = v17 .. "/" .. tostring(math_round_ret3);
                end;

                u13:Destroy();
                NumberValue:Destroy();
                NumberValue2:Destroy();
                u14:Destroy();
                NumberValue3:Destroy();
                u15:Destroy();
                u16:Destroy();
            end);
            local Children = LocalPlayer.GameStats:GetChildren();

            for _, v in pairs(Children) do
                if v.Name == "Goals" or (v.Name == "Assists" or (v.Name == "Steals" or v.Name == "Saves")) then
                    local NumberValue4 = Instance.new("NumberValue");
                    local u18 = TweenService:Create(NumberValue4, TweenInfo.new(math.random(15, 25) / 10, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Value = v.Value
                    });
                    u18:Play();
                    task.spawn(function() -- Line: 108
                        -- upvalues: NumberValue4 (copy), v (copy), SoundManager (ref), LocalPlayer (ref), PostMatch (ref)
                        while NumberValue4.Value < v.Value - 0.1 do
                            task.wait();
                            SoundManager.SpawnSound("Hover", 0.3, LocalPlayer.PlayerGui, 1);
                            local Value = PostMatch.InGame[v.Name].Value;
                            local math_round_ret = math.round(NumberValue4.Value);
                            Value.Text = tostring(math_round_ret);
                        end;

                        task.wait(0.2);
                        local Value = PostMatch.InGame[v.Name].Value;
                        local math_round_ret = math.round(NumberValue4.Value);
                        Value.Text = tostring(math_round_ret);
                    end);
                    task.delay(3, function() -- Line: 118
                        -- upvalues: NumberValue4 (copy), u18 (copy)
                        NumberValue4:Destroy();
                        u18:Destroy();
                    end);
                end;
            end;

            table.clear(Children);
            PostMatch.Total.Goals.old.Text = p8.Goals;
            PostMatch.Total.Assists.old.Text = p8.Assists;

            for i, v in pairs(p9) do
                if i == "Goals" or (i == "Assists" or i == "MVP") then
                    local NumberValue4 = Instance.new("NumberValue");
                    local u19 = TweenService:Create(NumberValue4, TweenInfo.new(math.random(15, 25) / 10, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Value = v
                    });
                    u19:Play();
                    task.spawn(function() -- Line: 136
                        -- upvalues: NumberValue4 (copy), v (copy), SoundManager (ref), LocalPlayer (ref), PostMatch (ref), i (copy)
                        while NumberValue4.Value < v - 1 do
                            task.wait();
                            SoundManager.SpawnSound("Hover", 0.2, LocalPlayer.PlayerGui, 1);
                            local new = PostMatch.Total[i].new;
                            local math_round_ret = math.round(NumberValue4.Value);
                            new.Text = tostring(math_round_ret);
                        end;

                        task.wait(0.2);
                        local new = PostMatch.Total[i].new;
                        local math_round_ret = math.round(NumberValue4.Value);
                        new.Text = tostring(math_round_ret);
                    end);
                    task.delay(3, function() -- Line: 146
                        -- upvalues: NumberValue4 (copy), u19 (copy)
                        NumberValue4:Destroy();
                        u19:Destroy();
                    end);
                end;
            end;

            table.clear(p8);
            table.clear(p9);
        end;
    end);
    p7.BaseTrove:Connect(LocalPlayer.PlayerGui.PostMatch:GetPropertyChangedSignal("Enabled"), function() -- Line: 160
        -- upvalues: LocalPlayer (ref), Players (ref)
        if LocalPlayer.PlayerGui.PostMatch.Enabled ~= false then
            local Players2 = Players:GetPlayers();

            for _, v in pairs(Players2) do
                if v ~= LocalPlayer and (v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil) then
                    local Descendants = v.Character:GetDescendants();

                    for _, v2 in pairs(Descendants) do
                        if v2.Name ~= "Hitbox" and v2.Name ~= "TrajectoryLine" then
                            if v2:IsA("Decal") and v2.Parent.Name == "Head" then
                                v2.Parent = v2.Parent.Mesh;
                            end;

                            if v2:IsA("BasePart") ~= false then
                                v2.Transparency = 1;
                            end;
                        end;
                    end;

                    table.clear(Descendants);
                end;
            end;

            table.clear(Players2);

            return;
        end;

        task.wait(0.1);
        local Players2 = Players:GetPlayers();

        for _, v in pairs(Players2) do
            if v ~= LocalPlayer and (v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil) then
                local Descendants = v.Character:GetDescendants();

                for _, v2 in pairs(Descendants) do
                    if v2.Name ~= "Hitbox" then
                        if v2:IsA("Decal") and v2.Parent.Name == "Mesh" then
                            v2.Parent = v2.Parent.Parent;
                        end;

                        if v2:IsA("BasePart") ~= false and (v2.Name == "Handle" or (v2.Name:match("Left") ~= nil or (v2.Name:match("Right") ~= nil or (v2.Name == "Head" or v2.Name == "Torso")))) then
                            v2.Transparency = 0;
                        end;
                    end;
                end;

                table.clear(Descendants);
            end;
        end;

        table.clear(Players2);
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    end);
    p7.BaseTrove:Connect(LocalPlayer.PlayerGui.PostMatch.ReturnButtonFrame.CloseButton.MouseButton1Click, function() -- Line: 222
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.PlayerGui.PostMatch.Enabled = false;

        if LocalPlayer.Team == game.Teams.Visitor then
            LocalPlayer.PlayerGui.HUD.Enabled = true;

            return;
        end;

        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end);
    local u20 = {};
    Players.PlayerRemoving:Connect(function(p21) -- Line: 242
        -- upvalues: u20 (copy)
        for _, v in u20[p21] do
            v:Disconnect();
        end;

        u20[p21] = nil;
    end);

    local function plrAdded(p22, p23) -- Line: 236
        -- upvalues: u20 (copy)
        u20[p22] = {};
    end;

    for _, v in Players:GetPlayers() do
        u20[v] = {};
    end;

    Players.PlayerAdded:Connect(plrAdded);
end;

function v3.KnitInit(u24) -- Line: 257
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    u24.BaseTrove = Trove.new();
    u24.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p25) -- Line: 260
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p25;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u24.BaseTrove:Connect(game.Players.PlayerRemoving, function(p26) -- Line: 266
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), u2 (ref), u24 (copy)
        if p26 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            u2 = nil;
            u24.BaseTrove:Destroy();
        end;
    end);
end;

return v3;