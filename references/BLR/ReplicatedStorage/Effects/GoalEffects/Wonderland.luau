  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy), TweenService (copy), SpectatorController (copy), Essentials (copy)
    local LocalPlayer = game.Players.LocalPlayer;
    local Wonderland = ReplicatedStorage.Assets.GoalEffects.Wonderland;
    local u2 = ReplicatedStorage.Assets.GoalEffects.Wonderland.Wonderland:Clone();
    u2.Parent = workspace;
    u2.CFrame = u1.Pos;
    VfxManager.Emit(u2);
    VfxManager.Enable(u2["Area [Enable]"], true);
    task.delay(0.3, function() -- Line: 20
        -- upvalues: TweenService (ref), LocalPlayer (copy), SpectatorController (ref)
        local u3 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 1
        });

        if LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
            if LocalPlayer.PlayerGui.Misc.CloseLimited.Visible or LocalPlayer.PlayerGui.Customization.Enabled then
                u3:Play();
            end;
        else
            u3:Play();
        end;

        task.delay(0.5, function() -- Line: 33
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
    end);
    task.delay(0.8, function() -- Line: 39
        -- upvalues: Wonderland (copy), Essentials (ref), u2 (copy)
        local Players = game.Players:GetPlayers();

        for _, v in pairs(Players) do
            if v.Team ~= game.Teams.Visitor and v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                local u4 = Wonderland.Snow:Clone();
                u4.Parent = v.Character;
                u4.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0);
                Essentials:Weld(u4, v.Character.HumanoidRootPart);
                local u5 = Wonderland.Snowman:Clone();
                u5.Parent = v.Character;
                u5.CFrame = v.Character.Torso.CFrame;
                Essentials:Weld(u5, v.Character.Torso);
                task.delay(8, function() -- Line: 55
                    -- upvalues: u5 (copy), u4 (copy)
                    u5:Destroy();
                    u4:Destroy();
                end);
            end;
        end;

        workspace.Field.Field.Color = Color3.new(1, 1, 1);
        workspace.Field.Field.Material = Enum.Material.Snow;
        local u6 = Wonderland.Balls:Clone();
        local u7 = Wonderland.Sleigh:Clone();
        local u8 = Wonderland.Tree:Clone();
        local u9 = Wonderland.Houses:Clone();
        local u10 = Wonderland.Canes:Clone();
        u6.Parent = workspace;
        u7.Parent = workspace;
        u8.Parent = workspace;
        u9.Parent = workspace;
        u10.Parent = workspace;
        task.delay(7.65, function() -- Line: 76
            -- upvalues: u6 (copy), u7 (copy), u8 (copy), u9 (copy), u10 (copy), u2 (ref)
            u6:Destroy();
            u7:Destroy();
            u8:Destroy();
            u9:Destroy();
            u10:Destroy();
            u2:Destroy();
            workspace.Field.Field.Color = Color3.new(0.768627, 1, 0.87451);
            workspace.Field.Field.Material = Enum.Material.Grass;
        end);
    end);
    task.delay(1.3, function() -- Line: 89
        -- upvalues: VfxManager (ref), u2 (copy), TweenService (ref)
        VfxManager.Enable(u2["Area [Enable]"], false);
        local u11 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 0
        });
        u11:Play();
        task.delay(0.5, function() -- Line: 97
            -- upvalues: u11 (copy)
            u11:Destroy();
        end);
    end);
    task.delay(12, function() -- Line: 100
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;