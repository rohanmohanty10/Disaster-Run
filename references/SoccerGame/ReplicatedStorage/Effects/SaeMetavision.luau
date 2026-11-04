  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local Color = workspace.Field.Field.Color;

return function(p1) -- Line: 13
    -- upvalues: RunService (copy), ReplicatedStorage (copy), Color (copy)
    local v2 = p1 and p1.Duration or 15;
    local u3 = script.saemetavisionvfxpart:Clone();
    u3.Parent = workspace;
    workspace.Field.Field.Color = Color3.new(0, 0, 0);
    local u4 = {};
    local u5 = RunService.RenderStepped:Connect(function() -- Line: 23
        -- upvalues: ReplicatedStorage (ref), u4 (copy)
        local Value = ReplicatedStorage.Football.Value;

        if Value.Parent == workspace then
            for _, v in u4 do
                v:Destroy();
            end;

            local Highlight = Value:FindFirstChild("Highlight");

            if Highlight then
                Highlight.FillColor = Color3.new(0.984314, 1, 0);
            end;
        elseif Value.Parent:FindFirstChild("Humanoid") then
            local Parent = Value.Parent;

            if not Parent:FindFirstChild("MetavisionHighlightIsagi") then
                local Highlight = Instance.new("Highlight");
                Highlight.FillColor = Color3.new(1, 0.968627, 0);
                Highlight.FillTransparency = 0.5;
                Highlight.Name = "MetavisionHighlightIsagi";
                Highlight.Parent = Parent;
                table.insert(u4, Highlight);
            end;
        end;
    end);
    task.delay(v2, function() -- Line: 51
        -- upvalues: u3 (copy), Color (ref), u5 (ref), u4 (copy), ReplicatedStorage (ref)
        u3:Destroy();
        workspace.Field.Field.Color = Color;
        u5:Disconnect();

        for _, v in u4 do
            v:Destroy();
        end;

        local Highlight = ReplicatedStorage.Football.Value:FindFirstChild("Highlight");

        if Highlight then
            Highlight.FillColor = Color3.new(1, 1, 1);
        end;
    end);
end;