  

 

local UserInputService = game:GetService("UserInputService");
local u1 = {
    [Enum.KeyCode.Space] = Enum.KeyCode.ButtonA
};
local v2 = {
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
    v2.Overrides[child.Name] = require(child);
end;

function v2.Start(p3, p4, u5, p6, p7) -- Line: 25
    -- upvalues: UserInputService (copy), u1 (copy)
    p3.Charge = p3.START_CHARGE;
    p3.Character = u5;
    p3.Animator = p4;
    p3.Trove = p6;
    p3.RefValue = p7;
    local v8;

    if u5:GetAttribute("Mount") and p3.Overrides[u5:GetAttribute("Mount")] then
        v8 = p3.Overrides[u5:GetAttribute("Mount")];
    else
        v8 = nil;
    end;

    local v9;

    if v8 then
        v9 = typeof(v8) == "table";
    else
        v9 = v8;
    end;

    if not (v9 and v8.BypassCharge) then
        p3.Track = p4:PlayAnimation("Jump", 0);
        u5:SetAttribute("BikeAccelMultiplier", -0.1);
        p6:Add(function() -- Line: 45
            -- upvalues: u5 (copy)
            u5:SetAttribute("BikeAccelMultiplier", nil);
        end);
        script.Charge:Play();
        local v10 = p6:Clone(script.ChargeBar);
        v10.Parent = u5.HumanoidRootPart;
        local v11 = false;

        while true do
            local v12 = task.wait();
            p3.Charge = p3.Charge + p3.CHARGE_RATE * v12;
            v10.Background.Bar.Size = UDim2.new(1, 0, (p3.Charge - p3.START_CHARGE) / (p3.MAX_CHARGE - p3.START_CHARGE), 0);

            if p3.Charge >= p3.MAX_CHARGE and not v11 then
                script.FullCharge:Play();
                v11 = true;
            end;

            if UserInputService.TouchEnabled then
                if p7 and p7.Value == false then
                    break;
                end;
            else
                local v13 = not UserInputService:IsKeyDown(p3.Keybind);

                if v13 == true and (u1[p3.Keybind] and (UserInputService:IsKeyDown(u1[p3.Keybind]) or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, u1[p3.Keybind]))) then
                    v13 = false;
                end;

                if v13 == true then
                    break;
                end;
            end;

            if not (u5:IsDescendantOf(game) and u5:GetAttribute("Mount")) then
                break;
            end;
        end;
    end;

    if u5:IsDescendantOf(game) or not u5:GetAttribute("Mount") then
        if p3.Charge <= 0 then
            p3.Charge = p3.CHARGE_RATE;
        end;

        p3.Charge = math.clamp(p3.Charge, p3.START_CHARGE, p3.MAX_CHARGE);

        if v9 and v8.OnJump then
            if v8.Yield then
                v8.OnJump(p3);
            else
                task.spawn(v8.OnJump, p3);
            end;
        end;

        if v9 and v8.BypassJump then
            return;
        end;

        if p3.Track then
            p3.Track:AdjustSpeed(1);
        end;

        u5.HumanoidRootPart:ApplyImpulse((Vector3.new(0, p3.Charge * 100, 0)));
    end;
end;

function v2.Stop(p14, p15, p16, p17) -- Line: 113
    script.Charge:Stop();
    script.FullCharge:Stop();
end;

function v2.Check(p18, p19, p20) -- Line: 118
    local v21 = p20:GetAttribute("Mount");

    if p18.Overrides and (v21 and (p18.Overrides[v21] and p18.Overrides[v21].Check)) then
        return p18.Overrides[v21].Check(p19, p20);
    end;

    local v22 = p19:OnGround() and p20:GetAttribute("MountType") ~= "Hoverboard";

    return v22;
end;

return v2;