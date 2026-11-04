  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://83457406793593",
    looped = true,
    maxWalkDistance = 2,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), Essentials (copy), VfxManager (copy)
        local u4 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local u5 = script.VFX:Clone();
        u5:PivotTo(HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(u5:GetPivot()));

        for _, descendant in u5:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.Massless = true;
                Essentials:Weld(HumanoidRootPart, descendant, descendant);
            end;
        end;

        u5.Name = "BoneShrugVFX";
        u5.Parent = p2;
        u4:Add(u5);
        u4:Connect(p3.DidLoop, function() -- Line: 34, Name: emitCycle
            -- upvalues: VfxManager (ref), u5 (copy), u4 (copy)
            VfxManager.Emit(u5.ChargeFX);
            u4:Add(task.delay(1.0833333333333333, function() -- Line: 36
                -- upvalues: VfxManager (ref), u5 (ref)
                VfxManager.Emit(u5.GamaExplosion);
            end));
        end);
        VfxManager.Emit(u5.ChargeFX);
        u4:Add(task.delay(1.0833333333333333, function() -- Line: 36
            -- upvalues: VfxManager (ref), u5 (copy)
            VfxManager.Emit(u5.GamaExplosion);
        end));

        return u4;
    end
});