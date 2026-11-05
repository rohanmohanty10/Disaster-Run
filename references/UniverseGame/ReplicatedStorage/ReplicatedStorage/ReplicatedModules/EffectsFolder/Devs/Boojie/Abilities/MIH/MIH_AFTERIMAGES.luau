  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets["Made In Heaven"];
game:GetService("RunService");
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1, p2, p3) -- Line: 13
    -- upvalues: EffectsHandler (copy)
    local v4 = p1:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = p1:FindFirstChild("HumanoidRootPart");
    local Head = p1:FindFirstChild("Head");

    if Head then
        Head = Head:FindFirstChildOfClass("Decal");
    end;

    if not (HumanoidRootPart and (HumanoidRootPart2 and v4)) then
        return;
    end;

    local u5 = p3 or {};

    if u5.Distance == nil then
        u5.Distance = 0.5;
    end;

    if u5.Time == nil then
        u5.Time = 0.1;
    end;

    if u5.Attribute == nil then
        u5.Attribute = "MIH_AFTERIMAGES";
    end;

    local u6 = { p1 };

    if u5.Whitelist then
        u6 = u5.RemoveDefaultWhitelist and {} or u6;

        for _, v in pairs(u5.Whitelist) do
            table.insert(u6, v);
        end;
    end;

    local u7 = { "ParticleEmitter", "Stand", "Highlight", "BillboardGui" };

    if u5.Blacklist then
        for _, v in pairs(u5.Blacklist) do
            table.insert(u7, v);
        end;
    end;

    if u5.IncludeAbilityModel and table.find(u7, "Stand") then
        table.remove(u7, table.find(u7, "Stand"));
    end;

    if p2 then
        if p1:GetAttribute(u5.Attribute) then
            return;
        end;

        p1:SetAttribute(u5.Attribute, true);

        if u5.HideFace and Head then
            if not p1:GetAttribute("OriginalFaceTransparency") then
                p1:SetAttribute("OriginalFaceTransparency", Head.Transparency);
            end;

            p1:SetAttribute("HideFace", true);
            Head.Transparency = 1;
        end;

        local v8 = os.clock();
        local Position = HumanoidRootPart2.Position;

        while p1 and (p1:IsDescendantOf(game) and p1:GetAttribute(u5.Attribute)) do
            if (u5.Distance and (HumanoidRootPart2.Position - Position).Magnitude > u5.Distance or not u5.Distance) and os.clock() - v8 >= u5.Time then
                v8 = os.clock();
                task.spawn(function() -- Line: 81
                    -- upvalues: EffectsHandler (ref), u6 (ref), u7 (copy), u5 (copy)
                    EffectsHandler.CallEffect("Afterimage", {
                        Duration = 0,
                        Speed = 0,
                        Brightness = 1,
                        Whitelist = u6,
                        Blacklist = u7,
                        Lifetime = u5.Lifetime or 0.25,
                        Transparency = u5.Transparency,
                        BypassTransparency = u5.BypassTransparency,
                        RemoveDefaultBlacklist = u5.RemoveDefaultBlacklist
                    });
                end);
            end;

            Position = HumanoidRootPart2.Position;
            task.wait();
        end;
    else
        if not p1:GetAttribute(u5.Attribute) then
            return;
        end;

        p1:SetAttribute(u5.Attribute, nil);

        if p1:GetAttribute("HideFace") and Head then
            p1:SetAttribute("HideFace", nil);
            Head.Transparency = p1:GetAttribute("OriginalFaceTransparency") or (u5.CustomFaceTransparency or 0);
            p1:SetAttribute("OriginalFaceTransparency", nil);
        end;
    end;
end;