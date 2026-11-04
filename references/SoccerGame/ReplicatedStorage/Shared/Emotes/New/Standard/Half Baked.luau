  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);

return v1({
    looped = false,
    animationId = "rbxassetid://129749121209311",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), EmitModule (copy)
        local u5 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local CFrame = script.HumanoidRootPart.CFrame;

        local function place(p6) -- Line: 19
            -- upvalues: HumanoidRootPart (copy), CFrame (copy), u5 (copy)
            local v7 = p6:Clone();
            v7:PivotTo(HumanoidRootPart.CFrame * CFrame:ToObjectSpace(p6:GetPivot()));

            local function prepare(p8) -- Line: 22
                p8.Anchored = true;
                p8.CanCollide = false;
                p8.CanTouch = false;
                p8.CanQuery = false;
                p8.Massless = true;
                p8.Transparency = 1;
            end;

            for _, descendant in v7:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = true;
                    descendant.CanCollide = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                    descendant.Massless = true;
                    descendant.Transparency = 1;
                end;
            end;

            if v7:IsA("BasePart") then
                v7.Anchored = true;
                v7.CanCollide = false;
                v7.CanTouch = false;
                v7.CanQuery = false;
                v7.Massless = true;
                v7.Transparency = 1;
            end;

            v7.Parent = workspace.Debris;
            u5:Add(v7);

            return v7;
        end;

        local v9 = place(script.iseenow);
        local u10 = place(script.bread);
        local u11 = place(script.halfbakedVFX);
        EmitModule.emit(v9);
        task.delay(1.75, function() -- Line: 49
            -- upvalues: u10 (copy), EmitModule (ref), u11 (copy)
            if u10.Parent then
                EmitModule.emit(u10);
            end;

            if u11.Parent then
                EmitModule.emit(u11);
            end;
        end);

        return u5;
    end
});