 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local Parent = require(script.Parent.Parent);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 23, Name: FullyCopy
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u6 (ref), u5 (ref), Cooldowns (copy), Parent (copy), Players (copy), Styles (copy), Trove (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u4 = u7.BallController;
    u6 = u7.Network;
    u5 = u7.CameraController;

    if u7.AwakeningCopiedSetting then
        if u7.BttnsTrove then
            u7.BttnsTrove:Clean();
            u7.BttnsTrove = nil;
        end;

        local _ = u7.CDS[3];
        local v8 = tick() + 120;
        u7.CDS[3] = v8;
        task.spawn(function() -- Line: 42
            -- upvalues: u7 (copy)
            require(u7.AwakeningCopiedSetting.Ability)(u7);
        end);

        local function reset() -- Line: 46
            -- upvalues: u7 (copy), Cooldowns (ref), Parent (ref)
            task.delay(0.1, function() -- Line: 47
                -- upvalues: u7 (ref), Cooldowns (ref), Parent (ref)
                if not u7.LastReset or u7.LastReset[2] < tick() - 0.15 then
                    Cooldowns.Abilities.Copycat[3] = Cooldowns.Abilities[u7.AwakeningCopiedSetting.Style][u7.AwakeningCopiedSetting.Index];
                    u7.CDS[3] = tick() + Cooldowns.Abilities[u7.AwakeningCopiedSetting.Style][u7.AwakeningCopiedSetting.Index];
                    u7.AwakeningCopiedSetting = nil;
                    Parent.UncleSam[3].Ability = script;
                    Parent.UncleSam[3].Name = "100% Copy";
                    Parent.UncleSam[3].BallName = nil;
                    Parent.UncleSam[3].RequiresBall = "Both";
                end;
            end);
        end;

        task.delay(0.1, function() -- Line: 47
            -- upvalues: u7 (copy), Cooldowns (ref), Parent (ref)
            if not u7.LastReset or u7.LastReset[2] < tick() - 0.15 then
                Cooldowns.Abilities.Copycat[3] = Cooldowns.Abilities[u7.AwakeningCopiedSetting.Style][u7.AwakeningCopiedSetting.Index];
                u7.CDS[3] = tick() + Cooldowns.Abilities[u7.AwakeningCopiedSetting.Style][u7.AwakeningCopiedSetting.Index];
                u7.AwakeningCopiedSetting = nil;
                Parent.UncleSam[3].Ability = script;
                Parent.UncleSam[3].Name = "100% Copy";
                Parent.UncleSam[3].BallName = nil;
                Parent.UncleSam[3].RequiresBall = "Both";
            end;
        end);

        return;
    end;

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Style.Value ~= "Copycat" and (v.Style.Value ~= "Thief" and (v.Style.Value ~= "UncleSam" and Styles.Styles[v.Style.Value].Rarity ~= "Dev"))) then
            break;
        end;
    end;

    u7.CDS[3] = tick() + 120;

    if u7.BttnsTrove then
        u7.BttnsTrove:Clean();
    end;

    u7.BttnsTrove = Trove.new();

    if LocalPlayer.PlayerGui:FindFirstChild("AwakeningChoose") then
        LocalPlayer.PlayerGui.AwakeningChoose:Destroy();
    end;

    local u9 = script.AwakeningChoose:Clone();
    u9.Parent = LocalPlayer.PlayerGui;
    u7.BttnsTrove:Add(u9);
    u7.BttnsTrove:Connect(u9.Content.Close.MouseButton1Click, function() -- Line: 92
        -- upvalues: u9 (copy), u7 (copy)
        u9:Destroy();
        u7.BttnsTrove:Clean();
        u7.CDS[3] = tick() + 1;
    end);
    local v10 = {};

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Style.Value ~= "Copycat" and (v.Style.Value ~= "Thief" and (v.Style.Value ~= "UncleSam" and (Styles.Styles[v.Style.Value].Rarity ~= "Dev" and not table.find(v10, v.Style.Value))))) then
            table.insert(v10, v.Style.Value);
            local v11 = script.Awakening:Clone();
            v11.AwakeningName.Text = Parent[v.Style.Value][3].Name;
            v11.Parent = u9.Content.Content;
            u7.BttnsTrove:Connect(v11.MouseButton1Click, function() -- Line: 115
                -- upvalues: Parent (ref), v (copy), u7 (copy), u1 (ref)
                Parent.UncleSam[3].Name = Parent[v.Style.Value][3].Name;
                Parent.UncleSam[3].BallName = Parent[v.Style.Value][3].BallName;
                Parent.UncleSam[3].RequiresBall = Parent[v.Style.Value][3].RequiresBall;
                u7.AwakeningCopiedSetting = {};
                u7.AwakeningCopiedSetting.Style = v.Style.Value;
                u7.AwakeningCopiedSetting.Index = 3;
                u7.AwakeningCopiedSetting.Ability = Parent[u7.AwakeningCopiedSetting.Style][3].Ability;
                u7.CDS[3] = tick() + 1;
                u7.BttnsTrove:Clean();
                u1.Ability:Fire("Copy", {
                    TimeSent = workspace:GetServerTimeNow()
                });
            end);
        end;
    end;
end;