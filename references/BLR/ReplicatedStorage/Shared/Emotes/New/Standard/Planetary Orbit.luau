  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://117681583523508",
    looped = false,
    meta = {
        rarity = "Legendary"
    },

    effect = function(u2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy), EmitModule (copy)
        local u5 = Trove.new();
        local PlanetaryOrbit = ReplicatedStorage.Assets.Misc.PlanetaryOrbit;
        local u6 = PlanetaryOrbit["Crash emit"]:Clone();
        u6:PivotTo(u2.HumanoidRootPart.CFrame * PlanetaryOrbit.HumanoidRootPart.CFrame:ToObjectSpace(u6:GetPivot()));
        u6.CanCollide = false;
        u6.Massless = true;
        u6.Anchored = false;
        u6.Transparency = 1;
        Essentials:Weld(u2.HumanoidRootPart, u6, u6);
        u6.Parent = workspace.Debris;
        local u7 = {};
        task.delay(0.4, function() -- Line: 31
            -- upvalues: u6 (copy), PlanetaryOrbit (copy), u7 (copy), u5 (copy), u2 (copy), Essentials (ref)
            if not u6.Parent then
                return;
            end;

            local CFrame_new_ret = CFrame.new(0, -2, 0);
            local Children = PlanetaryOrbit.Planets:GetChildren();
            local math_random_ret = math.random(1, #Children);
            local v8 = Children[math_random_ret]:Clone();
            table.insert(u7, v8);
            table.remove(Children, math_random_ret);
            u5:Add(v8);
            v8:PivotTo(u2["Right Arm"].CFrame * CFrame_new_ret);
            v8.Parent = u2["Right Arm"];
            Essentials:Weld(u2["Right Arm"], v8, v8);
            local v9 = Children[math.random(1, #Children)]:Clone();
            table.insert(u7, v9);
            u5:Add(v9);
            v9:PivotTo(u2["Left Arm"].CFrame * CFrame_new_ret);
            v9.Parent = u2["Left Arm"];
            Essentials:Weld(u2["Left Arm"], v9, v9);
        end);
        task.delay(1.35, function() -- Line: 58
            -- upvalues: u6 (copy), EmitModule (ref), u7 (copy)
            if not u6.Parent then
                return;
            end;

            EmitModule.emit(u6);

            for _, v in u7 do
                v:Destroy();
            end;
        end);
        u5:Add(u6);

        return u5;
    end
});