  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local ObserveTag = require(ReplicatedStorage.ClientLibrary.ObserveTag);

local function FormatTime(p1) -- Line: 6
    return string.format("%02d:%02d", math.floor(p1 / 60), p1 % 60);
end;

return function(u2) -- Line: 10
    -- upvalues: RunService (copy), CollectionService (copy), ObserveTag (copy)
    local Parent = script.Parent;
    local u3 = require(u2.Knit.Util.Trove).new();
    local u4 = -1;
    local u5 = -1;
    local u6 = -1;
    RunService.PostSimulation:Connect(function(p7) -- Line: 18
        -- upvalues: u2 (copy), CollectionService (ref), Parent (copy), u4 (ref), u5 (ref), u6 (ref)
        if not u2.Character then
            return;
        end;

        if CollectionService:HasTag(u2.Character, "WOUPilot") and not u2.Character:GetAttribute("Revived") then
            local PilotTimer = Parent.PilotTimer;
            local v8;

            if u2.Character:GetAttribute("URF") then
                v8 = "INF";
            else
                local v9 = (u2.Character:GetAttribute("PilotMaxDuration") or 45) - (os.clock() - u4);
                v8 = string.format("%02d:%02d", math.floor(v9 / 60), v9 % 60);
            end;

            PilotTimer.Text = `PILOT - {v8}`;
        end;

        if u2.Character:GetAttribute("Apparition") then
            local Apparition = Parent.Apparition;
            local v10 = (u2.Character:GetAttribute("ApparitionMaxDuration") or 25) - (os.clock() - u5);
            Apparition.Text = `APPARITION - {string.format("%02d:%02d", math.floor(v10 / 60), v10 % 60)}`;
        end;

        if u2.Character:GetAttribute("EvasiveCalamityCooldown") and Parent:FindFirstChild("EvasiveCooldown") then
            local v11 = 35 - (os.clock() - u6);

            if v11 > 0 then
                local EvasiveCooldown = Parent.EvasiveCooldown;
                local v12 = math.max(0, v11);
                EvasiveCooldown.Text = `EVASIVE CD - {string.format("%02d:%02d", math.floor(v12 / 60), v12 % 60)}`;
            end;
        end;
    end);

    local function CharacterAdded(p13) -- Line: 39
        -- upvalues: u3 (copy), u2 (copy), ObserveTag (ref), u4 (ref), Parent (copy), u5 (ref), u6 (ref)
        u3:Clean();
        local v14 = os.clock();

        while not u2.Character:GetAttribute("WOU_UI_S") and os.clock() - v14 < 10 do
            task.wait(0.1);
        end;

        u3:Add(ObserveTag("WOUPilot", function(p15) -- Line: 48
            -- upvalues: u2 (ref), u4 (ref), Parent (ref)
            if p15 ~= u2.Character then
                return function() -- Line: 50
                end;
            end;

            if u2.Character:GetAttribute("Revived") then
                return function() -- Line: 56
                end;
            end;

            u4 = os.clock();
            Parent.PilotTimer.Visible = true;

            return function() -- Line: 63
                -- upvalues: Parent (ref)
                Parent.PilotTimer.Visible = false;
            end;
        end));
        u3:Connect(u2.Character:GetAttributeChangedSignal("Revived"), function() -- Line: 68
            -- upvalues: Parent (ref)
            Parent.PilotTimer.Visible = false;
        end);
        u3:Connect(u2.Character:GetAttributeChangedSignal("Apparition"), function() -- Line: 72
            -- upvalues: u2 (ref), Parent (ref), u5 (ref)
            local v16 = u2.Character:GetAttribute("Apparition");
            Parent.Apparition.Visible = v16;

            if not v16 then
                return;
            end;

            u5 = os.clock();
        end);
        u3:Connect(u2.Character:GetAttributeChangedSignal("EvasiveCalamityCooldown"), function() -- Line: 84
            -- upvalues: u2 (ref), Parent (ref), u6 (ref)
            local v17 = u2.Character:GetAttribute("EvasiveCalamityCooldown");
            Parent.EvasiveCooldown.Visible = v17;

            if not v17 then
                return;
            end;

            u6 = os.clock();
        end);
    end;

    if u2.Character then
        CharacterAdded(u2.Character);
    end;

    u2.Player.CharacterAdded:Connect(CharacterAdded);
end;