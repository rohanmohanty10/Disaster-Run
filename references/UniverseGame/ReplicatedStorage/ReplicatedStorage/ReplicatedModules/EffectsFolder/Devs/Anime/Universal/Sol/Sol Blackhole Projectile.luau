  

 

game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.KnitPath.Trove);
local ClientAssets = PathShortcuts.ClientAssets;

return function(u1, p2, p3) -- Line: 10
    -- upvalues: ClientAssets (copy), ParticleHandler (copy)
    if u1 == nil then
        return;
    end;

    local u4 = (p2 and (ClientAssets.Sol:FindFirstChild(p2) and (ClientAssets.Sol[p2]:FindFirstChild("ProjectileHoleOrb", true) and ClientAssets.Sol[p2])) or ClientAssets.Sol).ProjectileHoleOrb:Clone();
    ParticleHandler.Unusualify(u4, {
        HSVData = p3
    });
    u4.Anchored = true;
    u4.CanCollide = false;
    u4.CFrame = u1.CFrame;
    u4.Parent = workspace.Effects;
    local u5 = nil;
    u5 = game["Run Service"].RenderStepped:Connect(function(p6) -- Line: 24
        -- upvalues: u4 (copy), u1 (copy), u5 (ref)
        if u4:IsDescendantOf(game) and u1:IsDescendantOf(game) then
            u4.CFrame = u4.CFrame:Lerp(u1.CFrame, p6 * 20);

            return;
        end;

        u5:Disconnect();

        if u4:IsDescendantOf(game) then
            task.delay(1, u4.Destroy, u4);
        end;
    end);
    u1.AttributeChanged:Connect(function(p7) -- Line: 38
        -- upvalues: u1 (copy), u4 (copy)
        if u1:GetAttribute(p7) and p7 == "DisableTrails" then
            local v8 = next;
            local v9, v10 = u4:GetDescendants();

            for _, v in v8, v9, v10 do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Enabled = false;
                end;
            end;
        end;
    end);
end;