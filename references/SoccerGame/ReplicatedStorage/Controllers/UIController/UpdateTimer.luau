  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local v1 = Knit.CreateController({
    Name = "UpdateTimer"
});

function v1.KnitStart(p2) -- Line: 9
    -- upvalues: FormatNumber (copy)
    local BillboardGui = workspace.UpdateTimer.BillboardGui;

    local function update() -- Line: 11
        -- upvalues: BillboardGui (copy), FormatNumber (ref)
        workspace:GetAttribute("updateTimerEndsAfter");
        local Attribute = workspace:GetAttribute("updateTimer");
        local Attribute2 = workspace:GetAttribute("updateTimerMidText");
        local Attribute3 = workspace:GetAttribute("updateTimerTopText");

        if not (Attribute and (Attribute2 and Attribute3)) then
            BillboardGui.Enabled = false;

            return;
        end;

        BillboardGui.Enabled = true;
        BillboardGui.MidText.Text = Attribute2;
        BillboardGui.TopText.Text = Attribute3;
        local v3 = Attribute - workspace:GetServerTimeNow();

        if v3 < 1 then
            BillboardGui.Timer.Text = "NOW";

            return;
        end;

        if v3 < 86400 then
            BillboardGui.Timer.Text = FormatNumber.AdaptiveClockString(v3);

            return;
        end;

        local v4 = v3 // 86400;
        local math_floor_ret = math.floor(v3 % 86400 / 3600);

        if math_floor_ret == 0 then
            BillboardGui.Timer.Text = `{math.floor(v4)} DAYS`;

            return;
        end;

        BillboardGui.Timer.Text = `{math.floor(v4)} DAYS {math.floor(math_floor_ret)} HOURS`;
    end;

    task.spawn(function() -- Line: 53
        -- upvalues: update (copy)
        while true do
            update();
            task.wait(1);
        end;
    end);
end;

return v1;