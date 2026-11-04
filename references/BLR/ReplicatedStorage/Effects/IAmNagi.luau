  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 12
    -- upvalues: SpectatorController (copy), Popup (copy), ReplicatedStorage (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    task.delay(1.5, function() -- Line: 15
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Instantly Kill it.");
    end);
    task.delay(3.65, function() -- Line: 19
        -- upvalues: ReplicatedStorage (ref), u1 (ref), VfxManager (ref)
        local u2 = ReplicatedStorage.Assets.Vfx.NagiAbilityVFX["Floor Impact"]:Clone();
        u2.Parent = workspace;
        u2.CFrame = u1.Char.HumanoidRootPart.CFrame * CFrame.new(2.5, -3, 0.2);
        VfxManager.Emit(u2);
        task.delay(1.5, function() -- Line: 25
            -- upvalues: u2 (copy)
            u2:Destroy();
        end);
    end);
    task.delay(5.3, function() -- Line: 30
        -- upvalues: ReplicatedStorage (ref), u1 (ref), Popup (ref), VfxManager (ref)
        local u3 = ReplicatedStorage.Assets.Vfx.NagiAbilityVFX["nagi [spin wind]"].HumanoidRootPart.Attachment1:Clone();
        local u4 = ReplicatedStorage.Assets.Vfx.NagiAbilityVFX["nagi [spin wind]"].HumanoidRootPart.Attachment2:Clone();
        u3.Parent = u1.Char.HumanoidRootPart;
        u4.Parent = u1.Char.HumanoidRootPart;
        task.delay(3, function() -- Line: 37
            -- upvalues: Popup (ref)
            Popup.Subtitle(game.Players.LocalPlayer, "Nice to meet you Japan, I am,");
        end);
        VfxManager.Emit(u3);
        VfxManager.Emit(u4);
        task.delay(3, function() -- Line: 44
            -- upvalues: u3 (copy), u4 (copy)
            u3:Destroy();
            u4:Destroy();
        end);
    end);
    task.delay(9.75, function() -- Line: 50
        -- upvalues: ReplicatedStorage (ref), u1 (ref), VfxManager (ref)
        local u5 = ReplicatedStorage.Assets.Vfx.NagiAbilityVFX.Kick:Clone();
        u5.Parent = workspace;
        u5.CFrame = u1.Char.HumanoidRootPart.CFrame * CFrame.new(0.65, -0.35, -2.3);
        VfxManager.Emit(u5);
        task.delay(1.5, function() -- Line: 57
            -- upvalues: u5 (copy)
            u5:Destroy();
        end);
    end);
    task.delay(12, function() -- Line: 62
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;