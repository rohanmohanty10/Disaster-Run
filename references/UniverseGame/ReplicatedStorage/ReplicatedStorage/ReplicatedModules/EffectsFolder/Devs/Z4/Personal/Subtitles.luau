  

 

game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local u1 = game.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui");

return function(p2) -- Line: 11
    -- upvalues: TableUtil (copy), u1 (copy)
    local v3 = p2 or {};
    local Text = v3.Text;

    if not Text or typeof(Text) ~= "string" then
        return;
    end;

    local v4 = v3.Duration or 0.25;
    local v5 = v3.Speed or 1;
    local v6 = TableUtil.Reconcile(v3.PauseTimes or {}, {
        ["."] = 1,
        [","] = 0.5,
        ["!"] = 0.5,
        ["?"] = 0.5
    });
    local v7 = TableUtil.Reconcile(v3.Size or {}, {
        Maximum = 25,
        Minimum = 1
    });
    local v8 = v3.Gradient or ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 85)) });
    local Extra = u1.Extra;
    local ScreenImages = Extra.ScreenImages;
    local Text2 = ScreenImages.ShadowText.Text;
    local u9;

    if Extra.Enabled then
        u9 = false;
    else
        Extra.Enabled = true;
        u9 = true;
    end;

    ScreenImages.Enabled = true;
    Text2.Text = "";
    Text2.Visible = true;
    Text2:FindFirstChild("UIGradient").Color = v8;
    Text2:FindFirstChild("UITextSizeConstraint").MinTextSize = v7.Minimum;
    Text2:FindFirstChild("UITextSizeConstraint").MaxTextSize = v7.Maximum;

    for i = 1, #Text do
        Text2.Text = string.sub(Text, 1, i);
        local v10 = string.sub(Text, i, i);

        if v6[v10] then
            task.wait(v6[v10]);
        else
            task.wait(1 / v5 / 15);
        end;
    end;

    task.delay(v4, function() -- Line: 70
        -- upvalues: u9 (ref), Extra (copy), Text2 (copy), ScreenImages (copy)
        if not u9 then
            Extra.Enabled = false;
        end;

        Text2.Text = "";
        Text2.Visible = false;
        ScreenImages.Enabled = false;
    end);
end;