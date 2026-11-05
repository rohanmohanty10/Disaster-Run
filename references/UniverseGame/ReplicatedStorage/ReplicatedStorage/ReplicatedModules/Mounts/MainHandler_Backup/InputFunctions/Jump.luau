  

 

local UserInputService = game:GetService("UserInputService");
local v1 = {
    Name = "Jump",
    Cooldown = 0.5,
    Charge = 0,
    CHARGE_RATE = 6,
    MAX_CHARGE = 25,
    START_CHARGE = 10,
    Keybind = Enum.KeyCode.Space,
    Overrides = {}
};

for _, child in pairs(script.Overrides:GetChildren()) do
    v1.Overrides[child.Name] = require(child);
end;

function v1.Start(p2, p3, u4, p5, p6) -- Line: 21
    -- upvalues: UserInputService (copy)
    p2.Charge = p2.START_CHARGE;
    p2.Character = u4;
    p2.Animator = p3;
    p2.Trove = p5;
    p2.RefValue = p6;
    local v7;

    if u4:GetAttribute("Mount") and p2.Overrides[u4:GetAttribute("Mount")] then
        v7 = p2.Overrides[u4:GetAttribute("Mount")];
    else
        v7 = nil;
    end;

    local v8;

    if v7 then
        v8 = typeof(v7) == "table";
    else
        v8 = v7;
    end;

    if not (v8 and v7.BypassCharge) then
        p2.Track = p3:PlayAnimation("Jump", 0);
        u4:SetAttribute("BikeAccelMultiplier", -0.1);
        p5:Add(function() -- Line: 41
            -- upvalues: u4 (copy)
            u4:SetAttribute("BikeAccelMultiplier", nil);
        end);
        script.Charge:Play();
        local v9 = p5:Clone(script.ChargeBar);
        v9.Parent = u4.HumanoidRootPart;
        local v10 = false;

        while true do
            local v11 = task.wait();
            p2.Charge = p2.Charge + p2.CHARGE_RATE * v11;
            v9.Background.Bar.Size = UDim2.new(1, 0, (p2.Charge - p2.START_CHARGE) / (p2.MAX_CHARGE - p2.START_CHARGE), 0);

            if p2.Charge >= p2.MAX_CHARGE and not v10 then
                script.FullCharge:Play();
                v10 = true;
            end;

            if UserInputService.TouchEnabled then
                if p6 and p6.Value == false then
                    break;
                end;
            elseif not UserInputService:IsKeyDown(p2.Keybind) then
                break;
            end;

            if not (u4:IsDescendantOf(game) and u4:GetAttribute("Mount")) then
                break;
            end;
        end;
    end;

    if u4:IsDescendantOf(game) or not u4:GetAttribute("Mount") then
        if p2.Charge <= 0 then
            p2.Charge = p2.CHARGE_RATE;
        end;

        p2.Charge = math.clamp(p2.Charge, p2.START_CHARGE, p2.MAX_CHARGE);

        if v8 and v7.OnJump then
            if v7.Yield then
                v7.OnJump(p2);
            else
                task.spawn(v7.OnJump, p2);
            end;
        end;

        if v8 and v7.BypassJump then
            return;
        end;

        if p2.Track then
            p2.Track:AdjustSpeed(1);
        end;

        u4.HumanoidRootPart:ApplyImpulse((Vector3.new(0, p2.Charge * 100, 0)));
    end;
end;

function v1.Stop(p12, p13, p14, p15) -- Line: 103
    script.Charge:Stop();
    script.FullCharge:Stop();
end;

function v1.Check(p16, p17, p18) -- Line: 108
    local v19 = p18:GetAttribute("Mount");

    if p16.Overrides and (v19 and (p16.Overrides[v19] and p16.Overrides[v19].Check)) then
        return p16.Overrides[v19].Check(p17, p18);
    end;

    local v20 = p17:OnGround() and p18:GetAttribute("MountType") ~= "Hoverboard";

    return v20;
end;

return v1;