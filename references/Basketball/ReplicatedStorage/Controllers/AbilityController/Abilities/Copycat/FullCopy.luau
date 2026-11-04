 
 

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

        local u8 = u7.CDS[3];
        local v9 = tick() + 120;
        u7.CDS[4] = v9;
        task.spawn(function() -- Line: 42
            -- upvalues: u7 (copy)
            require(u7.AwakeningCopiedSetting.Ability)(u7);
        end);

        local function reset() -- Line: 46
            -- upvalues: u7 (copy), Cooldowns (ref), Parent (ref), u8 (copy)
            task.delay(0.1, function() -- Line: 47
                -- upvalues: u7 (ref), Cooldowns (ref), Parent (ref), u8 (ref)
                if not u7.LastReset or u7.LastReset[2] < tick() - 0.15 then
                    Cooldowns.Abilities.Copycat[4] = Cooldowns.Abilities[u7.AwakeningCopiedSetting.Style][u7.AwakeningCopiedSetting.Index];
                    u7.CDS[4] = tick() + Cooldowns.Abilities[u7.AwakeningCopiedSetting.Style][u7.AwakeningCopiedSetting.Index];
                    u7.AwakeningCopiedSetting = nil;
                    Parent.Copycat[4].Ability = script;
                    Parent.Copycat[4].Name = "100% Copy";
                    Parent.Copycat[4].BallName = nil;
                    Parent.Copycat[4].RequiresBall = "Both";
                end;

                if u8 ~= u7.CDS[3] then
                    u7.CDS[3] = u8;
                    u7.CDS[4] = tick() - 1;
                end;

                print(u8, u7.CDS[3]);
            end);
        end;

        task.delay(0.1, function() -- Line: 47
            -- upvalues: u7 (copy), Cooldowns (ref), Parent (ref), u8 (copy)
            if not u7.LastReset or u7.LastReset[2] < tick() - 0.15 then
                Cooldowns.Abilities.Copycat[4] = Cooldowns.Abilities[u7.AwakeningCopiedSetting.Style][u7.AwakeningCopiedSetting.Index];
                u7.CDS[4] = tick() + Cooldowns.Abilities[u7.AwakeningCopiedSetting.Style][u7.AwakeningCopiedSetting.Index];
                u7.AwakeningCopiedSetting = nil;
                Parent.Copycat[4].Ability = script;
                Parent.Copycat[4].Name = "100% Copy";
                Parent.Copycat[4].BallName = nil;
                Parent.Copycat[4].RequiresBall = "Both";
            end;

            if u8 ~= u7.CDS[3] then
                u7.CDS[3] = u8;
                u7.CDS[4] = tick() - 1;
            end;

            print(u8, u7.CDS[3]);
        end);

        return;
    end;

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Style.Value ~= "Copycat" and (v.Style.Value ~= "Thief" and (v.Style.Value ~= "UncleSam" and (v.Style.Value ~= "Cyber" and (v.Style.Value ~= "OGCyber" and (v.Style.Value ~= "Psychic" and (v.Style.Value ~= "Rubberman" and (v.Style.Value ~= "LukaDoncic" and (v.Style.Value ~= "ChrolloV2" and Styles.Styles[v.Style.Value].Rarity ~= "Dev"))))))))) then
            break;
        end;
    end;

    u7.CDS[4] = tick() + 120;

    if u7.BttnsTrove then
        u7.BttnsTrove:Clean();
    end;

    u7.BttnsTrove = Trove.new();

    if LocalPlayer.PlayerGui:FindFirstChild("AwakeningChoose") then
        LocalPlayer.PlayerGui.AwakeningChoose:Destroy();
    end;

    local u10 = script.AwakeningChoose:Clone();
    u10.Parent = LocalPlayer.PlayerGui;
    u7.BttnsTrove:Add(u10);
    u7.BttnsTrove:Connect(u10.Content.Close.MouseButton1Click, function() -- Line: 100
        -- upvalues: u10 (copy), u7 (copy)
        u10:Destroy();
        u7.BttnsTrove:Clean();
        u7.CDS[4] = tick() + 1;
    end);
    local v11 = {};

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Style.Value ~= "Copycat" and (v.Style.Value ~= "Thief" and (v.Style.Value ~= "UncleSam" and (v.Style.Value ~= "Cyber" and (v.Style.Value ~= "OGCyber" and (v.Style.Value ~= "Psychic" and (v.Style.Value ~= "Rubberman" and (v.Style.Value ~= "LukaDoncic" and (v.Style.Value ~= "ChrolloV2" and (Styles.Styles[v.Style.Value].Rarity ~= "Dev" and not table.find(v11, v.Style.Value))))))))))) then
            table.insert(v11, v.Style.Value);
            local v12 = script.Awakening:Clone();
            v12.AwakeningName.Text = Parent[v.Style.Value][3].Name;
            v12.Parent = u10.Content.Content;
            u7.BttnsTrove:Connect(v12.MouseButton1Click, function() -- Line: 129
                -- upvalues: Parent (ref), v (copy), u7 (copy), u1 (ref)
                Parent.Copycat[4].Name = Parent[v.Style.Value][3].Name;
                Parent.Copycat[4].BallName = Parent[v.Style.Value][3].BallName;
                Parent.Copycat[4].RequiresBall = Parent[v.Style.Value][3].RequiresBall;
                u7.AwakeningCopiedSetting = {};
                u7.AwakeningCopiedSetting.Style = v.Style.Value;
                u7.AwakeningCopiedSetting.Index = 3;
                u7.AwakeningCopiedSetting.Ability = Parent[u7.AwakeningCopiedSetting.Style][3].Ability;
                u7.CDS[4] = tick() + 1;
                u7.BttnsTrove:Clean();
                u1.Ability:Fire("Copy", {
                    FullCopy = true,
                    TimeSent = workspace:GetServerTimeNow(),
                    Style = v.Style.Value
                });
            end);
        end;
    end;
end;