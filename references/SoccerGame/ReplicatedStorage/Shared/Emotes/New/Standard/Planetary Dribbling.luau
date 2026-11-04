  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://115536502800049",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy), EmitModule (copy)
        local v5 = Trove.new();
        local PlanetaryDribble = ReplicatedStorage.Assets.Misc.PlanetaryDribble;

        for _, child in PlanetaryDribble.Rig:GetChildren() do
            local v6 = p2[child.Name];
            local v7 = child:Clone();
            v7.CanCollide = false;
            v7.Massless = true;
            v7.Transparency = 1;
            v7:PivotTo(v6.CFrame);
            v7.Parent = v6;
            v5:Add(v7);
            Essentials:Weld(v6, v7, v7);
        end;

        local u8 = ReplicatedStorage.Assets.Misc.PlanetaryDribble.VFX:Clone();
        u8:PivotTo(p2.HumanoidRootPart.CFrame * PlanetaryDribble.HumanoidRootPart.CFrame:ToObjectSpace(u8:GetPivot()));

        for _, child in u8:GetChildren() do
            child.CanCollide = false;
            child.Massless = true;
            child.Anchored = false;
            child.Transparency = 1;
            Essentials:Weld(p2.HumanoidRootPart, child, child);
        end;

        u8.Parent = workspace.Debris;
        EmitModule.emit(u8.spawn);
        task.delay(1.6, function() -- Line: 49
            -- upvalues: u8 (copy), EmitModule (ref)
            if not u8.Parent then
                return;
            end;

            EmitModule.emit(u8.Dribble);
        end);
        task.delay(2.216666666666667, function() -- Line: 55
            -- upvalues: u8 (copy), EmitModule (ref)
            if not u8.Parent then
                return;
            end;

            EmitModule.emit(u8.Dribble2);
        end);
        task.delay(2.35, function() -- Line: 61
            -- upvalues: u8 (copy), EmitModule (ref)
            if not u8.Parent then
                return;
            end;

            EmitModule.emit(u8.Body);
        end);
        task.delay(2.566666666666667, function() -- Line: 67
            -- upvalues: u8 (copy), EmitModule (ref)
            if not u8.Parent then
                return;
            end;

            EmitModule.emit(u8.Dribble);
        end);
        task.delay(2.7666666666666666, function() -- Line: 73
            -- upvalues: u8 (copy), EmitModule (ref)
            if not u8.Parent then
                return;
            end;

            EmitModule.emit(u8.Dribble2);
        end);
        task.delay(3.316666666666667, function() -- Line: 79
            -- upvalues: u8 (copy), EmitModule (ref)
            if not u8.Parent then
                return;
            end;

            EmitModule.emit(u8.Land);
        end);
        v5:Add(u8);

        return v5;
    end
});