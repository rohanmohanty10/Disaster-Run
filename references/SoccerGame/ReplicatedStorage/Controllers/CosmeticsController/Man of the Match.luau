  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(u2, p3) -- Line: 6
    -- upvalues: CollectionService (copy), RunService (copy)
    local u4 = nil;
    local u5 = script.BodyAura:Clone();
    local u6 = script.Trail:Clone();
    u6.Parent = u2;
    u5.Parent = u2;
    CollectionService:AddTag(u6, (`Cosmetic{p3}`));
    CollectionService:AddTag(u5, (`Cosmetic{p3}`));
    u4 = RunService.RenderStepped:Connect(function(p7) -- Line: 15
        -- upvalues: u2 (copy), u4 (ref), u6 (copy), u5 (copy)
        if not (u2 and u2.Parent) then
            u4:Disconnect();
            u6:Destroy();
            u5:Destroy();

            return;
        end;

        u5.Transparency = 1;
        u6.Transparency = 1;
        u5:PivotTo(u2:GetPivot());
        u6:PivotTo(u2:GetPivot());
    end);
end;

return v1;