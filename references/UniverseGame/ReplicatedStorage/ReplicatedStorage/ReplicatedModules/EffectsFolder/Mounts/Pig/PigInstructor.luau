  

 

local RunService = game:GetService("RunService");
game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = nil;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u2 = {};
local u3 = newproxy();
Knit:OnStart():andThen(function() -- Line: 15
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("MountService");
end);
local u5 = {
    __index = {
        Destroy = function(p4) -- Line: 20, Name: Destroy
            p4.Trove:Destroy();
        end
    }
};
local u9 = { function(p6, p7, p8) -- Line: 28
        p6.Goal.X = p7;
        p6.Goal.Y = p8;
    end };

local function u29(u10, p11, ...) -- Line: 34
    -- upvalues: u2 (copy), u3 (copy), Trove (copy), LocalPlayer (copy), RunService (copy), u29 (ref), u1 (ref), u5 (copy), u9 (copy)
    local u12 = u2[u10];

    if u12 == u3 then
        return;
    end;

    if p11 == nil then
        if u12 then
            u12:Destroy();
            u2[u10] = nil;
        end;

        return;
    end;

    if not u12 then
        u2[u10] = u3;
        local Pig = u10:WaitForChild("Pig", 0.75);

        if not Pig then
            u2[u10] = nil;

            return;
        end;

        u12 = {
            StepConnection = nil,
            Character = u10,
            Mount = Pig,
            Root = Pig:WaitForChild("BikeRoot"),
            Head = Pig.BikeRoot:WaitForChild("PigBody"):WaitForChild("PigHead"),
            Trove = Trove.new(),
            Current = {
                X = 0,
                Y = 0
            },
            Goal = {
                X = 0,
                Y = 0
            }
        };

        if u2[u10] ~= nil and u2[u10] ~= u3 then
            return;
        end;

        local u13 = LocalPlayer.Character == u10;
        local u14 = 0;
        u12.Trove:Add(RunService.PreSimulation:Connect(function(p15) -- Line: 71
            -- upvalues: u10 (copy), u12 (ref), u2 (ref), u13 (copy), u29 (ref), u14 (ref), u1 (ref)
            if not u10:IsDescendantOf(workspace) then
                u12:Destroy();
                u2[u10] = nil;
            end;

            local v16 = u12.Goal.X - u12.Current.X;
            local v17 = math.sign(v16);
            local v18 = math.abs(v16);
            u12.Current.X = u12.Current.X + math.min(p15 * 180, v18) * v17;
            local v19 = u12.Goal.Y - u12.Current.Y;
            local v20 = math.sign(v19);
            local v21 = math.abs(v19);
            u12.Current.Y = u12.Current.Y + math.min(p15 * 180, v21) * v20;
            local Head = u12.Head;
            Head.Transform = Head.Transform * CFrame.fromEulerAngles(math.rad(u12.Current.X), 0, math.rad(u12.Current.Y), Enum.RotationOrder.YZX);

            if u13 then
                local v22, v23, _ = u10.HumanoidRootPart.CFrame:ToObjectSpace(workspace.CurrentCamera.CFrame):ToEulerAngles(Enum.RotationOrder.YXZ);
                local v24 = math.deg(-v22);
                local v25 = math.clamp(v24, -45, 45);
                local v26 = math.deg(-v23);
                local v27 = math.clamp(v26, -65, 65);
                u29(u10, 0, v25, v27);

                if u14 < os.clock() then
                    u14 = os.clock() + 0.05;
                    u1.MountUnreliableInstruction:Fire(0, v25, v27);
                end;
            end;
        end));
        u12.Trove:Add(u12.Character:GetAttributeChangedSignal("Mount"):Connect(function() -- Line: 98
            -- upvalues: u12 (ref), u2 (ref), u10 (copy)
            if u12.Character:GetAttribute("Mount") ~= "Pig" then
                u12:Destroy();
                u2[u10] = nil;
            end;
        end));
        setmetatable(u12, u5);
        u2[u10] = u12;
    end;

    local v28 = u12 and u9[p11];

    if v28 then
        v28(u12, ...);
    end;
end;

return u29;