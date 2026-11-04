 

 

local RunService = game:GetService("RunService");
local AnimationConfig = require(script.Parent.AnimationConfig);
local v1 = {};
local u2 = nil;

function v1.prepare() -- Line: 6
    -- upvalues: u2 (ref), AnimationConfig (copy), RunService (copy)
    if u2 then
        return u2;
    end;

    local u3 = {};

    if not AnimationConfig.Enabled then
        u2 = u3;

        return u2;
    end;

    local Clips = script.Parent:FindFirstChild("Clips");

    local function add(p4, p5, p6) -- Line: 11
        -- upvalues: u3 (copy), AnimationConfig (ref)
        if type(p5) ~= "string" or p5 == "" then
            return;
        end;

        local Animation = Instance.new("Animation");
        Animation.Name = "CoH_" .. p4;
        Animation.AnimationId = p5;
        u3[p4] = {
            animation = Animation,
            length = AnimationConfig.ClipLengths and AnimationConfig.ClipLengths[p4] or (p6 and p6:GetAttribute("Duration") or 1)
        };
    end;

    for i, v in AnimationConfig.PublishedIds do
        local v7;

        if Clips then
            v7 = Clips:FindFirstChild(i);
        else
            v7 = Clips;
        end;

        add(i, v, v7);
    end;

    if Clips and RunService:IsStudio() then
        for _, child in Clips:GetChildren() do
            local v8 = AnimationConfig.StudioPreview or AnimationConfig.StudioPreviewClips and AnimationConfig.StudioPreviewClips[child.Name];

            if child:IsA("KeyframeSequence") and (not u3[child.Name] and v8) then
                local success, result = pcall(function() -- Line: 22
                    -- upvalues: child (copy)
                    return game:GetService("AnimationClipProvider"):RegisterAnimationClip(child);
                end);

                if success then
                    add(child.Name, result, child);
                else
                    warn("Animation preview unavailable:", child.Name, result);
                end;
            end;
        end;
    end;

    u2 = u3;

    return u3;
end;

return v1;