  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 7
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if u1 then
        u1 = u1.Char;
    end;

    if not (u1 and (u1.Parent and u1:FindFirstChild("HumanoidRootPart"))) then
        return;
    end;

    local u2 = {
        Rekysui = u1
    };
    local u3 = require(script.Subtitles)({
        Name = "Snuffy",
        Icon = ""
    });
    local u4 = {};
    local u5 = nil;

    local function hideFieldObject(p6) -- Line: 23
        -- upvalues: u4 (copy)
        local v7 = p6:IsA("BasePart") and "LocalTransparencyModifier" or ((p6:IsA("Texture") or p6:IsA("Decal")) and "Transparency" or nil);

        if v7 and not u4[p6] then
            u4[p6] = { v7, p6[v7] };
            p6[v7] = 1;
        end;
    end;

    local v8, v9 = xpcall(function() -- Line: 36
        -- upvalues: u5 (ref), hideFieldObject (copy), CutsceneUtils (ref), u1 (copy), u2 (copy), u3 (copy)
        local Field = workspace:FindFirstChild("Field");

        if Field then
            u5 = Field.DescendantAdded:Connect(hideFieldObject);
            hideFieldObject(Field);

            for _, descendant in Field:GetDescendants() do
                hideFieldObject(descendant);
            end;
        end;

        CutsceneUtils.ChangeLighting(script.LightingConfig);
        CutsceneUtils.PlayCutscene({
            MoonFileName = "SnuffyAwk",
            Length = 9,
            Character = u1,
            CharsToReplace = u2,
            CodeEvents = script.CodeEvents,
            Subtitles = u3,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);

    if u5 then
        u5:Disconnect();
    end;

    for i, v in u4 do
        if i.Parent then
            i[v[1]] = v[2];
        end;
    end;

    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);

    if not v8 then
        warn("[SnuffyAwk] " .. tostring(v9));
    end;
end;