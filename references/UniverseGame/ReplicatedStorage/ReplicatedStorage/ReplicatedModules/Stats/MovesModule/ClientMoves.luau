  

 

local v1 = {};
local u2 = { 550 };

function v1.Flight(u3, p4) -- Line: 8
    -- upvalues: u2 (copy)
    if not table.find(u2, u3.Data.Ability.Value) then
        return;
    end;

    local HumanoidRootPart = u3.Character.HumanoidRootPart;
    u3.Character.HumanoidRootPart.CFrame = u3.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, 0);
    local u5 = {
        F = 0,
        B = 0,
        L = 0,
        R = 0
    };
    local u6 = {
        F = 0,
        B = 0,
        L = 0,
        R = 0
    };
    local u7 = p4;
    local v8 = u3:GetMouse();

    local function FLY() -- Line: 23
        -- upvalues: HumanoidRootPart (copy), u5 (ref), u7 (ref), u6 (ref), u3 (copy)
        local BodyGyro = Instance.new("BodyGyro", HumanoidRootPart);
        local BodyVelocity = Instance.new("BodyVelocity", HumanoidRootPart);
        BodyGyro.P = 10000;
        BodyGyro.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
        BodyGyro.cframe = HumanoidRootPart.CFrame;
        BodyVelocity.velocity = Vector3.new(0, 0.1, 0);
        BodyVelocity.maxForce = Vector3.new(9000000000, 9000000000, 9000000000);
        spawn(function() -- Line: 33
            -- upvalues: u5 (ref), u7 (ref), BodyVelocity (copy), u6 (ref), BodyGyro (copy), u3 (ref)
            while true do
                wait();

                if u5.L + u5.R == 0 and u5.F + u5.B == 0 then
                    if u5.L + u5.R == 0 and (u5.F + u5.B == 0 and u7 ~= 0) then
                        u7 = 0;
                    end;
                else
                    u7 = 50;
                end;

                if u5.L + u5.R == 0 and u5.F + u5.B == 0 then
                    if u5.L + u5.R == 0 and (u5.F + u5.B == 0 and u7 ~= 0) then
                        BodyVelocity.velocity = (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (u6.F + u6.B) + (game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(u6.L + u6.R, (u6.F + u6.B) * 0.2, 0).p - game.Workspace.CurrentCamera.CoordinateFrame.p)) * u7;
                    else
                        BodyVelocity.velocity = Vector3.new(0, 0, 0);
                    end;
                else
                    BodyVelocity.velocity = (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (u5.F + u5.B) + (game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(u5.L + u5.R, (u5.F + u5.B) * 0.2, 0).p - game.Workspace.CurrentCamera.CoordinateFrame.p)) * u7;
                    u6 = {
                        F = u5.F,
                        B = u5.B,
                        L = u5.L,
                        R = u5.R
                    };
                end;

                BodyGyro.cframe = game.Workspace.CurrentCamera.CoordinateFrame;

                if not game:GetService("CollectionService"):HasTag(u3.Character, "FLIGHT") then
                    u5 = {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0
                    };
                    u6 = {
                        F = 0,
                        B = 0,
                        L = 0,
                        R = 0
                    };
                    u7 = 0;
                    BodyGyro:destroy();
                    BodyVelocity:destroy();

                    return;
                end;
            end;
        end);
    end;

    v8.KeyDown:connect(function(p9) -- Line: 58
        -- upvalues: u5 (ref)
        if p9:lower() == "w" then
            u5.F = 1;

            return;
        end;

        if p9:lower() == "s" then
            u5.B = -1;

            return;
        end;

        if p9:lower() == "a" then
            u5.L = -1;

            return;
        end;

        if p9:lower() == "d" then
            u5.R = 1;
        end;
    end);
    v8.KeyUp:connect(function(p10) -- Line: 70
        -- upvalues: u5 (ref)
        if p10:lower() == "w" then
            u5.F = 0;

            return;
        end;

        if p10:lower() == "s" then
            u5.B = 0;

            return;
        end;

        if p10:lower() == "a" then
            u5.L = 0;

            return;
        end;

        if p10:lower() == "d" then
            u5.R = 0;
        end;
    end);
    FLY();
end;

return v1;