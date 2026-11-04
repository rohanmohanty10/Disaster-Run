 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local PsychoBar = LocalPlayer.PlayerGui:WaitForChild("InGame").BG.Bars.PsychoBar;

return function(p1) -- Line: 11
    -- upvalues: LocalPlayer (copy), PsychoBar (copy), Knit (copy), Trove (copy), TweenService (copy)
    LocalPlayer.Style.Changed:Connect(function() -- Line: 12
        -- upvalues: LocalPlayer (ref), PsychoBar (ref)
        PsychoBar.Visible = LocalPlayer.Style.Value == "Cyber" and true or LocalPlayer.Style.Value == "OGCyber";
    end);
    PsychoBar.Visible = LocalPlayer.Style.Value == "Cyber" and true or LocalPlayer.Style.Value == "OGCyber";
    local Controller = Knit.GetController("AbilityController");
    local Controller2 = Knit.GetController("MovementController");
    local u2 = Trove.new();

    local function Update() -- Line: 29
        -- upvalues: u2 (copy), LocalPlayer (ref), Controller (copy), Controller2 (copy), PsychoBar (ref), TweenService (ref)
        u2:Clean();
        local v3 = LocalPlayer:GetAttribute("PsychoBar") or 0;
        local math_min_ret = math.min(v3, 100);

        if math_min_ret ~= -1 then
            PsychoBar.Bar.InnerText.Text = `PSYCHO BAR {math.round(math_min_ret)}%`;
            TweenService:Create(PsychoBar.Bar.UIGradient, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Offset = Vector2.new(math_min_ret / 100 - 0.7, 0)
            }):Play();

            return;
        end;

        Controller.ArmImplant = nil;
        Controller2.ExtraBoosts = {};
        PsychoBar.Bar.UIGradient.Offset = Vector2.xAxis * 0.3;
        PsychoBar.Bar.InnerText.Text = "!! DISCHARGING !!";
        TweenService:Create(PsychoBar.Bar.UIGradient, TweenInfo.new(LocalPlayer:GetAttribute("PsychoBarTime") or 7, Enum.EasingStyle.Linear), {
            Offset = Vector2.new(math_min_ret / 100 - 0.7, 0)
        }):Play();
    end;

    task.spawn(Update);
    LocalPlayer:GetAttributeChangedSignal("PsychoBar"):Connect(Update);
end;