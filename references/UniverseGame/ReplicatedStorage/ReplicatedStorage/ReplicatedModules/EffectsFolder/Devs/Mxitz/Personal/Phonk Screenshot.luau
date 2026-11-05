  

 

local u1 = { "💀", "🤣", "😂", "🤯", "🥶", "😳" };
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local CaptureService = game:GetService("CaptureService");
local Lighting = game:GetService("Lighting");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p2) -- Line: 16
    -- upvalues: Trove (copy), Lighting (copy), CaptureService (copy), u1 (copy), LocalPlayer (copy)
    local u3 = Trove.new();
    local u4 = (p2 or {}).Duration or 1.5;
    local v5 = u3:Clone(script.ColorCorrection);
    local u6 = u3:Clone(script.Interface);
    v5.Parent = Lighting;
    u3:Add(task.delay(u4 * 3, function() -- Line: 28
        -- upvalues: u3 (copy)
        u3:Destroy();
    end));
    CaptureService:CaptureScreenshot(function(p7) -- Line: 32
        -- upvalues: u6 (copy), u1 (ref), LocalPlayer (ref), u3 (copy), u4 (copy)
        u6.Emoji.Text = `{u1[Random.new():NextInteger(1, #u1)]}`;
        u6.Screenshot.Image = p7;
        u6.Parent = LocalPlayer.PlayerGui;
        u3:Add(task.delay(u4, function() -- Line: 37
            -- upvalues: u3 (ref)
            u3:Destroy();
        end));
    end);
end;